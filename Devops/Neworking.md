---
tags:
  - Devops
---

![[Pasted image 20240925113544.png]]

Compute node 1- 65534
 - standard ports 
	 - http -80
	 - htpps -443


 - Registered Ports
	 - register by the Application
	 
 - Dynamic Ports 
	- An ephemeral port is a communications endpoint (port) of a transport layer protocol of the Internet protocol suite that is used for only a short period of time for the duration of a communication session.
	- 
- A **loopback address** is a special IP address used by a computer to refer to itself, often for testing and network diagnostic purposes. It allows the machine to send and receive data without leaving the system.
  
  Ip adress/mac adress
  
  ip ping 
  
  A **MAC address** (Media Access Control address) is a unique identifier assigned to a network interface controller (NIC) for communications at the data link layer of a network. It is used to identify devices on a local network and ensure that data packets are delivered to the correct hardware. Every device connected to a network, such as computers, smartphones, routers, or IoT devices, has a MAC address.
  
![[Pasted image 20240925115537.png]]

**DHCP** (Dynamic Host Configuration Protocol) is a network management protocol used to automatically assign IP addresses and other network configuration settings (such as the default gateway, DNS servers, etc.) to devices on a network. This simplifies network management, as devices no longer need to be manually configured with static IP addresses.


## Configure the local system ip



IP ROUTE

![[Pasted image 20240925122412.png]]




## SE LINUX

SELinux (Security-Enhanced Linux) is a security module integrated into the Linux kernel that enforces mandatory access control (MAC) policies to enhance the security of Linux systems. It was initially developed by the United States National Security Agency (NSA) and is now maintained by the open-source community.

### Key Concepts of SELinux:

1. **Mandatory Access Control (MAC):** Unlike traditional discretionary access control (DAC), where users and applications control their access to files and resources, SELinux uses MAC to enforce security policies set by system administrators. This limits what applications and users can do, regardless of their privileges.

2. **Policies:** SELinux policies define the rules that control the access between subjects (users or processes) and objects (files, directories, sockets, etc.). By default, the system operates in a very restrictive mode, only allowing actions that are explicitly permitted by the policy.

3. **Labels (Contexts):** Every file, directory, process, and system object has an SELinux label that includes attributes like:
   - **User:** SELinux user (not the Linux user).
   - **Role:** Defines what roles users or processes can have.
   - **Type:** This is the most important field in most SELinux policies. Types define which resources (files, processes) a subject (process or user) can access.
   
   Example of a label: `system_u:object_r:httpd_sys_content_t:s0`
   - `system_u`: The SELinux user.
   - `object_r`: The role (for objects).
   - `httpd_sys_content_t`: The type (associated with web server files).
   - `s0`: The sensitivity level (used in multi-level security).

4. **Enforcing Modes:**
   - **Enforcing:** SELinux policy is enforced, and access denials are logged and blocked.
   - **Permissive:** SELinux is active, but instead of blocking access, it logs what would have been denied, which helps in troubleshooting.
   - **Disabled:** SELinux is turned off entirely.

5. **Benefits of SELinux:**
   - **Containment of compromised processes:** If an application (e.g., a web server) is compromised, SELinux can restrict what the compromised process can access.
   - **Fine-grained control:** SELinux allows defining very detailed security policies, reducing the attack surface.
   - **Protection from privilege escalation:** Even if a user or process gains root privileges, SELinux can prevent it from accessing sensitive resources.

### Modes of Operation:
- **Targeted:** Only certain processes (like Apache or PostgreSQL) are confined by SELinux policies, while the rest of the system runs without restrictions.
- **MLS (Multi-Level Security):** A more complex and strict mode that enforces security policies based on security clearances and information classifications.

### Managing SELinux:
- **Commands:**
  - `getenforce`: Shows the current mode (Enforcing, Permissive, Disabled).
  - `setenforce [0|1]`: Switches between Enforcing (1) and Permissive (0) modes.
  - `semanage`: Modifies SELinux policies.
  - `restorecon`: Restores default SELinux security contexts.
  - `audit2allow`: Generates policy rules based on log events to permit previously denied actions.

### Why Use SELinux?
It provides an extra layer of security, especially for services exposed to the internet or sensitive data handling processes. Even if an attacker gains control of an application, SELinux can prevent further damage by restricting access to system resources.


**ICMP Protocol**: ICMP is used primarily by network devices, like routers, to send error messages and operational information (e.g., whether a service is available or a host is reachable). Unlike TCP or UDP, ICMP doesn’t work with ports; it operates at the network layer.


|Feature|Telnet|Ping|
|---|---|---|
|**Purpose**|Remote login to another machine|Test network connectivity|
|**Protocol**|TCP (Port 23 by default)|ICMP (No ports involved)|
|**Functionality**|Provides terminal access to remote systems|Checks if a host is reachable and measures round-trip time|
|**Use Case**|Managing remote systems and testing specific services|Basic connectivity check and latency measurement|
|**Data Transmission**|Sends and receives text-based commands|Sends ICMP echo requests and receives replies|
|**Security**|Not secure (sends data in plaintext)|Generally safe, but some networks block ICMP for security|

```netstat -tulpen```

- **`-t`**: Show only **TCP** connections.
- **`-u`**: Show only **UDP** connections.
- **`-l`**: Show only **listening** sockets (services that are waiting for incoming connections).
- **`-p`**: Display the **PID (Process ID)** and the program name associated with each connection.
- **`-e`**: Show **extended information** like user ID and more.
- **`-n`**: Display **numerical addresses** instead of resolving hostnames (for faster output).
- **`-a`**: Show **all** active connections (both listening and non-listening).
  
  
  
  ### **1. Telnet vs Ping**:

- **Telnet**: Used for remote login and to test connectivity to specific ports. It uses TCP and is typically used on port 23. Telnet does not support encryption, which makes it insecure for public networks. For example, `telnet google.com 80` connects to Google's web server using HTTP.
- **Ping**: A utility that checks whether a host is reachable by sending ICMP echo requests. Ping doesn't use ports and is mainly used for testing network connectivity and latency.

### **2. Traceroute**:

- **Traceroute** is used to discover the path that packets take to reach a destination by identifying the hops along the way. You can use it with ICMP (`-I`) or TCP (`-T`) packets. Example: `traceroute google.com`.
- Each hop represents a router or intermediary network device.

### **3. Telnet on Port 443 (HTTPS)**:

- **Port 443** is for HTTPS, which uses SSL/TLS encryption. Telnet cannot handle encrypted traffic, so trying `telnet google.com 443` will result in the connection being closed by the server.
- Use `openssl s_client -connect google.com:443` to establish an encrypted connection, or `curl` to retrieve HTTPS content.

### **4. Netstat**:

- **Netstat** is a command-line tool used to display network connections, routing tables, and interface statistics. It's helpful for troubleshooting and monitoring network activity.
- Example: `netstat -tulpena`
    - **-t**: TCP connections.
    - **-u**: UDP connections.
    - **-l**: Listening sockets.
    - **-p**: Show process ID (PID) and program name.
    - **-e**: Extended information (e.g., user ID).
    - **-n**: Display numerical IPs and ports instead of resolving hostnames.
    - **-a**: Show all active connections (both listening and non-listening).

### **5. Netstat `tulpena` Example**:

This command provides detailed information about the active and listening TCP/UDP connections on your system, along with the associated process IDs and program names. You can use this to check for open ports, monitor services, and troubleshoot network issues.









