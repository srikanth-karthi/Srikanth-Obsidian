
The IANA (Internet Assigned Numbers Authority) is a department of ICANN (Internet Corporation for Assigned Names and Numbers) that oversees global IP address allocation, domain name system (DNS) root zone management, and other Internet protocol resources. Essentially, IANA coordinates the top-level domain (TLD) names (such as .com, .org, etc.) and the assignment of IP address ranges, making sure everything is managed in an orderly and global way.

### Name Servers

A **Name Server** (or DNS Server) is a server that handles queries regarding the location of a domain name’s services, like where the website is hosted. It translates human-readable domain names (like `example.com`) into IP addresses (like `192.168.1.1`), allowing browsers to load the website associated with a domain.

Each domain usually has two or more name servers to ensure availability. For example:

- `ns1.example.com`
- `ns2.example.com`

When setting up a domain, you will need to configure it with the correct name servers provided by your domain registrar or web hosting provider. These are then used to resolve the domain to the appropriate IP address.

In networking, **IP addresses** are grouped into classes based on their range and usage. The **classful network** architecture defines five classes (A, B, C, D, and E), with Classes A, B, and C being the most commonly used for public networks. Each class has a specific range of IP addresses and can handle a different number of hosts. Here's an overview of Classes A, B, and C:

### Class A IP Addresses

- **Range**: 1.0.0.0 to 126.255.255.255
- **Default Subnet Mask**: 255.0.0.0 (or /8 in CIDR notation)
- **Number of Networks**: 128 networks (2^7 - 2, where 7 is the number of bits used for the network portion, minus reserved addresses)
- **Number of Hosts per Network**: ~16.7 million (2^24 - 2 usable hosts)
- **Use Case**: Class A is used for very large networks, such as those of large corporations, ISPs, or government entities.

### Class B IP Addresses

- **Range**: 128.0.0.0 to 191.255.255.255
- **Default Subnet Mask**: 255.255.0.0 (or /16 in CIDR notation)
- **Number of Networks**: 16,384 networks (2^14)
- **Number of Hosts per Network**: ~65,534 (2^16 - 2 usable hosts)
- **Use Case**: Class B is used for medium to large-sized networks, such as universities or mid-sized businesses.

### Class C IP Addresses

- **Range**: 192.0.0.0 to 223.255.255.255
- **Default Subnet Mask**: 255.255.255.0 (or /24 in CIDR notation)
- **Number of Networks**: ~2.1 million networks (2^21)
- **Number of Hosts per Network**: 254 (2^8 - 2 usable hosts)
- **Use Case**: Class C is used for smaller networks, such as small businesses or home networks.

### Special Classes:

- **Class D**: Reserved for multicast. Range: 224.0.0.0 to 239.255.255.255
- **Class E**: Reserved for experimental use. Range: 240.0.0.0 to 255.255.255.255

### Breakdown of IP Address Classes:

|Class|Range|Subnet Mask|Number of Hosts|Use Case|
|---|---|---|---|---|
|A|1.0.0.0 - 126.255.255.255|255.0.0.0 (/8)|~16.7 million per network|Large organizations/ISPs|
|B|128.0.0.0 - 191.255.255.255|255.255.0.0 (/16)|~65,534 per network|Medium organizations|
|C|192.0.0.0 - 223.255.255.255|255.255.255.0 (/24)|254 per network|Small networks|
|D|224.0.0.0 - 239.255.255.255|N/A|N/A|Multicasting|
|E|240.0.0.0 - 255.255.255.255|N/A|N/A|Experimental|

In modern networking, classful addressing is less common due to the introduction of **Classless Inter-Domain Routing (CIDR)**, which allows more flexibility in IP address allocation by using variable-length subnet masks.
