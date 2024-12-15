---
tags:
  - k8
---
Let’s break down **Pod Quality of Service (QoS) Classes** in Kubernetes step by step. These classes help Kubernetes manage resources and prioritize Pods during resource shortages.

---

### **What Are QoS Classes?**
**QoS Classes** are a way for Kubernetes to classify Pods based on their resource configurations. Kubernetes uses these classes to decide:
- How to allocate resources.
- Which Pods to evict first when a node runs out of resources.

#### **Three QoS Classes:**
1. **Guaranteed**: The most protected; least likely to be evicted.
2. **Burstable**: Moderately protected; evicted after BestEffort.
3. **BestEffort**: Least protected; first to be evicted.

---

### **1. Guaranteed QoS Class**

#### **Criteria:**
For a Pod to be in the **Guaranteed** class:
1. **Every container** in the Pod must have:
   - **CPU and Memory limits set**.
   - **CPU and Memory requests equal to their limits**.
   
   Example:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: guaranteed-pod
   spec:
     containers:
     - name: nginx
       image: nginx
       resources:
         requests:
           memory: "512Mi"
           cpu: "1"
         limits:
           memory: "512Mi"
           cpu: "1"
   ```

#### **Behavior:**
- **Highly protected**: These Pods are the last to be evicted.
- **Strict limits**: They cannot exceed their defined limits.

---

### **2. Burstable QoS Class**

#### **Criteria:**
For a Pod to be in the **Burstable** class:
1. The Pod does **not qualify as Guaranteed**.
2. At least one container in the Pod has **CPU or Memory requests or limits** set.

   Example:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: burstable-pod
   spec:
     containers:
     - name: nginx
       image: nginx
       resources:
         requests:
           memory: "256Mi"  # Memory request
   ```

#### **Behavior:**
- **Moderate protection**: Evicted after BestEffort Pods but before Guaranteed Pods.
- **Flexible usage**: These Pods can use more resources than their requests if resources are available, up to the node's capacity.

---

### **3. BestEffort QoS Class**

#### **Criteria:**
A Pod falls into the **BestEffort** class if:
1. **No container** in the Pod has CPU or Memory requests or limits set.

   Example:
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: besteffort-pod
   spec:
     containers:
     - name: nginx
       image: nginx
   ```

#### **Behavior:**
- **Least protection**: These Pods are the first to be evicted during resource pressure.
- **No guarantees**: They only use resources not assigned to other Pods.

---

### **How QoS Classes Affect Evictions**

When a node runs out of resources, Kubernetes evicts Pods in the following order:
1. **BestEffort Pods** are evicted first.
2. **Burstable Pods** are evicted next.
3. **Guaranteed Pods** are evicted last.

#### **Eviction Example:**
- A node runs out of memory.
- Kubernetes starts evicting **BestEffort Pods** until enough resources are freed.
- If that’s not enough, Kubernetes evicts **Burstable Pods** exceeding their requests.
- Guaranteed Pods are evicted only as a last resort.

---

### **Memory QoS with cgroup v2**

#### **How It Works:**
1. **Memory Requests (`memory.min`)**:
   - Ensures a Pod has guaranteed memory it can use, even during resource pressure.
2. **Memory Limits (`memory.high`)**:
   - Throttles memory usage when a Pod approaches its limit.

This feature is part of Kubernetes v1.22+ and relies on the **cgroup v2** memory controller.

---

### **How to Assign QoS Classes**
You determine a Pod’s QoS class by setting **requests** and **limits** for CPU and Memory in its containers.

| **QoS Class**   | **CPU Request** | **CPU Limit** | **Memory Request** | **Memory Limit** | **Notes**                              |
|------------------|-----------------|---------------|---------------------|------------------|----------------------------------------|
| **Guaranteed**  | Set             | Set           | Set                 | Set              | Requests must equal limits for all containers. |
| **Burstable**   | Optional        | Optional      | Optional            | Optional         | At least one request or limit must be set.     |
| **BestEffort**  | Not Set         | Not Set       | Not Set             | Not Set          | No requests or limits are set.                |

---

### **Practical Examples**

#### **Example 1: Guaranteed Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: guaranteed-pod
spec:
  containers:
  - name: nginx
    image: nginx
    resources:
      requests:
        memory: "512Mi"
        cpu: "1"
      limits:
        memory: "512Mi"
        cpu: "1"
```

#### **Example 2: Burstable Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: burstable-pod
spec:
  containers:
  - name: nginx
    image: nginx
    resources:
      requests:
        memory: "256Mi"
```

#### **Example 3: BestEffort Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: besteffort-pod
spec:
  containers:
  - name: nginx
    image: nginx
```

---

### **Why QoS Classes Matter**

1. **Node Pressure Handling**:
   - Nodes evict Pods based on their QoS class when resources are low.

2. **Application Availability**:
   - Higher QoS classes like **Guaranteed** ensure critical workloads remain unaffected.

3. **Efficient Resource Utilization**:
   - **Burstable Pods** allow flexible resource usage when nodes have spare capacity.

---

### **Best Practices**

1. **Use Guaranteed QoS for Critical Apps**:
   - Set requests equal to limits for apps that cannot tolerate downtime.

2. **Leverage Burstable QoS**:
   - Use Burstable for apps that need guaranteed minimum resources but can utilize extra capacity when available.

3. **Avoid BestEffort for Production**:
   - BestEffort is suitable for non-critical workloads like testing or batch jobs.

4. **Monitor Node Resource Usage**:
   - Keep track of resource allocation to ensure proper scheduling and minimize evictions.

---

### **Summary of QoS Classes**

| **QoS Class**   | **Eviction Priority** | **Resource Guarantees** | **Use Case**                        |
|------------------|-----------------------|--------------------------|--------------------------------------|
| **Guaranteed**  | Last                  | Fully guaranteed         | Critical apps needing strict limits |
| **Burstable**   | Medium                | Partially guaranteed     | Apps needing flexibility            |
| **BestEffort**  | First                 | No guarantees            | Non-critical workloads              |

Would you like further clarification or assistance with setting QoS classes in your cluster?