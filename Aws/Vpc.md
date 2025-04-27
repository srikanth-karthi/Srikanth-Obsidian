### **Key Differences Between Security Groups and NACLs**

| **Feature**              | **Security Group**                                    | **Network ACL (NACL)**                                   |
| ------------------------ | ----------------------------------------------------- | -------------------------------------------------------- |
| **Level of operation**   | Operates at the **instance level**                    | Operates at the **subnet level**                         |
| **Type of rules**        | Only supports **allow** rules                         | Supports both **allow** and **deny** rules               |
| **Statefulness**         | **Stateful**: Return traffic is automatically allowed | **Stateless**: Return traffic must be explicitly allowed |
| **Rule evaluation**      | AWS evaluates **all rules**                           | Rules are evaluated in **sequential order**              |
| **Scope of application** | Applied to individual instances                       | Applied to all instances in a subnet                     |
| **Default behavior**     | Denies all inbound and outbound traffic by default    | Allows all traffic by default (can be changed)           |
