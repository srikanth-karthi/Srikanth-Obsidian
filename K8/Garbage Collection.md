---
tags:
  - k8
---

**Garbage Collection (GC)** in Kubernetes is the process of automatically cleaning up unused or terminated resources in a cluster. It ensures efficient use of resources, minimizes clutter, and maintains overall cluster health. Kubernetes employs various garbage collection mechanisms to manage different types of resources, from pods and jobs to images and containers.

---

### **1. Key Resources Subject to Garbage Collection**
Kubernetes garbage collection applies to the following resources:

1. **Terminated Pods**: Pods that are no longer active (e.g., in `Completed` or `Failed` state).
2. **Completed Jobs**: Jobs that have successfully completed or exceeded their retry limit.
3. **Objects Without Owner References**: Resources left behind without a parent/owner object.
4. **Unused Containers and Images**: Stale or unused container images and containers on nodes.
5. **Dynamically Provisioned PersistentVolumes**: PersistentVolumes (PVs) with a `Delete` reclaim policy.
6. **Stale CertificateSigningRequests (CSRs)**: Expired or unused CSRs.
7. **Deleted Nodes**: Nodes removed from the cluster (e.g., by cloud or on-premise controllers).
8. **Node Lease Objects**: Lease objects that help manage node heartbeats.

---

### **2. Owners and Dependents**

#### **Owner References**
- **What are they?**
  Owner references establish a hierarchy of objects. For example, a `ReplicaSet` is the owner of its `Pod` objects. Deleting the `ReplicaSet` triggers garbage collection of its dependent `Pods`.

- **Key Notes:**
  - **Automatic Management**: Kubernetes automatically sets owner references for most objects.
  - **Cross-Namespace Restriction**: A dependent resource cannot reference an owner in a different namespace.
  - **Cluster-Scoped Dependencies**: Cluster-scoped resources can only reference other cluster-scoped owners.

#### **How It Works:**
When a dependent detects its owner is deleted, Kubernetes can:
1. Delete the dependent (default behavior).
2. Orphan the dependent (when explicitly configured).

---

### **3. Cascading Deletion**

Cascading deletion determines how owner-deletion impacts dependents. Kubernetes supports two types of cascading deletion:

#### **a) Foreground Cascading Deletion**
- The owner enters a **"deletion in progress"** state. Dependents are deleted first, followed by the owner.
- **Process:**
  1. The `deletionTimestamp` and `foregroundDeletion` finalizer are set on the owner.
  2. Dependents are deleted synchronously.
  3. The owner is deleted after all dependents are gone.

- **When to Use:**
  Use foreground deletion when you need to ensure all dependents are cleaned up before removing the owner.

#### **b) Background Cascading Deletion**
- The owner is deleted immediately, and the garbage collector asynchronously removes dependents.
- **Process:**
  1. The owner is deleted.
  2. The garbage collector identifies and deletes dependents in the background.

- **Default Behavior**: Kubernetes uses background deletion unless specified otherwise.

#### **c) Orphaned Dependents**
- Dependents are not deleted and remain in the cluster as orphaned objects.
- **When to Use:**
  Useful when you want to preserve dependent objects after deleting their owner.

---

### **4. Garbage Collection for Containers and Images**

#### **Unused Containers**
- The `kubelet` performs garbage collection for unused containers every minute.
- **Configuration Options:**
  - `MinAge`: Minimum age of a container for it to be eligible for deletion.
  - `MaxPerPodContainer`: Maximum number of retained containers per pod.
  - `MaxContainers`: Global maximum of retained containers across all pods.

#### **Unused Images**
- The `kubelet` performs garbage collection for unused images every five minutes.
- **Disk Thresholds:**
  - `HighThresholdPercent`: Disk usage percentage that triggers garbage collection.
  - `LowThresholdPercent`: Target disk usage after garbage collection.

#### **Image Lifecycle Management**
- Starting with Kubernetes v1.30, you can configure the `imageMaximumGCAge` field to specify the maximum time an image can remain unused.

---

### **5. Configuring Garbage Collection**

#### **a) Kubelet Settings**
- **Configuration File**: Customize garbage collection settings in the `KubeletConfiguration` resource.
- **Example Settings:**
  ```yaml
  kind: KubeletConfiguration
  apiVersion: kubelet.config.k8s.io/v1beta1
  imageMinimumGCAge: 12h
  maxPerPodContainer: 2
  maxContainers: 100
  ```

#### **b) Resource-Specific Configuration**
- **Cascading Deletion**: Specify deletion behavior (foreground, background, or orphan) using `kubectl delete`:
  ```bash
  kubectl delete replicaset my-replicaset --cascade=foreground
  ```
- **Finished Jobs**: Use the Time-To-Live (TTL) controller to clean up completed jobs.

---

### **6. Garbage Collection Controllers**

Kubernetes employs specialized controllers for garbage collection tasks:

1. **Default Garbage Collector**: Handles objects with owner references.
2. **TTL Controller**: Cleans up completed jobs based on TTL settings.
3. **Custom Controllers**: Developers can write custom controllers for advanced garbage collection needs.

---

### **7. Example: Foreground and Background Deletion**

#### **Foreground Deletion Example**
1. Deleting a ReplicaSet with foreground cascading:
   ```bash
   kubectl delete replicaset my-replicaset --cascade=foreground
   ```
2. The ReplicaSet enters a deletion in progress state.
3. The garbage collector deletes all its dependent Pods first.
4. Finally, the ReplicaSet is deleted.

#### **Background Deletion Example**
1. Deleting a ReplicaSet with background cascading:
   ```bash
   kubectl delete replicaset my-replicaset --cascade=background
   ```
2. The ReplicaSet is deleted immediately.
3. The garbage collector asynchronously deletes its Pods.

---

### **8. Summary**
- **Garbage Collection** is critical for cluster hygiene and resource efficiency.
- Kubernetes uses owner references, cascading deletion, and kubelet-managed GC mechanisms to ensure proper cleanup.
- The default behavior suits most use cases, but you can configure GC to fit specific requirements, such as preserving dependents or managing disk usage.

For more advanced setups, explore Kubernetes finalizers and custom garbage collection controllers. These tools provide powerful options for fine-grained resource management.