---
tags:
  - k8
---


Leases in Kubernetes are a mechanism to lock shared resources and manage coordination among distributed components. They are part of the **coordination.k8s.io** API group and are critical for maintaining stability and consistency across the Kubernetes system.

---

### **1. What Are Leases?**

A Lease object in Kubernetes is a resource that contains a time-bound lock, useful for coordination between distributed systems. It is primarily used for:

- Indicating resource ownership.
- Managing leader elections.
- Synchronizing system-critical operations across nodes or components.

A Lease object has key fields in its specification:

- `holderIdentity`: Identifies the entity holding the Lease.
- `renewTime`: Timestamp indicating the last renewal of the Lease.
- `leaseDurationSeconds`: Maximum time the Lease is valid without renewal.

---

### **2. Use Cases for Leases**

#### **a) Node Heartbeats**

Node heartbeats are essential for maintaining the health of a Kubernetes cluster. Each node sends regular updates (heartbeats) to ensure the control plane is aware of its availability.

- **Mechanism:**
    
    - Every `Node` has a corresponding Lease object in the `kube-node-lease` namespace.
    - The `spec.renewTime` field of this Lease is updated by the `kubelet` running on the Node during each heartbeat.
- **Benefits:**
    
    - Reduces load on the API server by allowing lightweight Lease updates instead of frequent updates to `Node`status.
    - Allows the control plane to track node availability efficiently.
- **Example Use:** If a Node's Lease is not renewed within the specified duration, the control plane marks the Node as unavailable.
    

---

#### **b) Leader Election**

Leader election ensures that only one instance of a distributed component performs a specific task at any time. This is crucial in high-availability (HA) scenarios.

- **Key Components:**
    
    - `kube-controller-manager` and `kube-scheduler` use Leases to elect a leader in multi-instance setups.
    - The leader instance periodically renews the Lease, while other instances remain on standby.
- **Mechanism:**
    
    - A Lease is created in the `kube-system` namespace.
    - The leader instance updates the `spec.renewTime` field to indicate its active status.
    - If the Lease is not renewed within the `leaseDurationSeconds`, a new leader is elected.

---

#### **c) API Server Identity**

Starting with Kubernetes v1.26, the `kube-apiserver` publishes its identity using Leases.

- **Purpose:**
    
    - Provides a way to discover and track the active API server instances in a cluster.
    - Enables future capabilities like load balancing or coordination among `kube-apiserver` instances.
- **Mechanism:**
    
    - Each `kube-apiserver` instance creates a Lease in the `kube-system` namespace with a unique SHA256-based name derived from its hostname.
    - The Lease object includes labels for identity and hostname:
        - `apiserver.kubernetes.io/identity`: Identifies the API server.
        - `kubernetes.io/hostname`: The hostname of the server.
- **Example Command:** To view API server leases:
    
    bash
    
    Copy code
    
    `kubectl -n kube-system get lease -l apiserver.kubernetes.io/identity=kube-apiserver`
    

---

#### **d) Custom Workloads**

Leases can be used in custom workloads to implement leader election or similar coordination tasks.

- **Example:** A custom controller with multiple replicas can use a Lease to ensure only one replica acts as the leader, performing critical operations, while others stay in standby.
    
- **Best Practices:**
    
    - Use a descriptive name for the Lease (e.g., `example-foo` for a component named "Example Foo").
    - Prevent name collisions by using prefixes or hashing deployment names.

---

### **3. Lifecycle and Behavior**

#### **a) Lease Renewal**

- A Lease holder must update the `renewTime` field periodically to maintain the lock.
- If `renewTime` is not updated before `leaseDurationSeconds` expires, the Lease is considered expired, and other entities can take over.

#### **b) Garbage Collection**

- Expired Leases from `kube-apiserver` instances are automatically garbage-collected after an hour.

---

### **4. Configurations and Customizations**

#### **Disabling API Server Identity Leases**

- You can disable this feature by turning off the `APIServerIdentity` feature gate in the API server configuration.

---

### **5. Benefits of Using Leases**

- **Efficient Resource Management:** Reduces overhead on critical resources like the API server.
- **Fault Tolerance:** Ensures continuity and recovery in distributed systems.
- **Coordination:** Provides a standardized way to manage leadership and activity among distributed components.
- **Custom Use Cases:** Flexibility to implement custom resource locking mechanisms.

---

### **6. Commands and Examples**

#### Inspecting Node Leases

To view the Lease for a specific Node:

bash

Copy code

`kubectl -n kube-node-lease get lease <node-name>`

#### Viewing API Server Leases

To inspect API server Leases:

bash

Copy code

`kubectl -n kube-system get lease -l apiserver.kubernetes.io/identity=kube-apiserver`

#### Creating a Custom Lease

Define a Lease object for your workload:

yaml

Copy code

`apiVersion: coordination.k8s.io/v1 kind: Lease metadata:   name: example-foo   namespace: default spec:   holderIdentity: my-leader-instance   leaseDurationSeconds: 30   renewTime: "2023-12-02T10:00:00Z"`

---

### **Conclusion**

Kubernetes Leases are a powerful mechanism for coordinating activities in a distributed system. They are versatile and integral to various Kubernetes functionalities like node health tracking, leader election, and custom workload coordination. By leveraging Leases effectively, you can enhance the resilience and efficiency of your Kubernetes cluster.