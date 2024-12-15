---
tags:
  - Devops
---
 


**Control groups (cgroups) and namespaces are two core Linux kernel features that Docker uses to isolate and manage containers. These features ensure containers have limited and separate access to system resources, enabling the lightweight and secure operation of multiple containers on the same host.

  

**1. Control Groups (cgroups)**

  

Cgroups limit, prioritize, and monitor the usage of system resources (CPU, memory, disk I/O, etc.) by processes. Docker uses cgroups to enforce resource constraints on containers.

  

**Features of cgroups:**

  

• **Resource Limiting**: You can restrict how much CPU, memory, or disk I/O a container can use.

• **Prioritization**: Assign priorities to processes to control access to resources during contention.

• **Accounting**: Monitor resource usage per container.

• **Isolation**: Prevent a container from overusing system resources and affecting others.

  

**Docker and cgroups Examples:**

  

• **Limit memory usage**:

  

docker run --memory=512m --memory-swap=1g ubuntu

  

• --memory=512m: Limits memory usage to 512 MB.

• --memory-swap=1g: Allows swapping up to 1 GB.

  

• **Limit CPU usage**:

  

docker run --cpus=1.5 ubuntu

  

• --cpus=1.5: Allocates 1.5 CPUs to the container.

  

• **Disk I/O constraints**:

  

docker run --device-read-bps=/dev/sda:1mb ubuntu

  

• Limits read speed from /dev/sda to 1 MB/s.

  

**2. Namespaces**

  

Namespaces provide isolated views of the operating system for processes. Docker uses namespaces to create isolated environments for containers.

  

**Types of Namespaces:**

  

1. **PID (Process ID)**: Isolates the process tree.

• Containers cannot see or interact with processes outside their own namespace.

2. **NET (Network)**: Isolates networking resources.

• Each container can have its own network stack (e.g., IP address, routing table).

3. **IPC (Inter-Process Communication)**: Isolates IPC mechanisms like shared memory.

• Prevents containers from accessing shared memory segments of others.

4. **MNT (Mount)**: Isolates the filesystem.

• Containers see only their allocated filesystem, not the host’s or others.

5. **UTS (Unix Time Sharing)**: Isolates the hostname and domain name.

• Containers can have their own hostname.

6. **User**: Isolates user and group IDs.

• Maps container users to different users on the host for enhanced security.

7. **Cgroup**: Isolates resource groups.

• Ensures that containers stay within their cgroup-defined limits.

  

**Docker and Namespaces Examples:**

  

• **Networking**:

  

docker network create isolated_net

docker run --network=isolated_net ubuntu

  

• Containers in the same network namespace can communicate; others cannot.

  

• **User namespace** (enabled with user remapping):

  

dockerd --userns-remap=default

  

• Maps container root user to an unprivileged user on the host.

  

**How cgroups and namespaces work together:**

  

• **Namespaces** ensure **isolation** by creating separate environments for containers.

• **Cgroups** manage and enforce **resource usage** within those isolated environments.

  

For example:

1. **Namespaces** ensure each container sees only its own processes, filesystems, and network.

2. **Cgroups** ensure no container exceeds its allocated CPU, memory, or I/O limits.

  

**Inspecting cgroups and namespaces:**

  

• **View cgroups of a container:**

  

docker inspect <container_id> | grep Cgroup

  

  

• **Inspect namespaces of a container:**

  

docker inspect <container_id> | grep Namespace

  
reference [Namespaces_Cgroups_Conatiners.pdf](https://www.andrew.cmu.edu/course/14-712-s20/applications/ln/Namespaces_Cgroups_Conatiners.pdf)
