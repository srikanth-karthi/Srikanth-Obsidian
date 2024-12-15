---
tags:
  - k8
---
### **DaemonSets in Kubernetes**

A **DaemonSet** ensures that a specific Pod runs on all (or a subset of) Nodes in the cluster. It is typically used for node-specific functionality such as logging, monitoring, or networking.

---

### **Key Features of DaemonSets**

1. **Node-Specific Pod Deployment**:
   - Ensures one Pod runs on every Node (or on selected Nodes).
   - As Nodes are added to the cluster, the DaemonSet ensures Pods are added to them automatically.
   - If Nodes are removed, the associated Pods are garbage collected.

2. **Use Cases**:
   - Running storage daemons (e.g., Ceph, GlusterFS) on every node.
   - Logs collection daemons (e.g., Fluentd, Logstash).
   - Node monitoring daemons (e.g., Prometheus Node Exporter).
   - Networking components (e.g., CNI plugins).

3. **Automatic Cleanup**:
   - Deleting a DaemonSet also deletes the Pods it created.

---

### **How DaemonSets Work**

1. **Pod Scheduling**:
   - DaemonSet Pods are scheduled on eligible Nodes based on `nodeSelector` or `affinity` rules.
   - They can tolerate taints to run on specific nodes (e.g., control plane nodes).

2. **Pod Lifecycle Management**:
   - Automatically adds Pods to new Nodes.
   - Removes Pods when Nodes are removed or become ineligible.

3. **Node-Level Functionality**:
   - Runs node-specific tasks like monitoring or storage.
   - Ensures cluster-wide consistency for node-specific services.

---

### **Writing a DaemonSet Spec**

A DaemonSet specification includes:
- **Pod Template**: Defines the Pod to be deployed on Nodes.
- **Selector**: Ensures Pods created by the DaemonSet match specific labels.
- **Node Affinity or Selectors**: Targets Pods to specific Nodes.

#### **Example DaemonSet YAML**

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-elasticsearch
  namespace: kube-system
  labels:
    k8s-app: fluentd-logging
spec:
  selector:
    matchLabels:
      name: fluentd-elasticsearch
  template:
    metadata:
      labels:
        name: fluentd-elasticsearch
    spec:
      tolerations:
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
        effect: NoSchedule
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule
      containers:
      - name: fluentd-elasticsearch
        image: quay.io/fluentd_elasticsearch/fluentd:v2.5.2
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: varlog
          mountPath: /var/log
      terminationGracePeriodSeconds: 30
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
```

---

### **Key Fields in a DaemonSet**

1. **`apiVersion`, `kind`, `metadata`**:
   - Standard fields for all Kubernetes objects.
   - `kind` is `DaemonSet`.

2. **`spec.template`**:
   - Pod template defining the Pods to run on each Node.
   - Must have `RestartPolicy: Always` (default).

3. **`spec.selector`**:
   - Ensures Pods match specific labels.
   - Immutable after creation.

4. **`nodeSelector` and `affinity`**:
   - Targets specific Nodes based on labels or affinity rules.

5. **`tolerations`**:
   - Allows Pods to tolerate taints (e.g., run on tainted control-plane Nodes).

---

### **DaemonSet Behavior**

1. **Running Pods on Specific Nodes**:
   - Use `nodeSelector` or `affinity` to target Nodes.
   - By default, Pods are scheduled on all Nodes.

2. **Handling Taints and Tolerations**:
   - Automatically tolerates taints like `node.kubernetes.io/not-ready`, `disk-pressure`, and `memory-pressure`.
   - Allows Pods to run on unschedulable Nodes (e.g., control-plane nodes).

3. **Communicating with DaemonSet Pods**:
   - **Push**: Pods send updates to a central service (e.g., logging).
   - **NodePort**: Use `hostPort` to expose Pods on Node IP and a known port.
   - **DNS/Service**: Use a Headless Service or a regular Service for communication.

---

### **Updating a DaemonSet**

1. **Rolling Updates**:
   - Default update strategy for DaemonSets.
   - Pods are updated sequentially to ensure minimal downtime.

2. **Modifying Pods**:
   - Some fields (e.g., labels, annotations) can be updated directly.
   - For others, Pods must be deleted and recreated.

3. **Cascading Deletes**:
   - Deleting a DaemonSet removes its Pods unless `--cascade=orphan` is used.

---

### **Advanced DaemonSet Concepts**

1. **Pod Scheduling with Priority**:
   - Assign a `priorityClassName` to DaemonSet Pods to ensure they preempt lower-priority Pods during scheduling.

2. **Custom Schedulers**:
   - Use the `schedulerName` field to assign a custom scheduler for Pods.

3. **Static Pods**:
   - Alternative to DaemonSets, static Pods are directly managed by the Kubelet.
   - Not managed by the Kubernetes API, making them less flexible.

---

### **When to Use DaemonSets**

- **Use Cases**:
  - Node-level logging or monitoring (e.g., Fluentd, Prometheus Node Exporter).
  - Network or storage services (e.g., CNI plugins, Ceph, GlusterFS).

- **When to Avoid**:
  - For stateless applications, use Deployments or ReplicaSets.
  - Use Jobs for batch workloads or tasks with defined lifecycles.

---

### **DaemonSet vs. Alternatives**

| **Feature**         | **DaemonSet**             | **Deployment**           | **Static Pods**          |
|----------------------|---------------------------|---------------------------|---------------------------|
| API Management       | Yes                       | Yes                       | No                        |
| Node-Specific        | Yes                       | No                        | Yes                       |
| Dynamic Scaling      | No                        | Yes                       | No                        |
| Use Case             | Node-level functionality  | Stateless apps            | Bootstrap or critical apps|

---

### **What’s Next?**
1. **Explore DaemonSet Update Strategies**:
   - Perform rolling updates or rollbacks.
2. **Understand Node Scheduling**:
   - Learn about taints, tolerations, and affinities.
3. **Dive into Use Cases**:
   - Set up logging (Fluentd) or monitoring (Prometheus Node Exporter).
4. **Experiment with Alternatives**:
   - Compare DaemonSets with Deployments, Jobs, and Static Pods.