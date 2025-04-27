---
tags: []
---
## Amazon S3 Overview

Amazon S3 objects are automatically replicated on multiple devices in multiple facilities within a region. This ensures data durability and availability. Regarding scalability, Amazon S3 automatically partitions buckets to support very high request rates and simultaneous access by many clients if your request rate grows steadily.

### **Bucket Naming and Limits**

Bucket names can contain up to 63 lowercase letters, numbers, hyphens, and periods. You can create and use multiple buckets, with a default limit of 100 buckets per account.

### **Consistency Model**

Amazon S3 is an eventually consistent system but provides read-after-write consistency in specific cases.

#### **Summary of Consistency Model**

| **Operation**          | **Consistency**          | **Details**                                                                 |
|-------------------------|--------------------------|-----------------------------------------------------------------------------|
| PUT (new object)        | Read-after-write         | Immediately readable after the write.                                      |
| PUT (existing object)   | Eventual consistency     | GET may return old data until propagation completes.                       |
| DELETE                 | Eventual consistency     | GET may still return deleted data until propagation completes.             |
| GET during update       | Eventual consistency     | GET will return either old data or new data, never a mix of both.          |
| LIST after PUT/DELETE   | Eventual consistency     | Changes may take time to appear in listing results.                        |

---

### **Amazon S3 Storage Classes**

Amazon S3 offers a variety of storage classes designed for different use cases, balancing cost, durability, availability, and performance. Below is an updated list of all S3 storage classes, including One Zone-IA and Intelligent-Tiering.

---

#### **1. Amazon S3 Standard**

- **Features**: 
  - 99.99% availability, 99.999999999% (11 nines) durability.
  - Low latency and high throughput.
  - High performance for frequently accessed data.
- **Use Case**: General-purpose storage for frequently accessed data, both short-term and long-term needs.
- **Key Advantage**: Optimized for performance and durability without trade-offs.

---

#### **2. Amazon S3 Standard – Infrequent Access (Standard-IA)**

- **Features**: 
  - Same durability (11 nines), low latency, and high throughput as S3 Standard.
  - Designed for infrequently accessed data with lower storage costs but retrieval fees.
- **Pricing Considerations**: 
  - Lower storage cost per GB.
  - Minimum object size: 128KB.
  - Minimum duration: 30 days.
  - Retrieval costs apply.
- **Use Case**: Long-lived but less frequently accessed data stored for more than 30 days.

---

#### **3. Amazon S3 One Zone – Infrequent Access (One Zone-IA)**

- **Features**: 
  - Similar to Standard-IA but stores data in a single Availability Zone instead of multiple AZs.
  - Durability: 99.999999999% (11 nines).
  - Lower availability (99.5%) compared to Standard-IA.
  - Lower-cost storage due to reduced redundancy.
- **Pricing Considerations**: 
  - Lower storage cost compared to Standard-IA.
  - Retrieval fees apply.
- **Use Case**: 
  - Data that can be recreated easily in case of a failure.
  - Infrequently accessed data that doesn't require multi-AZ availability.

---

#### **4. Amazon S3 Intelligent-Tiering**

- **Features**:
  - Designed for data with unpredictable or changing access patterns.
  - Automatically moves data between storage tiers (frequent and infrequent access) based on usage.
  - No retrieval fees or operational overhead.
  - Durability: 99.999999999% (11 nines).
- **Pricing Considerations**:
  - Monitoring and automation fees apply per object.
- **Use Case**: Cost optimization for data with unknown or changing access patterns.

---

#### **5. Amazon S3 Glacier Instant Retrieval**

- **Features**:
  - Low-cost storage with millisecond retrieval for archival data that is accessed occasionally.
  - Durability: 99.999999999% (11 nines).
- **Use Case**: Archival data requiring frequent, immediate access.
- **Key Advantage**: Combines the cost-efficiency of Glacier with instant retrieval.

---

#### **6. Amazon S3 Glacier Flexible Retrieval (Formerly Glacier)**

- **Features**:
  - Extremely low-cost storage for archival data.
  - Retrieval times range from minutes (expedited retrieval) to hours (standard retrieval).
  - Durability: 99.999999999% (11 nines).
