---
tags:
  - ad
---
### Configuring an Active Directory (AD) Forest Using CLI

``` Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Restart-Computer

```

#### **Step 1: Install and Configure the AD Forest**
To set up a new AD forest using PowerShell, execute the following command:

```powershell
Install-ADDSForest -DomainName "google.com" -DomainNetBIOSName "google" -ForestMode "7" -DomainMode "7" -InstallDNS -SafeModeAdministratorPassword (ConvertTo-SecureString "StyjR!-)l?zFuPC@du)1bA(POiWInuj7" -AsPlainText -Force)
```

**Explanation of Parameters:**
- `-DomainName`: The fully qualified domain name (FQDN) of the new forest root domain (e.g., "srikanth.com").
- `-DomainNetBIOSName`: A NetBIOS name for the domain (e.g., "srikanth").
- `-ForestMode`: Specifies the forest functional level. Here, "7" corresponds to Windows Server 2016 or higher.
- `-DomainMode`: Specifies the domain functional level. Here, "7" matches the forest functional level.
- `-InstallDNS`: Installs the DNS server role alongside the AD DS role.
- `-SafeModeAdministratorPassword`: Sets a Directory Services Restore Mode (DSRM) password for recovery purposes. Ensure this password is secure.

---

#### **Step 2: Force Update Group Policy**
After configuring the AD forest, update Group Policy settings using the following command:

```powershell
gpupdate /force
```

**What it does:**
- Forces the system to immediately refresh Group Policy settings, applying any changes made to AD policies.

---

#### **Step 3: Troubleshooting AD Domain Connectivity**
If a client system is unable to connect or ping the AD domain, follow these steps:

1. **Manually Add AD Server’s Private IP to Ethernet Configuration:**
   - Update the client’s network settings to include the private IP address of the AD server as its primary DNS server.

   **Steps:**
   - Open the Ethernet properties on the client system.
   - Manually set the preferred DNS server to the private IP of the AD server.

2. **Add IP via DHCP in VPC:**
   - If the environment uses a cloud setup (e.g., AWS, Azure, or Google Cloud), configure the DHCP settings in the Virtual Private Cloud (VPC) to assign the AD server’s IP as the primary DNS server to all clients automatically.
   - Ensure the correct DNS address is distributed to client systems within the VPC.

---

### Additional Notes
- Always ensure the AD server has a static private IP to avoid connectivity issues.
- Secure passwords for administrator accounts and recovery modes to prevent unauthorized access.
- Regularly verify the DNS configurations on the AD server and client systems to ensure seamless domain connectivity.

This document provides the foundational steps to configure an AD forest using CLI, update Group Policy, and troubleshoot domain connectivity issues.


