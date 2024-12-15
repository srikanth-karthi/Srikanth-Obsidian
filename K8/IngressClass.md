---
tags:
  - k8
---
### **IngressClass in Kubernetes**

An **IngressClass** is a Kubernetes resource that defines the configuration and behavior of an Ingress controller. It specifies which Ingress controller should handle a particular Ingress resource and provides a way to customize the controller's behavior through parameters.

IngressClass was introduced to allow users to manage multiple Ingress controllers within a single cluster more efficiently and to standardize how Ingress resources are associated with controllers.

---

### **Key Features of IngressClass**
1. **Controller Specification**:
   - Maps an Ingress resource to a specific Ingress controller.
   - Each IngressClass specifies a `controller` field that identifies the controller responsible for handling Ingress resources.

2. **Default IngressClass**:
   - A cluster can have one default IngressClass that applies to Ingress resources without an explicit `ingressClassName`.

3. **Custom Parameters**:
   - Allows customization of the Ingress controller behavior using additional parameters.
   - Parameters can be either cluster-scoped or namespace-scoped, depending on your requirements.

---

### **IngressClass Specification**

#### Example of an IngressClass:

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: nginx
  annotations:
    ingressclass.kubernetes.io/is-default-class: "true"  # Mark as default IngressClass
spec:
  controller: k8s.io/ingress-nginx  # Specifies the controller to use
  parameters:
    apiGroup: networking.example.com
    kind: IngressParameters
    name: example-config
```

- **`metadata.name`**: The name of the IngressClass (e.g., `nginx`).
- **`annotations.ingressclass.kubernetes.io/is-default-class`**:
  - Marks this IngressClass as the default for the cluster.
  - Ingresses without an explicit `ingressClassName` will use this default class.
- **`spec.controller`**:
  - Specifies the controller that implements this class.
  - Common examples include `k8s.io/ingress-nginx` or `example.com/custom-ingress-controller`.
- **`spec.parameters`**:
  - Points to additional configuration for the controller (optional).

---

### **Using IngressClass in an Ingress**

When creating an Ingress resource, you can reference the IngressClass by specifying the `ingressClassName` field. This ties the Ingress to a specific controller.

#### Example:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
spec:
  ingressClassName: nginx  # Use the "nginx" IngressClass
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: example-service
            port:
              number: 80
```

---

### **IngressClass Parameters**

The `parameters` field in an IngressClass lets you reference additional configuration for the controller. This can include things like:
- Load balancing policies
- Custom headers
- Logging levels

#### Cluster-Scoped Parameters:

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: external-lb
spec:
  controller: example.com/ingress-controller
  parameters:
    apiGroup: networking.example.com
    kind: LoadBalancerConfig
    name: global-config
```

#### Namespace-Scoped Parameters:

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: custom-namespace-lb
spec:
  controller: example.com/ingress-controller
  parameters:
    scope: Namespace  # Indicates the parameters are namespace-scoped
    apiGroup: networking.example.com
    kind: NamespaceConfig
    namespace: custom-namespace
    name: ns-config
```

---

### **Default IngressClass**

Marking an IngressClass as default allows Ingress resources without an `ingressClassName` to use it. This is useful when you have a single Ingress controller and want all Ingresses to automatically use it.

#### Example:

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: nginx
  annotations:
    ingressclass.kubernetes.io/is-default-class: "true"  # Mark as default
spec:
  controller: k8s.io/ingress-nginx
```

> **Note**: Only one IngressClass can be marked as default in a cluster. If multiple classes are marked as default, the cluster rejects any new Ingress resource without a specified `ingressClassName`.

---

### **Deprecated Annotation**

Before IngressClass was introduced, controllers used the annotation `kubernetes.io/ingress.class` in the Ingress resource to determine which controller should manage it. This method is now deprecated in favor of the `ingressClassName` field.

#### Example (deprecated):

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: example-service
            port:
              number: 80
```

---

### **Benefits of IngressClass**

1. **Multi-Controller Support**:
   - Allows multiple Ingress controllers to coexist in a single cluster.
   - Each controller can handle its own Ingress resources.

2. **Customizable Configurations**:
   - Parameters enable fine-grained control over controller behavior.

3. **Simplifies Ingress Management**:
   - The default IngressClass reduces the need for explicit configuration in Ingress resources.

4. **Future-Ready**:
   - Aligns with Kubernetes' approach of using Custom Resource Definitions (CRDs) and declarative management.

---

### **Conclusion**

IngressClass is an essential resource for managing Ingress in Kubernetes. It provides a standardized way to link Ingress resources to specific controllers, enabling multi-controller clusters and customizable configurations. By using IngressClass, you can efficiently organize and control traffic routing in your Kubernetes environment.