- **Pricing Considerations**: Free retrievals for up to 5% of stored data per month.
- **Use Case**: Long-term archival and backup data with occasional retrieval needs.

---

#### **7. Amazon S3 Glacier Deep Archive**

- **Features**:
  - Lowest-cost storage for rarely accessed data.
  - Retrieval times: 12 hours (standard) or up to 48 hours (bulk).
  - Durability: 99.999999999% (11 nines).
- **Use Case**: Long-term archival storage for regulatory and compliance purposes or infrequently accessed backups.

---

#### **8. Amazon S3 Reduced Redundancy Storage (RRS)**

- **Features**:
  - Lower durability (99.99%) compared to other classes.
  - Reduced cost due to lower durability.
- **Use Case**: Data that is easy to reproduce, such as thumbnails or intermediate files.

---

### **Key Considerations for Choosing S3 Storage Classes**
- **Access Patterns**: Choose Standard or Intelligent-Tiering for frequently accessed data, and IA or Glacier options for infrequent access.
- **Durability vs. Cost**: RRS and One Zone-IA offer lower costs but reduced redundancy and availability.
- **Long-Term Archival Needs**: Glacier Flexible Retrieval or Deep Archive are ideal for cold storage with retrieval delays.
- **Automatic Optimization**: Intelligent-Tiering is a great option for minimizing costs when access patterns are uncertain.


### **Access Control Mechanisms and Hierarchy**

Amazon S3 provides multiple mechanisms to manage and control access to buckets and objects. The hierarchy of these mechanisms is as follows:

#### **1. IAM Policies**
- IAM (Identity and Access Management) policies define permissions at the AWS account level.
- These policies grant or deny permissions to IAM users, groups, or roles across all AWS services, including S3.
- Example: Allowing a specific user to read objects in any S3 bucket within an account.

#### **2. Bucket Policies**
- Bucket policies are attached directly to an S3 bucket and define permissions for the bucket and its contents.
- They can grant permissions to IAM entities, AWS accounts, or anonymous users (public access).
- Bucket policies are evaluated before object ACLs.

#### **3. Access Control Lists (ACLs)**
- ACLs provide fine-grained permissions at the object or bucket level.
- They allow you to grant access to specific AWS accounts or predefined groups, such as "AllUsers" or "AuthenticatedUsers."
- ACLs are useful for legacy applications but are generally not recommended for new deployments.

#### **4. Block Public Access Settings**
- These settings provide an account-wide or bucket-level safeguard against public access.
- By enabling block public access, you can prevent any public-facing permissions, even if a bucket policy or ACL allows it.
- Block public access settings override bucket policies and ACLs.

### **How These Work Together**
1. **IAM Policies**: Apply permissions at the user or role level for actions across all S3 resources.
2. **Bucket Policies**: Apply permissions at the bucket level and are evaluated before object ACLs.
3. **ACLs**: Provide granular control over individual objects but are evaluated after bucket policies.
4. **Block Public Access**: Acts as a fail-safe to prevent unintended public exposure of buckets and objects.

---

### **Additional Features**

#### **Client-Side Encryption**
You can encrypt your Amazon S3 data at rest using client-side encryption, encrypting your data on the client before sending it to Amazon S3.

#### **Range GETs**
It is possible to download (GET) only a portion of an object in both Amazon S3 and Amazon Glacier using a feature called Range GET. By using the Range HTTP header in the GET request or equivalent parameters in one of the SDK wrapper libraries, you can specify a range of bytes of the object. This can be useful for:
- Dealing with large objects when you have poor connectivity.
- Downloading only a known portion of a large Amazon Glacier backup.

#### **Cross-Region Replication**
To enable cross-region replication, versioning must be turned on for both the source and destination buckets.

#### **Access Control List (ACL)**
Amazon S3 provides access control through Access Control Lists (ACLs) to manage permissions for objects and buckets. ACLs allow you to:
- Grant read and write permissions to individual users or groups.
- Define permissions at both the bucket and object level.

Each bucket and object has an associated ACL that can specify which AWS accounts or groups are granted access and the type of access (read/write). ACLs are useful for fine-grained control over access to your data and can be managed using the AWS Management Console, AWS CLI, or APIs.

