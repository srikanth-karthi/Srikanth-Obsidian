---
tags:
  - k8
---
# **Understanding User Namespaces in Kubernetes**

User namespaces are a powerful feature in Linux that can enhance the security of containers in Kubernetes. In this explanation, we'll delve into what user namespaces are, how they work in Kubernetes Pods, and how you can leverage them to improve security in your cluster.

---

## **1. What Are User Namespaces?**

A **user namespace** is a feature in the Linux kernel that allows processes to have different user and group IDs inside the namespace compared to the host system. Essentially, it maps user IDs (UIDs) and group IDs (GIDs) inside the container to different IDs on the host.

### **Key Features:**

- **UID/GID Mapping:** Processes running as root (UID 0) inside a container can be mapped to a non-root UID on the host.
- **Isolation:** Provides isolation of user and group privileges between the container and the host.
- **Reduced Privileges:** Even if a process runs as root inside the container, it doesn't have root privileges on the host.

---

## **2. Why Use User Namespaces in Kubernetes?**

### **Security Enhancement:**

- **Mitigate Vulnerabilities:** User namespaces can prevent certain security vulnerabilities from being exploited, especially those that require root privileges on the host.
- **Limit Damage from Compromised Containers:** If a container is compromised, the attacker gains limited privileges on the host, reducing potential damage.
- **Isolation Between Pods:** Different Pods can have separate UID/GID mappings, isolating them from each other.

---

## **3. How User Namespaces Work in Kubernetes Pods**

### **Standard Namespaces in Containers:**

- When you create a Pod, Kubernetes uses Linux namespaces to isolate resources like the network, process IDs (PIDs), and mount points.
- By default, user namespaces are **not** used, meaning that the user IDs inside the container match those on the host.

### **Enabling User Namespaces:**

- Kubernetes allows you to enable user namespaces by setting the `hostUsers` field in the Pod specification to `false`.
- When `hostUsers: false`, Kubernetes maps the container's UIDs/GIDs to different IDs on the host.

**Example Pod Spec with User Namespaces:**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: userns-pod
spec:
  hostUsers: false
  containers:
  - name: app
    image: ubuntu:latest
    command: ["sleep", "3600"]
```

### **UID/GID Mapping:**

- **Inside the Container:** The process might run as UID 0 (root).
- **On the Host:** The same process could be mapped to UID 100000 (non-root user).

**Visualization:**

| **Container UID/GID** | **Host UID/GID** |
|-----------------------|------------------|
| 0                     | 100000           |
| 1                     | 100001           |
| ...                   | ...              |

---

## **4. Benefits of Using User Namespaces**

### **Improved Security:**

- **Reduced Host Privileges:** Processes running as root inside the container have limited permissions on the host.
- **Isolation Between Containers:** Each Pod can have its own UID/GID mappings, preventing cross-Pod privilege escalations.

### **Mitigation of Specific Vulnerabilities:**

- Some high or critical vulnerabilities are not exploitable when user namespaces are active.
- For example, CVE-2021-25741 could be mitigated using user namespaces.

---

## **5. Setting Up User Namespaces in Kubernetes**

### **Prerequisites:**

- **Linux Kernel Support:** Your nodes must run a Linux kernel version that supports user namespaces and ID mapping.
- **Filesystem Support:** Filesystems used by Pods (e.g., ext4, xfs, tmpfs) must support ID mapped mounts.
- **Container Runtime Support:** The container runtime (e.g., containerd, CRI-O) and OCI runtime (e.g., runc, crun) must support user namespaces.

### **Steps to Enable User Namespaces:**

1. **Verify Kernel and Filesystem Support:**

   - Ensure the host kernel is version 6.3 or newer.
   - Check that filesystems support ID mapped mounts.

2. **Configure Container Runtime:**

   - Update container runtimes to versions that support user namespaces.
   - For **containerd**, version 2.0 or later is required.
   - For **CRI-O**, version 1.25 or later is required.

3. **Set `hostUsers: false` in Pod Spec:**

   - This tells Kubernetes to use user namespaces for the Pod.

   ```yaml
   spec:
     hostUsers: false
   ```

4. **Ensure `runAsUser` and `runAsGroup` Settings:**

   - When using user namespaces, the valid UID/GID range inside the container is 0-65535.
   - Set `runAsUser` and `runAsGroup` within this range.

   ```yaml
   securityContext:
     runAsUser: 1000
     runAsGroup: 1000
   ```

---

## **6. Example: Running a Pod with User Namespaces**

### **Pod Specification:**

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-app
spec:
  hostUsers: false
  securityContext:
    runAsUser: 0  # Root inside the container
    runAsGroup: 0
  containers:
  - name: app
    image: ubuntu:latest
    command: ["bash", "-c", "id && sleep 3600"]
```

### **What Happens:**

- **Inside the Container:**

  - The process runs as UID 0 (root).
  - Running `id` outputs:

    ```
    uid=0(root) gid=0(root) groups=0(root)
    ```

