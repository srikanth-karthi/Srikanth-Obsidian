---
tags:
  - k8
---
### StatefulSets in Kubernetes

A **StatefulSet** is a Kubernetes workload API object used for managing applications that require **state persistence**, **unique identity**, and **ordered deployment** of Pods. This is especially useful for databases, distributed systems, and other stateful applications.

---

### **Key Features of StatefulSets**

1. **Sticky Identity**:
   - Each Pod in a StatefulSet maintains a unique and persistent identity across rescheduling events.
   - Pod identities are based on an ordinal index (`pod-0`, `pod-1`, etc.), derived from the StatefulSet name and their sequence.

2. **Stable Network Identity**:
   - Pods in a StatefulSet have unique network names.
   - Names follow the format: `<statefulset-name>-<ordinal>`.
   - They use a **Headless Service** to manage DNS subdomains.

3. **Persistent Storage**:
   - StatefulSets create **PersistentVolumeClaims (PVCs)** for Pods.
   - Each Pod gets its own storage, which remains intact even if the Pod is deleted or rescheduled.

4. **Ordered Deployment and Scaling**:
   - Pods are deployed or scaled sequentially (`0...N-1` for deployment, `N-1...0` for termination).
   - Ensures dependencies and initialization steps are handled gracefully.

5. **Rolling Updates**:
   - Automated updates ensure Pods are updated sequentially while maintaining stability.
   - Allows for staged updates, canary testing, and manual rollback.

---

### **When to Use StatefulSets**

StatefulSets are ideal for applications requiring:
- Stable and unique network identities.
- Persistent storage across restarts.
- Ordered deployment or scaling.
- Controlled rolling updates with automated sequencing.

For stateless applications, use **Deployments** or **ReplicaSets** instead, as they offer simpler and more efficient management for ephemeral workloads.

---

### **Components of a StatefulSet**

#### **1. Headless Service**
- Provides a network identity to Pods.
- Configured with `clusterIP: None`.
- Ensures unique DNS entries for each Pod.

#### **2. StatefulSet Specification**
Key fields:
- `serviceName`: Links the StatefulSet to the Headless Service.
- `replicas`: Specifies the number of Pods.
- `volumeClaimTemplates`: Defines PVCs for persistent storage.
- `template`: Defines the Pod template, including labels and container specifications.
- `podManagementPolicy`: Controls the sequence of Pod creation and termination.

---

### **Example YAML Configuration**

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
    - port: 80
      name: web
  clusterIP: None
  selector:
    app: nginx
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  serviceName: "nginx"
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      terminationGracePeriodSeconds: 10
      containers:
        - name: nginx
          image: nginx:1.19.3
          ports:
            - containerPort: 80
              name: web
          volumeMounts:
            - name: www
              mountPath: /usr/share/nginx/html
  volumeClaimTemplates:
    - metadata:
        name: www
      spec:
        accessModes: [ "ReadWriteOnce" ]
        resources:
          requests:
            storage: 1Gi
```

---

### **Key Concepts in Detail**

#### **1. Pod Selector**
- `spec.selector` must match `spec.template.metadata.labels`.
- Ensures StatefulSet correctly identifies and manages its Pods.

#### **2. Persistent Volumes**
- StatefulSets use `volumeClaimTemplates` to define storage.
- Each Pod gets a unique PersistentVolume.
- Volumes are not automatically deleted with Pods to preserve data integrity.

#### **3. Deployment and Scaling**
- Pods are deployed sequentially:
  - Pod-0 starts first and must be **Ready** before Pod-1 is created.
- Pods are terminated in reverse order:
  - Pod-2 terminates first, followed by Pod-1, and so on.

#### **4. Pod Management Policies**
- **OrderedReady** (Default): Sequential deployment and scaling.
- **Parallel**: All Pods are created or terminated simultaneously, useful for faster scaling.

---

### **Update Strategies**

#### **1. OnDelete**
- StatefulSet does not update Pods automatically.
- Manual deletion of Pods triggers recreation with updated specs.

#### **2. RollingUpdate (Default)**
- Pods are updated sequentially, from the highest ordinal to the lowest.
- Ensures stability during updates.

#### **Partitioned Rolling Updates**
- Limits updates to a subset of Pods.
- Defined by `rollingUpdate.partition`.
- Useful for phased rollouts or canary deployments.

---

### **Persistent Volume Retention Policies**

- `spec.persistentVolumeClaimRetentionPolicy` manages PVC lifecycle:
  - **whenDeleted**:
    - PVCs are deleted when the StatefulSet is deleted.
  - **whenScaled**:
    - PVCs are deleted when replicas are scaled down.

Default behavior is `Retain`, meaning PVCs are preserved.

---

### **Common Use Cases**

1. **Databases**:
   - PostgreSQL, MySQL, MongoDB, etc., where each instance needs a unique identity and persistent storage.

2. **Distributed Systems**:
   - Kafka, Zookeeper, and similar systems require ordered scaling and unique network identities.

3. **Batch Processing Systems**:
   - StatefulSets ensure stable storage and networking for tasks across multiple nodes.

---

### **Limitations of StatefulSets**

1. **No Guarantees on Pod Termination Order**:
   - StatefulSets cannot guarantee the order of Pod termination during deletion.
   - Manual scaling to zero is recommended before deletion.

2. **Headless Service Requirement**:
   - A Headless Service must be manually created for network identity.

3. **Manual Volume Cleanup**:
   - PersistentVolumes and PVCs are not deleted automatically.

4. **Rolling Updates and Failures**:
   - Broken updates may require manual intervention to recover.

---

### **What’s Next?**
- **Learn StatefulSet Scaling**: Explore horizontal scaling with StatefulSets.
- **Experiment with Stateful Applications**: Deploy real-world apps like databases or distributed queues.
- **Understand Persistent Volumes**: Learn more about PVCs and dynamic provisioning.
- **Explore Alternatives**: Consider DaemonSets, Jobs, or Deployments for specific workloads.