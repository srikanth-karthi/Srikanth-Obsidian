---
tags:
  - k8
---

---

### **What is a ReplicaSet?**
A **ReplicaSet** ensures that a specific number of identical Pods are always running in a Kubernetes cluster. It achieves this by:
- **Creating Pods** if the number of running Pods is less than desired.
- **Deleting Pods** if the number of running Pods exceeds the desired count.
- Automatically replacing Pods that fail, get deleted, or are evicted.

---

### **Key Components of a ReplicaSet**

1. **Replicas**:
   - Specifies the desired number of Pods.
   - Example: `replicas: 3` ensures three Pods are always running.

2. **Selector**:
   - A label-based mechanism to identify which Pods the ReplicaSet should manage.
   - Example: If a Pod has the label `app: frontend`, it can be managed by a ReplicaSet with `selector: matchLabels: app: frontend`.

3. **Pod Template**:
   - Specifies the blueprint for creating Pods, including container images, ports, volumes, etc.
   - If a Pod needs to be created, the ReplicaSet uses this template.

4. **Owner Reference**:
   - Every Pod managed by a ReplicaSet has an `ownerReferences` field pointing to the ReplicaSet. This enables the ReplicaSet to track and manage its Pods.

---

### **How Does a ReplicaSet Work?**
1. The ReplicaSet continuously monitors the Pods it manages.
2. If a Pod is terminated or deleted, the ReplicaSet creates a new Pod using its Pod template.
3. If the number of Pods exceeds the desired count, the ReplicaSet deletes extra Pods.

---

### **ReplicaSet vs Deployment**

- **ReplicaSet**:
  - Directly manages Pods and ensures a specific number of replicas are running.
  - Does not support declarative updates or rolling updates.
  - Best used when you need static, unchanging Pods.

- **Deployment**:
  - Manages ReplicaSets and provides additional features like rolling updates, rollbacks, and declarative updates.
  - Preferred for most use cases as it abstracts and enhances the functionality of ReplicaSets.

---

### **Example ReplicaSet Manifest**

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
  template:
    metadata:
      labels:
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: us-docker.pkg.dev/google-samples/containers/gke/gb-frontend:v5
```

---

### **Working with ReplicaSets**

#### **Creating a ReplicaSet**
Save the above YAML into a file (e.g., `frontend.yaml`) and apply it:
```bash
kubectl apply -f frontend.yaml
```

Verify the ReplicaSet:
```bash
kubectl get rs
```

Check the Pods managed by the ReplicaSet:
```bash
kubectl get pods
```

---

#### **Scaling a ReplicaSet**
Increase or decrease the number of replicas:
```bash
kubectl scale rs frontend --replicas=5
```

Check the updated count:
```bash
kubectl get rs
```

---

#### **Deleting a ReplicaSet**
Delete the ReplicaSet and its Pods:
```bash
kubectl delete rs frontend
```

Delete only the ReplicaSet but keep the Pods:
```bash
kubectl delete rs frontend --cascade=orphan
```

---

#### **Pod Deletion Cost**
Set a `controller.kubernetes.io/pod-deletion-cost` annotation on Pods to influence which Pods are deleted first during downscaling:
```yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    controller.kubernetes.io/pod-deletion-cost: "-10"
```

- Pods with **lower deletion cost** are prioritized for deletion.

---

### **Non-Template Pod Acquisitions**
If bare Pods (created outside the ReplicaSet) match the label selector of a ReplicaSet, they will be adopted by the ReplicaSet. For example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod1
  labels:
    tier: frontend
spec:
  containers:
  - name: hello
    image: hello-world
```

If this Pod matches the `selector` of a ReplicaSet, the ReplicaSet will take ownership. If the ReplicaSet already has the desired number of replicas, the extra Pods will be terminated.

---

### **Advanced Use Cases**

#### **Horizontal Pod Autoscaler (HPA) with ReplicaSet**
ReplicaSets can be a target for Horizontal Pod Autoscalers (HPA) to automatically scale based on resource utilization.

Example HPA YAML:
```yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: frontend-scaler
spec:
  scaleTargetRef:
    kind: ReplicaSet
    name: frontend
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 50
```

Apply the HPA:
```bash
kubectl apply -f hpa-rs.yaml
```

---

### **Alternatives to ReplicaSet**

1. **Deployment (Recommended)**:
   - Automates updates and provides rolling updates and rollbacks.
   - Use for most stateless applications.

2. **DaemonSet**:
   - Ensures a Pod runs on every Node (e.g., for logging or monitoring).

3. **Job**:
   - Use for one-time or batch jobs that need to terminate after completion.

4. **ReplicationController**:
   - Older version of ReplicaSet with fewer features. ReplicaSets are preferred.

---

### **Summary**
- **ReplicaSet** ensures a stable set of running Pods.
- Use ReplicaSets when you need to ensure a specific number of identical Pods.
- For most cases, prefer **Deployments** over directly using ReplicaSets.
- Use scaling, label selectors, and annotations for advanced control.
- Combine ReplicaSets with Horizontal Pod Autoscalers for dynamic scaling.