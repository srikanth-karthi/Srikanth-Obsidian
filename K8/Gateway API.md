---
tags:
  - k8
---
### **Gateway API in Kubernetes**

The **Gateway API** is a set of Kubernetes APIs designed to provide advanced traffic routing and dynamic infrastructure provisioning. It serves as the successor to the Ingress API, offering more flexibility, role-oriented design, and extensibility to handle diverse traffic management needs.

---

### **Key Features of Gateway API**
1. **Role-Oriented Design**:
   - Designed to align with organizational roles such as:
     - **Infrastructure Provider**: Manages cloud load balancers or other traffic management infrastructure.
     - **Cluster Operator**: Manages policies and network configurations within a Kubernetes cluster.
     - **Application Developer**: Focuses on application-level configurations and service composition.

2. **Portable**:
   - Implemented as custom resources supported by various controllers and platforms.

3. **Expressive**:
   - Supports advanced use cases such as header-based routing, traffic splitting, and more without relying on custom annotations.

4. **Extensible**:
   - Allows for granular customization via additional custom resources linked at various API levels.

---

### **Resource Model**

The Gateway API consists of the following primary resource kinds:

1. **GatewayClass**:
   - Defines a set of Gateways with shared configurations.
   - Specifies the controller managing the Gateways.

2. **Gateway**:
   - Represents an instance of traffic-handling infrastructure (e.g., load balancer, proxy server).
   - Configures listeners for incoming traffic.

3. **HTTPRoute**:
   - Defines HTTP-specific traffic routing rules from a Gateway to backends (e.g., Kubernetes Services).

These resources interact to form a role-oriented and extensible architecture for managing traffic in Kubernetes.

---

### **GatewayClass**

The `GatewayClass` resource specifies the configuration and controller for managing Gateways. Each Gateway references exactly one GatewayClass.

#### Example:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: example-class
spec:
  controllerName: example.com/gateway-controller
```

- **`name`**: Identifies the class.
- **`controllerName`**: Specifies the controller managing this class.

In this example, a Gateway referencing `example-class` will be managed by the controller `example.com/gateway-controller`.

---

### **Gateway**

A `Gateway` represents an instance of traffic-handling infrastructure. It defines how traffic enters the cluster and what listeners are active.

#### Example:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: example-gateway
spec:
  gatewayClassName: example-class
  listeners:
  - name: http
    protocol: HTTP
    port: 80
```

- **`gatewayClassName`**: Links the Gateway to a GatewayClass.
- **`listeners`**: Defines how the Gateway listens for traffic:
  - **`protocol`**: Protocol to accept (e.g., HTTP, HTTPS).
  - **`port`**: The port to listen on.

The above Gateway listens for HTTP traffic on port 80 and is managed by the controller defined in `example-class`.

---

### **HTTPRoute**

The `HTTPRoute` resource specifies rules for routing HTTP traffic from a Gateway listener to backends (e.g., Kubernetes Services).

#### Example:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: example-httproute
spec:
  parentRefs:
  - name: example-gateway
  hostnames:
  - "www.example.com"
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /login
    backendRefs:
    - name: example-svc
      port: 8080
```

- **`parentRefs`**: Links the route to a Gateway.
- **`hostnames`**: Specifies hostnames to match.
- **`rules`**:
  - **`matches`**: Defines match conditions (e.g., path prefixes).
  - **`backendRefs`**: Specifies backends (e.g., Services) to route traffic to.

In this example, traffic to `www.example.com/login` is routed to the Service `example-svc` on port 8080.

---

### **Request Flow**

The Gateway API request flow works as follows:

1. **Client Sends Request**:
   - The client sends an HTTP request to a URL (e.g., `http://www.example.com`).

2. **DNS Resolution**:
   - The client's DNS resolver maps the hostname to the Gateway's IP address.

3. **Gateway Listener**:
   - The Gateway listener receives the request and matches the `Host:` header and path against attached HTTPRoute configurations.

4. **HTTPRoute Matching**:
   - The Gateway applies the routing rules defined in the HTTPRoute (e.g., path prefix matching).

5. **Traffic Forwarding**:
   - The Gateway forwards the request to the specified backend (e.g., a Kubernetes Service).

---

### **Advanced Features**

1. **Traffic Splitting**:
   - Routes traffic proportionally to multiple backends for canary deployments or load distribution.

2. **Header-Based Routing**:
   - Matches traffic based on HTTP headers (e.g., `User-Agent`).

3. **Path Matching**:
   - Supports exact matches, prefix matches, and implementation-specific matches.

4. **TLS Termination**:
   - Handles HTTPS traffic by terminating TLS connections at the Gateway level.

---

### **Comparison to Ingress**

| Feature            | Ingress API                | Gateway API               |
|--------------------|---------------------------|---------------------------|
| **Role-Oriented**   | Single resource for all roles | Separate resources for distinct roles |
| **Routing Features** | Limited, relies on annotations | Advanced routing capabilities |
| **Extensibility**   | Limited to annotations    | Fully extensible via custom resources |
| **TLS**             | Basic support             | Comprehensive TLS management |
| **Custom Controllers** | Basic support             | Explicit GatewayClass configuration |

---

### **Migrating from Ingress**

To migrate from Ingress to Gateway API:
1. Replace Ingress resources with Gateway, HTTPRoute, and GatewayClass resources.
2. Map annotations to explicit API fields or use custom resources for extended configurations.
3. Review the documentation for your Gateway controller to ensure compatibility.

---

### **Conclusion**

The Gateway API is a powerful evolution of Kubernetes traffic management, offering advanced features, role-oriented design, and extensibility. By migrating from Ingress to Gateway API, organizations can achieve greater flexibility and efficiency in managing traffic for modern cloud-native applications.