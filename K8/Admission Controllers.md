---
tags:
  - k8
---

### **What are Admission Controllers?**

Admission controllers are pieces of code within the Kubernetes **API server** that intercept and process API requests **after authentication and authorization** but **before the requested operation is persisted** in the cluster. They ensure that only valid and compliant requests are executed.

Admission controllers perform two key actions:
1. **Mutating**: Modify objects in a request (e.g., adding default values).
2. **Validating**: Validate requests to ensure compliance with policies.

---

### **Why Are Admission Controllers Important?**

- Enforce policies and governance in the cluster.
- Modify or enrich resources (e.g., adding default labels, tolerations, or storage classes).
- Prevent misconfigurations and security risks.
- Support critical Kubernetes features like namespaces, quotas, and default settings.

---

### **How Admission Controllers Work**

#### **Processing Phases:**
1. **Mutating Phase**:
   - Mutating admission controllers run first.
   - They can modify the request object to add defaults, labels, or other fields.
   - Example: `MutatingAdmissionWebhook`.

2. **Validating Phase**:
   - Validating admission controllers run after mutating controllers.
   - They validate the request and can reject it if it doesn't comply with cluster policies.
   - Example: `ValidatingAdmissionWebhook`.

#### **Request Lifecycle**:
- A user sends an API request.
- The request is authenticated and authorized.
- Admission controllers intercept the request:
  - **Mutating controllers** first.
  - **Validating controllers** second.
- If any controller rejects the request, an error is returned, and the request is not processed further.

---

### **Types of Admission Controllers**

1. **Default Admission Controllers**:
   - Enabled by default in Kubernetes.
   - Provide basic functionality, such as namespace lifecycle management, quotas, and security.

2. **Custom Admission Controllers**:
   - Created using webhooks (`MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook`).
   - Allow users to define custom policies and mutations tailored to their specific needs.

---

### **Configuring Admission Controllers**

#### **Enable Admission Controllers**:
To enable specific admission controllers:
```bash
kube-apiserver --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ResourceQuota,...
```

#### **Disable Admission Controllers**:
To disable admission controllers:
```bash
kube-apiserver --disable-admission-plugins=PodNodeSelector,...
```

#### **View Enabled Admission Controllers**:
```bash
kube-apiserver -h | grep enable-admission-plugins
```

---

### **Default Admission Controllers (Kubernetes 1.31)**

Here are some of the most commonly used default admission controllers:

#### **NamespaceLifecycle**:
- Ensures objects cannot be created in non-existent or terminating namespaces.
- Protects system namespaces (`default`, `kube-system`, `kube-public`) from deletion.

#### **LimitRanger**:
- Enforces constraints defined in `LimitRange` objects (e.g., CPU and memory limits).
- Adds default resource requests and limits to Pods without explicit settings.

#### **ResourceQuota**:
- Ensures a namespace's resource usage doesn't exceed its defined quotas.
- Required for managing cluster resource usage.

#### **ServiceAccount**:
- Automates the attachment of ServiceAccounts to Pods.
- Ensures that referenced Secrets are valid and available.

#### **PodSecurity**:
- Validates Pods against Pod Security Standards based on namespace labels.

#### **MutatingAdmissionWebhook**:
- Invokes external webhooks for mutating requests.
- Allows for custom logic to modify Kubernetes resources.

#### **ValidatingAdmissionWebhook**:
- Invokes external webhooks for validating requests.
- Ensures compliance with custom policies.

---

### **Custom Admission Controllers**

Kubernetes allows custom admission controllers via webhooks. These webhooks are triggered by the `MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook` controllers.

#### **Steps to Create a Custom Admission Controller**:
1. **Develop a Webhook Server**:
   - Write a service that listens for API server requests and processes them (e.g., adds a label or validates resource specs).

2. **Deploy the Webhook Server**:
   - Deploy the service in the Kubernetes cluster.

3. **Configure Webhooks**:
   - Use `MutatingWebhookConfiguration` or `ValidatingWebhookConfiguration` to register your webhook with the API server.

Example of a validating webhook configuration:
```yaml
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: example-webhook
webhooks:
  - name: validate.example.com
    clientConfig:
      service:
        name: example-webhook-service
        namespace: default
        path: /validate
      caBundle: <base64-encoded-ca-cert>
    rules:
      - apiGroups: [""]
        apiVersions: ["v1"]
        operations: ["CREATE", "UPDATE"]
        resources: ["pods"]
    admissionReviewVersions: ["v1"]
    sideEffects: None
```

---

### **Examples of Admission Controllers in Action**

#### **DefaultIngressClass**:
- Automatically assigns a default ingress class if none is specified.

#### **AlwaysPullImages**:
- Modifies Pods to always pull container images, ensuring multi-tenancy security.

#### **PodTolerationRestriction**:
- Validates and modifies tolerations to enforce node taint tolerations at the namespace or cluster level.

#### **ExtendedResourceToleration**:
- Automatically adds tolerations for Pods requesting extended resources (e.g., GPUs).

---

### **Considerations and Best Practices**

1. **Order Matters**:
   - Mutating controllers run before validating controllers.

2. **Test Carefully**:
   - Custom admission controllers can disrupt workloads if misconfigured.

3. **Performance**:
   - Admission controllers add latency. Ensure webhook services are highly available and responsive.

4. **Reconciliation**:
   - If a mutating webhook has side effects, ensure a reconciliation mechanism handles failures.

---

### **When to Use Admission Controllers**

- Enforcing resource constraints (e.g., CPU, memory, PIDs).
- Validating security policies (e.g., ensuring Pods use specific ServiceAccounts).
- Automating defaults (e.g., adding storage classes, tolerations, or ingress classes).
- Custom governance and compliance (e.g., enforcing naming conventions or validating image sources).

---

### **Learn More**
- Kubernetes Admission Controllers [Documentation](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/).
- Explore custom webhook implementations for advanced use cases.
