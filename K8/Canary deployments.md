---
tags:
  - k8
---
### **Canary Deployments in Kubernetes**

Canary deployments are a deployment strategy that incrementally introduces a new version of an application to a small subset of users before rolling it out to the entire user base. This approach minimizes the risk of introducing a faulty update to production by allowing testing under real-world conditions with a small, controlled traffic percentage.

Kubernetes provides mechanisms to implement canary deployments using features such as **Deployments**, **Services**, and **Labels**.

---

### **Why Use Canary Deployments?**

1. **Risk Mitigation**:
   - Limits the exposure of a new application version to a small percentage of users.
   - Allows the team to identify and fix issues before a full rollout.

2. **Real-World Testing**:
   - Tests the new version with real user interactions and workloads.
   - Identifies issues that might not surface in staging or testing environments.

3. **Incremental Rollout**:
   - Provides a step-by-step path to complete rollout, making it easier to halt or roll back changes if necessary.

4. **Improved Confidence**:
   - Builds confidence in the new release as it performs well for a subset of users.

---

### **How Canary Deployments Work**

1. **Deploy a Stable Version**:
   - The current production version of the application (e.g., `v1`) runs with most or all traffic directed to it.

2. **Deploy a Canary Version**:
   - Deploy a new version of the application (e.g., `v2`) alongside the stable version. The canary version typically handles a smaller portion of the traffic.

3. **Monitor and Validate**:
   - Monitor the performance, stability, and correctness of the canary version.
   - Use metrics such as response times, error rates, and logs to validate the behavior.

4. **Incrementally Increase Traffic**:
   - Gradually increase the traffic to the canary version while monitoring its performance.
   - Once confidence is gained, shift all traffic to the new version.

5. **Full Rollout or Rollback**:
   - If the canary version proves reliable, fully roll it out by scaling it up.
   - If issues are detected, roll back to the stable version.

---

### **Steps to Implement Canary Deployments in Kubernetes**

1. **Label Differentiation**:
   - Use labels to distinguish between the stable and canary versions.

   Stable version:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: frontend-stable
     labels:
       app: guestbook
       tier: frontend
       track: stable
   spec:
     replicas: 3
     template:
       metadata:
         labels:
           app: guestbook
           tier: frontend
           track: stable
       spec:
         containers:
         - name: frontend
           image: gb-frontend:v1
   ```

   Canary version:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: frontend-canary
     labels:
       app: guestbook
       tier: frontend
       track: canary
   spec:
     replicas: 1
     template:
       metadata:
         labels:
           app: guestbook
           tier: frontend
           track: canary
       spec:
         containers:
         - name: frontend
           image: gb-frontend:v2
   ```

2. **Service Configuration**:
   - Use a Kubernetes Service to span both deployments by selecting common labels (excluding the `track` label).

   Service:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: frontend-service
   spec:
     selector:
       app: guestbook
       tier: frontend
     ports:
     - protocol: TCP
       port: 80
       targetPort: 80
   ```

   The Service will distribute traffic across both the stable and canary replicas.

3. **Adjust Traffic Distribution**:
   - Modify the replica count in the canary and stable Deployments to control the traffic ratio.
   - For example:
     - Stable: 3 replicas
     - Canary: 1 replica
   - Traffic is distributed 3:1 between stable and canary (approximately 75% to stable and 25% to canary).

4. **Monitor Performance**:
   - Use tools like Prometheus, Grafana, or built-in Kubernetes metrics to monitor:
     - Latency
     - Errors
     - Logs
     - Resource utilization
   - Validate that the canary version behaves as expected under real traffic.

5. **Increase Traffic Gradually**:
   - Gradually increase the number of replicas for the canary Deployment and decrease the stable Deployment's replicas.
   - Example:
     - Stable: 2 replicas
     - Canary: 2 replicas
   - This results in a 50:50 traffic split.

6. **Complete Rollout**:
   - Once confidence is gained, scale the stable Deployment down to `0` replicas and scale the canary Deployment up to match the production load.

---

### **Traffic Management**

To achieve more precise traffic control, integrate Kubernetes with an **Ingress Controller** or **Service Mesh** like Istio or Linkerd. These tools allow traffic splitting by percentage rather than relying solely on replica ratios.

**Example with Istio**:
- Define a VirtualService to split traffic between stable and canary versions.
```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: frontend-virtualservice
spec:
  hosts:
  - frontend.example.com
  http:
  - route:
    - destination:
        host: frontend-service
        subset: stable
      weight: 75
    - destination:
        host: frontend-service
        subset: canary
      weight: 25
```

---

### **Rollback Canary Deployment**

If issues are detected in the canary version:
1. Scale the canary Deployment down to `0` replicas.
2. Restore the stable Deployment to its original state.

```bash
kubectl scale deployment frontend-canary --replicas=0
kubectl scale deployment frontend-stable --replicas=3
```

---

### **Best Practices for Canary Deployments**

1. **Start Small**:
   - Always start with a small percentage of traffic directed to the canary version.

2. **Automated Monitoring**:
   - Set up automated alerts to detect issues in the canary version early.

3. **Incremental Rollouts**:
   - Gradually increase traffic to the canary version while monitoring its performance.

4. **Stateless Applications**:
   - Ensure that applications are stateless or can handle scaling without issues.

5. **Automate Rollback**:
   - Use CI/CD pipelines to automate rollbacks if monitoring detects anomalies.

6. **Test in Staging**:
   - Thoroughly test the new version in a staging environment before rolling it out to production.

---

### **Tools for Canary Deployments**

1. **Service Mesh**:
   - Istio, Linkerd, or Consul for advanced traffic splitting and observability.

2. **CI/CD Pipelines**:
   - Tools like ArgoCD, Spinnaker, or Flux to automate canary deployments and rollbacks.

3. **Monitoring and Logging**:
   - Use tools like Prometheus, Grafana, Loki, and Elastic Stack to monitor application performance.

4. **KEDA (Kubernetes Event-Driven Autoscaling)**:
   - Automate scaling based on metrics like event counts or message queues.

---

### **Advantages of Canary Deployments**

- **Low Risk**: Limits the blast radius of any issues to a small subset of users.
- **Real-Time Feedback**: Collects real-world performance data.
- **Incremental Rollout**: Gradual deployment reduces stress on the system.
- **Rollback Safety**: Easy to roll back to the stable version if issues are detected.

---

### **Disadvantages of Canary Deployments**

- **Complexity**: Managing multiple versions of the same application increases operational complexity.
- **Traffic Management**: Precise traffic splitting may require additional tools.
- **Extended Monitoring**: Requires consistent monitoring during rollout phases.

---

### **Conclusion**

Canary deployments are an excellent strategy for minimizing risks during application updates. By combining Kubernetes-native features with tools like service meshes and robust monitoring, you can ensure smooth, controlled rollouts of new features or fixes while maintaining application stability.