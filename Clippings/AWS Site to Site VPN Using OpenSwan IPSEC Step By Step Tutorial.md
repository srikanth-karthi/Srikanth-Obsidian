---
title: "AWS Site to Site VPN Using OpenSwan IPSEC Step By Step Tutorial"
source: "https://kloudvm.medium.com/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial-c525a97487a3"
author:
  - "[[kloudvm]]"
published: 2022-04-01
created: 2025-01-28
description: "In this tutorial, we are going to go through how to set up a site to site VPN between your on-premise (VPC-B) and AWS Network (VPC-A) using OpenSwan. Typically the Site to Site VPN setup looks like…"
tags:
  - "clippings"
---
[

![kloudvm](https://miro.medium.com/v2/resize:fill:88:88/1*MZMi1spg07_cdIV9VpklvA.png)

](https://kloudvm.medium.com/?source=post_page---byline--c525a97487a3--------------------------------)

In this tutorial, we are going to go through how to set up a site to site VPN between your on-premise (VPC-B) and AWS Network (VPC-A) using [OpenSwan](https://aws.amazon.com/blogs/networking-and-content-delivery/simulating-site-to-site-vpn-customer-gateways-strongswan/).

OpenSWan is open-source software, which can be used for IPSec [VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) access in the Linux environment.

**Contents**

[1 Create the required VPCs](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Create_the_required_VPCs)

[2 Create a Private EC2 instance in VPC A and Record the Private IP](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Create_a_Private_EC2_instance_in_VPC_A_and_Record_the_Private_IP)

[3 Create OpenSwan EC2 Instance in VPC-B Public Subnet and Record its Public IP](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Create_OpenSwan_EC2_Instance_in_VPC-B_Public_Subnet_and_Record_its_Public_IP)

[4 Create a VPC Customer Gateway to Use for Your Site-to-Site VPN Connection](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Create_a_VPC_Customer_Gateway_to_Use_for_Your_Site-to-Site_VPN_Connection)

[5 Create Virtual Private Gateway and Attach it to VPC A to Use in Your VPN Connection Setup](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Create_Virtual_Private_Gateway_and_Attach_it_to_VPC_A_to_Use_in_Your_VPN_Connection_Setup)

[6 Create an AWS VPN Connection and Use the Previously Created CGW and VGW](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Create_an_AWS_VPN_Connection_and_Use_the_Previously_Created_CGW_and_VGW)

[7 Installing and Configuring OpenSwan on Amazon Linux 2 and Setting Up Tunnel 1](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Installing_and_Configuring_OpenSwan_on_Amazon_Linux_2_and_Setting_Up_Tunnel_1)

[8 Enable Route Propagation on VPC-A to Allow Packets to Pass Through](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Enable_Route_Propagation_on_VPC-A_to_Allow_Packets_to_Pass_Through)

[9 Testing VPN Connectivity Between Two Sites On Premise and AWS Network](https://kloudvm.com/aws/aws-site-to-site-vpn-using-openswan-ipsec-step-by-step-tutorial/#Testing_VPN_Connectivity_Between_Two_Sites_On_Premise_and_AWS_Network)

![](https://miro.medium.com/v2/resize:fit:1400/0*_VOAT4yG1v9bPIpe.png)

Typically the Site to Site VPN setup looks like above diagram where at one end its AWS VPC and other end its corporate network with edge router. However as we don’t have access to corporate network; for this exercise, we will simulate the corporate network by using another AWS VPC in another AWS region. We will configure EC2 in this VPC which acts as the router at customer end. For this router we will use OpenSWAN software. VPC A acts as AWS side of the network and VPC B acts as a customer network.

## Create the required VPCs

We will take advantage of the new Create VPC dashboard to create two identical VPCs with one public subnet and one private subnet.

![](https://miro.medium.com/v2/resize:fit:1400/0*iK1WGUiNyeBzDZNG.png)

![](https://miro.medium.com/v2/resize:fit:1400/0*9Pb1Z1tHrcPXAXk6.png)

![](https://miro.medium.com/v2/resize:fit:1400/0*FYzomL9QDMFGdbaq.png)

We should end up with the below result.

![](https://miro.medium.com/v2/resize:fit:1400/0*dg4UUg_yvOO9y0j_.png)

## Create a Private EC2 instance in VPC A and Record the Private IP

We will now create a private EC2 instance that we will use to test the connectivity from the on-premise network (VPC-B) to VPC-A’s private network.

At this point I will assume you know how to create an EC2 instance. You can refer to a [previous article](https://kloudvm.com/aws/cannot-ssh-to-ec2-instance-disk-full/) where we show exactly how to create an EC2 instance.

We are launching the instance in the private subnet of VPC-A.

![](https://miro.medium.com/v2/resize:fit:1400/0*f4ZnlCWNdg_zMM0L.png)

Note that we will attach the below Security Group to the EC2 instance.

![](https://miro.medium.com/v2/resize:fit:1400/0*ImyPalw6OA9DVDpZ.png)

![](https://miro.medium.com/v2/resize:fit:1400/0*EwUvmUZMd67DRx0m.png)

## Create OpenSwan EC2 Instance in VPC-B Public Subnet and Record its Public IP

We will create another EC2 with Amazon Linux 2 in VPC-B public subnet. We will use this EC2 instance to install and run OpenSwan for our Site to Site VPN connection.

![](https://miro.medium.com/v2/resize:fit:1400/0*rPVBeWMCsPcu9Fmi.png)

Note the security group inbound rules we are using for the OpenSwan EC2 instance. We will allow SSH from our IP connection only for security purposes.

You also might want to consider [attaching an Elastic IP](https://kloudvm.com/aws/lightsail-static-ip-create-and-attach-server/) to the OpenSwan instance.

![](https://miro.medium.com/v2/resize:fit:1400/0*3qq5OG8oV4vUzwia.png)

## Create a VPC Customer Gateway to Use for Your Site-to-Site VPN Connection

A customer gateway is a resource that is installed on the customer side and is often linked to the provider side. It provides a customer gateway inside a VPC. These objects can be connected to VPN gateways via VPN connections, and allow you to establish tunnels between your network and the VPC.

In our case, the customer gateway is the OpenSwan instance that we are going to provision.

![](https://miro.medium.com/v2/resize:fit:1400/0*eVejlyqbdavu290_.png)

If you look closely, we used the IP address of the OpenSwan EC2 instance.

## Create Virtual Private Gateway and Attach it to VPC A to Use in Your VPN Connection Setup

We will now create the virtual gateway and then attach it to VPC-A. A virtual private gateway is a logical, fully redundant distributed edge routing function that sits at the edge of your VPC.

As it is capable of terminating VPN connections from your on-prem or customer environments, the VGW is the VPN concentrator on the Amazon side of the Site-to-Site VPN connection.

## Create an AWS VPN Connection and Use the Previously Created CGW and VGW

We will now create a Site-to-Site VPN connection and will use the previous resources we have created.

This connection will create the necessary tunnels needed to establish a VPN connection between site A and site B.

Note that for the static IP prefix, we used the IP prefix of VPC-B

## Installing and Configuring OpenSwan on Amazon Linux 2 and Setting Up Tunnel 1

The first step is to download the configuration file from the AWS console. Head over to the VPN Connections console and click on Download Configuration

**SSH into the OpenSwan instance using the public IP:**

```
$ ssh -i networking-key.pem ec2-user@3.26.227.46__| __|_ )
_| ( / Amazon Linux 2 AMI
___|\___|___|https://aws.amazon.com/amazon-linux-2/
[ec2-user@ip-172-16-9-212 ~]$
```

**Change to root user and install openswan package:**

```
[ec2-user@ip-172-16-9-212 ~]$ sudo su -
[root@ip-172-16-9-212 ~]# yum install openswan -y
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
amzn2-core | 3.7 kB 00:00:00
Resolving Dependencies
--> Running transaction check
---> Package libreswan.x86_64 0:3.25-4.8.amzn2.0.1 will be installed
--> Processing Dependency: unbound-libs >= 1.6.6 for package: libreswan-3.25-4.8.amzn2.0.1.x86_64
--> Processing Dependency: libunbound.so.2()(64bit) for package: libreswan-3.25-4.8.amzn2.0.1.x86_64
--> Processing Dependency: libldns.so.1()(64bit) for package: libreswan-3.25-4.8.amzn2.0.1.x86_64
--> Running transaction check
---> Package ldns.x86_64 0:1.6.16-10.amzn2.0.2 will be installed
---> Package unbound-libs.x86_64 0:1.7.3-15.amzn2.0.4 will be installed
--> Finished Dependency ResolutionDependencies Resolved===================================================================================================
Package Arch Version Repository Size
===================================================================================================
Installing:
libreswan x86_64 3.25-4.8.amzn2.0.1 amzn2-core 1.4 M
Installing for dependencies:
ldns x86_64 1.6.16-10.amzn2.0.2 amzn2-core 477 k
unbound-libs x86_64 1.7.3-15.amzn2.0.4 amzn2-core 485 kTransaction Summary
===================================================================================================
Install 1 Package (+2 Dependent packages)Total download size: 2.3 M
Installed size: 7.3 M
Downloading packages:
(1/3): ldns-1.6.16-10.amzn2.0.2.x86_64.rpm | 477 kB 00:00:00
(2/3): libreswan-3.25-4.8.amzn2.0.1.x86_64.rpm | 1.4 MB 00:00:00
(3/3): unbound-libs-1.7.3-15.amzn2.0.4.x86_64.rpm | 485 kB 00:00:00
---------------------------------------------------------------------------------------------------
Total 8.7 MB/s | 2.3 MB 00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
Installing : ldns-1.6.16-10.amzn2.0.2.x86_64 1/3
Installing : unbound-libs-1.7.3-15.amzn2.0.4.x86_64 2/3
Installing : libreswan-3.25-4.8.amzn2.0.1.x86_64 3/3
Verifying : libreswan-3.25-4.8.amzn2.0.1.x86_64 1/3
Verifying : unbound-libs-1.7.3-15.amzn2.0.4.x86_64 2/3
Verifying : ldns-1.6.16-10.amzn2.0.2.x86_64 3/3Installed:
libreswan.x86_64 0:3.25-4.8.amzn2.0.1Dependency Installed:
ldns.x86_64 0:1.6.16-10.amzn2.0.2 unbound-libs.x86_64 0:1.7.3-15.amzn2.0.4Complete!
[root@ip-172-16-9-212 ~]#
```

**Open /etc/sysctl.conf and ensure that its values match the following:**

```
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.accept_source_route = 0
```

**Apply the changes in step 1 by executing the command ‘sysctl -p’**

**Open /etc/ipsec.conf and look for the line below. Ensure that the # in front of the line has been removed, then save and exit the file.**

```
#include /etc/ipsec.d/*.conf
```

**Create a new file at /etc/ipsec.d/aws.conf**

**Append the following configuration to the end in the file.**

**<LOCAL NETWORK> with the IP CIDR of the on-premise (VPC-B) which is 172.16.0.0/16**

**<REMOTE NETWORK> with the IP CIDR of the AWS Network (VPC-A) which is 10.0.0.0/16**

```
conn Tunnel1
	authby=secret
	auto=start
	left=%defaultroute
	leftid=3.26.227.46
	right=52.64.9.36
	type=tunnel
	ikelifetime=8h
	keylife=1h
	phase2alg=aes128-sha1;modp1024
	ike=aes128-sha1;modp1024
	keyingtries=%forever
	keyexchange=ike
	leftsubnet=<LOCAL NETWORK>
	rightsubnet=<REMOTE NETWORK>
	dpddelay=10
	dpdtimeout=30
	dpdaction=restart_by_peerMake sure you remove auth=esp from the above configuration. 
Authentication headers cannot be used while a NAT gateway is present between the VPN endpoints.
```

**Create a new file at /etc/ipsec.d/aws.secrets if it doesn’t already exist, and append this line to the file:**

**The PSK key can be copied from the configuration file you downloaded.**

```
3.26.227.46 52.64.9.36: PSK "c5ubRB5ZI3Y.tRVITQLSEofiHc"
```

**Configure ipsec service to be ON on reboot:**

```
chkconfig ipsec on
```

**Start the ipsec service:**

```
systemctl start ipsec
```

**Check status of the service:**

```
systemctl status ipsec
```

If you have completed all the steps properly then your VPN Connection should be setup at this point.

AWS offers in total two VPN tunnels which you can configure. The above was a configuration for just one VPN tunnel (Tunnel 1).

## Enable Route Propagation on VPC-A to Allow Packets to Pass Through

Before testing the connectivity between VPC-A and VPC-B, we need to make sure that the required [routes are propagated](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPNRoutingTypes.html) in VPC-A.

Currently, there are no routes in the route table associated with the private subnet of VPC-A that would dictate where/how should be the packets being sent to network 17.16.0.0/16 be forwarded.

We can either add the route ourselves, or we can take advantage of the route propagation mechanism.

After enabling route propagation, you can see a new route has been added which forwards packets destined to network 172.16.0.0 to target VGW.

## Testing VPN Connectivity Between Two Sites On Premise and AWS Network

Now that we can see that Tunnel 1 is up and running. Let’s test the connectivity between the on-prem VPC-B and AWS Network VPC-A:

![](https://miro.medium.com/v2/resize:fit:1400/0*6BIPEqQCap4BKe_z.png)

From the OpenSwan EC2 instance, ping the private IP of the EC2 instance in VPC-A:

```
[root@ip-172-16-9-212 ~]# ping 10.0.134.219
PING 10.0.134.219 (10.0.134.219) 56(84) bytes of data.
64 bytes from 10.0.134.219: icmp_seq=1 ttl=64 time=2.67 ms
64 bytes from 10.0.134.219: icmp_seq=2 ttl=64 time=2.04 ms
^C
--- 10.0.134.219 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 2.045/2.361/2.678/0.320 ms
```