#k8

---

### **What are Network Policies?**

Network Policies in Kubernetes define rules for controlling network traffic flow at the **IP address** and **port level** (OSI Layer 3 and Layer 4) for TCP, UDP, and SCTP protocols. They provide a way to manage how Pods communicate:
- **Within the cluster** (Pod-to-Pod communication).
- **With external entities** (connections to/from external IPs).

Network Policies are application-centric, meaning they focus on the Pods and define how they can communicate with other Pods, namespaces, or IP ranges.

---

### **Key Features**

1. **Traffic Control**:
   - Manage ingress (incoming) and egress (outgoing) traffic for Pods.
   - Define allowed traffic based on Pod selectors, namespace selectors, or IP blocks.

2. **Isolation**:
   - Pods are isolated for ingress or egress traffic when a NetworkPolicy explicitly applies to them. Without a policy, all traffic is allowed by default.

3. **Additive Rules**:
   - Policies are additive. Multiple policies can apply to a Pod, and their effects combine.

---

### **Prerequisites**

- **CNI Plugin Support**:
  - Network policies are enforced by the network plugin (e.g., Calico, Cilium, Weave Net). Ensure your cluster uses a plugin that supports NetworkPolicy.
  - Creating a NetworkPolicy resource without a supporting plugin has no effect.

---

### **How Network Policies Work**

#### **Entities for Communication**
A NetworkPolicy can allow communication with:
1. **Other Pods**: Identified by `podSelector`.
2. **Namespaces**: Identified by `namespaceSelector`.
3. **IP Blocks**: Identified by CIDR ranges (`ipBlock`).

#### **Two Types of Isolation**
1. **Ingress Isolation**:
   - Controls what incoming traffic a Pod can accept.
   - Pods are isolated for ingress when a NetworkPolicy with `Ingress` applies to them.
   - Default: All incoming traffic is allowed unless restricted by a policy.

2. **Egress Isolation**:
   - Controls what outgoing traffic a Pod can send.
   - Pods are isolated for egress when a NetworkPolicy with `Egress` applies to them.
   - Default: All outgoing traffic is allowed unless restricted by a policy.

#### **Combination of Rules**
- For a connection to succeed:
  - **Ingress rules** at the destination Pod **and**
  - **Egress rules** at the source Pod must allow the connection.

---

### **Example NetworkPolicy**

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - ipBlock:
        cidr: 172.17.0.0/16
        except:
        - 172.17.1.0/24
    - namespaceSelector:
        matchLabels:
          project: myproject
    - podSelector:
        matchLabels:
          role: frontend
    ports:
    - protocol: TCP
      port: 6379
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
    ports:
    - protocol: TCP
      port: 5978
```

#### **Explanation**
1. **Pod Selector**:
   - Applies to Pods with the label `role=db` in the `default` namespace.
2. **Ingress Rules**:
   - Allows incoming traffic to TCP port `6379` from:
     - IP range `172.17.0.0/16` (excluding `172.17.1.0/24`).
     - Pods in namespaces with the label `project=myproject`.
     - Pods with the label `role=frontend`.
3. **Egress Rules**:
   - Allows outgoing traffic to TCP port `5978` for IP range `10.0.0.0/24`.

---

### **Default Behaviors**

#### **Without Network Policies**
- **Ingress**: All incoming traffic is allowed.
- **Egress**: All outgoing traffic is allowed.

#### **Default Deny Policy**
To deny all traffic:
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

---

### **Selectors in Network Policies**

1. **Pod Selector (`podSelector`)**:
   - Selects Pods in the same namespace based on labels.

2. **Namespace Selector (`namespaceSelector`)**:
   - Selects Pods in other namespaces based on namespace labels.

3. **IP Block (`ipBlock`)**:
   - Defines allowed IP ranges using CIDR notation.
   - Does not include cluster-internal Pod IPs.

4. **Combination**:
   - Combine `podSelector` and `namespaceSelector` to select Pods in specific namespaces.

---

### **Common Use Cases**

1. **Allow All Ingress Traffic**:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: allow-all-ingress
   spec:
     podSelector: {}
     policyTypes:
     - Ingress
     ingress:
     - {}
   ```

2. **Default Deny All Egress**:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: default-deny-egress
   spec:
     podSelector: {}
     policyTypes:
     - Egress
   ```

3. **Allow Traffic Between Namespaces**:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: allow-cross-namespace
   spec:
     podSelector:
       matchLabels:
         app: myapp
     policyTypes:
     - Ingress
     ingress:
     - from:
       - namespaceSelector:
           matchLabels:
             role: trusted
   ```

4. **Allow Traffic from Specific IP Block**:
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   metadata:
     name: allow-ip-block
   spec:
     podSelector:
       matchLabels:
         app: myapp
     policyTypes:
     - Ingress
     ingress:
     - from:
       - ipBlock:
           cidr: 192.168.1.0/24
           except:
           - 192.168.1.5/32
   ```

---

### **Limitations of Network Policies**

1. **No Deny Rules**:
   - Policies are inherently "allow" based. Explicit "deny" rules are not supported.

2. **Lack of Layer 7 Support**:
   - Cannot inspect application-level traffic (e.g., HTTP headers).

3. **Node Policies**:
   - Cannot directly target nodes by name or identity.

4. **HostNetwork Pods**:
   - Behavior with `hostNetwork` Pods depends on the network plugin.

5. **Existing Connections**:
   - Changes to policies may not affect already-established connections.

---

### **Best Practices**

1. **Use Namespaces**:
   - Apply `namespaceSelector` to isolate traffic between environments.

2. **Start with Default Deny**:
   - Create a default-deny policy to isolate Pods and add specific allow rules.

3. **Validate Plugin Support**:
   - Ensure your network plugin supports all desired features (e.g., `endPort`, SCTP).

4. **Test Policies**:
   - Use tools like `kubectl describe` or network simulators to validate configurations.

---

### **What's Next?**
- Learn more with Kubernetes [NetworkPolicy Recipes](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
- Explore advanced scenarios using tools like service meshes (e.g., Istio).

Let me know if you need further examples or clarification!

![[Pasted image 20241202152041.png]]