- **On the Host:**

  - The process is mapped to a non-root UID (e.g., 100000).
  - Checking the process on the host shows:

    ```bash
    ps -aux | grep secure-app
    # The process runs under UID 100000, not root
    ```

### **Verifying the Isolation:**

- **Attempting Host Access:**

  - Even though the process runs as root inside the container, it cannot access host files that require root privileges.
  - This reduces the risk if the container is compromised.

---

## **7. Limitations and Considerations**

### **Limitations:**

- **Host Namespaces Restrictions:**

  - When `hostUsers: false`, you cannot use host network, IPC, or PID namespaces.
  - Fields that must be `false`:

    ```yaml
    hostNetwork: false
    hostPID: false
    hostIPC: false
    ```

- **Filesystem Support:**

  - All filesystems used in the Pod's volumes must support ID mapped mounts.
  - Requires kernel version 6.3 or newer for full support.

- **Process and File Ownership:**

  - UIDs/GIDs outside the 0-65535 range are not accessible inside the container.
  - Files owned by UIDs/GIDs outside this range appear as owned by the overflow UID/GID (typically 65534).

### **Considerations:**

- **Container Runtime Compatibility:**

  - Ensure that your container runtime and OCI runtime support user namespaces.

- **Pod Security Standards:**

  - When user namespaces are enabled, Kubernetes relaxes certain security constraints (e.g., `runAsNonRoot` checks).

- **Cluster Configuration:**

  - All nodes in the cluster should support user namespaces for consistency.

---

## **8. Setting Up Nodes for User Namespaces**

### **Custom UID/GID Ranges:**

- By default, Kubernetes uses UIDs/GIDs above 65536 for mapping.
- You can configure custom ranges by:

  1. **Creating a `kubelet` User:**

     - Add a user named `kubelet` on the node.

  2. **Configuring Subordinate UID/GID:**

     - Edit `/etc/subuid` and `/etc/subgid`:

       ```
       kubelet:65536:7208960
       ```

     - This assigns a range of UIDs/GIDs to the kubelet for Pods.

  3. **Installing `getsubids`:**

     - Ensure `getsubids` (part of `shadow-utils`) is installed and accessible to the kubelet.

### **Constraints:**

- The subordinate ID ranges must:

  - Start at a multiple of 65536 (e.g., 65536, 131072).
  - Be large enough to accommodate the maximum number of Pods.

---

## **9. Integration with Pod Security Standards**

- **Feature Gate:** `UserNamespacesPodSecurityStandards` (alpha in Kubernetes v1.29).
- **Relaxed Security Checks:**

  - For Pods using user namespaces, certain fields are not restricted even under strict security policies:

    ```yaml
    securityContext:
      runAsNonRoot: true  # Not enforced when using user namespaces
    ```

- **Reasoning:**

  - Running as root inside a user namespace doesn't equate to root privileges on the host.

---

## **10. Best Practices**

### **Use Cases:**

- **Applications Requiring Root Inside Container:**

  - Tools like package managers (`apt`, `yum`) that need root can run safely.

- **Security-Sensitive Environments:**

  - Environments where reducing the attack surface is critical.

### **Recommendations:**

- **Test Compatibility:**

  - Ensure your applications work correctly with user namespaces enabled.

- **Monitor Kernel and Runtime Versions:**

  - Keep your kernel and container runtimes up to date to support user namespaces.

- **Avoid Host Namespace Sharing:**

  - Do not set `hostNetwork`, `hostPID`, or `hostIPC` to `true` when using user namespaces.

---

## **11. Limitations and Future Considerations**

- **Not Supported in Windows Containers:**

  - User namespaces are a Linux-specific feature.

- **Potential for Incompatibilities:**

  - Some applications or tools might behave differently under user namespaces.

- **Evolving Feature:**

  - As of Kubernetes v1.30, user namespaces are in **beta**; future updates may change behavior.

---

## **12. Summary**

- **User namespaces enhance security** by isolating container users from host users.
- **Processes run as root inside the container** but map to non-root UIDs on the host.
- **Requires kernel and runtime support**, including specific filesystem capabilities.
- **Enabling user namespaces** is done via the `hostUsers: false` field in the Pod spec.
- **Limitations exist**, such as disallowed host namespace sharing and UID/GID constraints.

---

## **What's Next?**

- **Test User Namespaces in Your Cluster:**

  - Create sample Pods with `hostUsers: false` and observe the behavior.

- **Check Compatibility:**

  - Verify that your container images and applications work correctly with user namespaces.

- **Stay Updated:**

  - Follow Kubernetes release notes for updates on user namespace support and changes.

---

## **Additional Resources**

- **Kubernetes Documentation:**

  - [Use a User Namespace With a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/)

- **Linux Man Pages:**

  - `man 7 user_namespaces`

- **Container Runtime Documentation:**

  - [containerd](https://containerd.io)
  - [CRI-O](https://cri-o.io)

---
