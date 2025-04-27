
---

### **UserData Guidelines**
- **Important Note**: UserData is stored with the instance and is **not encrypted**. 
- **Best Practices**: Avoid including sensitive information such as passwords, API keys, or other secrets in UserData.

---

### **Instance Tagging**
- You can apply **up to 10 tags** per instance to organize and manage resources effectively.

---

### **Payment Options for Reserved Instances**
1. **All Upfront**  
   - Full reservation payment upfront.  
   - No monthly charges during the reservation term.

2. **Partial Upfront**  
   - Pay a portion upfront.  
   - The remaining cost is divided into monthly installments for the term.

3. **No Upfront**  
   - No upfront payment.  
   - The total cost is spread across monthly installments during the reservation term.

---

### **Dedicated Instances vs. Dedicated Hosts**

| **Feature**               | **Dedicated Instances**                                    | **Dedicated Hosts**                                                         |
|---------------------------|-----------------------------------------------------------|-----------------------------------------------------------------------------|
| **Hardware Control**       | AWS manages hardware allocation for instances.            | Full control over physical server and instance placement.                   |
| **Visibility**             | No visibility into the specific physical hardware.        | Full visibility of the physical server (e.g., cores, sockets).              |
| **Instance Placement**     | Instances can launch on any dedicated hardware in the account. | Control over which host an instance runs on.                                |
| **Use Case**               | Physical hardware isolation for compliance or security.   | License-bound software or scenarios requiring server-level control.         |
| **Licensing Support**      | No support for server-bound licenses.                     | Supports server-bound licenses that require specific hardware.              |
| **Billing**                | Charged for hardware isolation per instance.              | Charged for the entire Dedicated Host, plus instances running on it.        |

---

### **Placement Group Types and Key Differences**

| **Feature**               | **Cluster Placement Group**          | **Spread Placement Group**          | **Partition Placement Group**            |
|---------------------------|---------------------------------------|--------------------------------------|------------------------------------------|
| **Purpose**               | High performance, low latency         | Fault tolerance, high availability   | Fault isolation for distributed systems  |
| **Instance Distribution** | Instances placed close together       | Instances spread across hardware     | Instances split into isolated partitions |
| **Fault Isolation**       | Low (same hardware)                   | High (different hardware)            | High (isolated partitions)               |
| **Use Case**              | HPC, big data, ML training            | Critical apps, fault-tolerant apps   | Distributed systems (e.g., HDFS)         |
| **Maximum Instances**     | Depends on instance type and limits   | 7 per AZ                             | Varies by AZ (up to 7 partitions)        |

---

### **Quick Highlights**
- **UserData**: Never include secrets as it is not encrypted.  
- **Tagging**: Up to 10 tags per instance.  
- **Reserved Instance Payments**: Flexible options (All Upfront, Partial Upfront, No Upfront).  
- **Dedicated Options**: Choose **Dedicated Instances** for managed hardware isolation or **Dedicated Hosts** for full control and licensing support.  
- **Placement Groups**: Choose based on performance, fault tolerance, or fault isolation needs.

