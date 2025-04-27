---
title: "It’s all a Process: Analysis on how Docker works"
source: https://medium.com/@mynameisshrish/its-all-a-process-analysis-on-how-docker-works-5dcf89c1adaa
author: []
published: 2025-02-03
created: 2025-02-03
description: In early days businesses used to run applications on whole servers. Each application needs it’s own environment configuration and software requirements to run properly. Operating systems didn’t have…
tags:
  - clippings
---
[

![shrish](https://miro.medium.com/v2/resize:fill:88:88/0*GdK11yGsHAGsuAJG.jpg)

](https://medium.com/@mynameisshrish?source=post_page---byline--5dcf89c1adaa--------------------------------)

## Introduction

In early days businesses used to run applications on whole servers. Each application needs it’s own environment configuration and software requirements to run properly. Operating systems didn’t have the potential to run multiple applications in a single server and scaling the applications according to the demand was a huge task. To tackle this problem virtual machines were introduced.

![](https://miro.medium.com/v2/resize:fit:536/1*dcButpJfUvrhJiiiENv0TQ.png)

src: Google Images

## What are Virtual Machines?

VMs are a virtual emulation of a physical resources. A single host can have multiple VMs running in it. The main motive of VMs is to run multiple Operating Systems in a single host machine. VMs are created using hypervisor, a software that helps to isolate and emulate resources. The VM won’t be aware that it runs on a hypervisor. The VM behaves like it is running in a physical computer, giving near native performance. There are two types of hypervisors

> \* Type 1 is baremetal hypervisor that runs directly on top of the hardware  
> \* Type 2 hypervisor runs on top of a host OS that runs on top of hardware

The hypervisor controls the amount of resources each VM can access and utilise. Though multiple systems run on a single host they are securely isolated. Each VM have their own OS and their own kernel and boot-up time like normal systems.

![](https://miro.medium.com/v2/resize:fit:1132/1*nEIZveGSO4Sb6ZcY_piveQ.png)

src: [https://www.researchgate.net/figure/Type-1-and-type-2-hypervisors\_fig2\_335866538](https://www.researchgate.net/figure/Type-1-and-type-2-hypervisors_fig2_335866538)

With this virtualisation technology businesses started running multiple VMs (guests) in a single server (host) for every single application. But VMs are heavy as they come with their own kernel and OS. Sometimes the resource allocated to the VM may not be fully utilised by it. It takes time to spin up a VM as each VM have their own boot-up time.

## What is Docker?

![](https://miro.medium.com/v2/resize:fit:1000/1*VQidmLYwDuqbPcP-lMAc9w.png)

src: Google Images

Docker is a platform independent container runtime that allows to deploy containers. Containers are light weight, stand-alone, executables that contains all the environment, library, dependencies and configuration for an application software to run within it. Containers are spin up from docker ***Images***, built using a simple file called ***DockerFile***. Think of containers as instances of the docker images. Irrespective of the host OS docker containers behave same because everything needed for the application to run is within the container and not dependent on the host machine. Instead of requiring a separate new kernel docker shares the host kernel to run the containers. They are also isolated to providing security and allowing multiple containers to be run in a same host. Docker manages the creation and destruction of these containers.

![](https://miro.medium.com/v2/resize:fit:1400/1*v8TtIijnGbhb9ZIXiIjZmg.jpeg)

src: [https://www.altexsoft.com/blog/docker-pros-and-cons/](https://www.altexsoft.com/blog/docker-pros-and-cons/)

## Docker Architecture

Docker relies on client-server model. The server here is called Docker Daemon (*dockerd*), a background process that manages the docker objects and actual creation and destruction of the containers. Docker Client uses Docker API to communicate with *dockerd* and sends commands to execute. Generally Docker daemon and client runs on same host system but we can also manage to connect the client to the daemons running remotely. Docker Registry is a repository for docker images. Docker checks locally for the image, if the image is not present then it pulls from the registry.

![](https://miro.medium.com/v2/resize:fit:1400/1*JuLjOWZwentwAtlItI9U2w.png)

src: [https://www.geeksforgeeks.org/architecture-of-docker/](https://www.geeksforgeeks.org/architecture-of-docker/)

## Difference between Docker and VMs

- VMs require a complete OS and their own kernel to function where as a docker container can run on top of any host irrespective of the OS as they can share the host kernel
- Since docker containers are light weight they can be more portable and be run in any server or any platform seamlessly. VMs on other hand are heavy can’t be easily ported from one environment to another (for example, on premises to cloud).
- the light weightiness of docker container make them suitable for quick scalable deployments. Containers can be created and destroyed in seconds. VMs on the other hand have a boot-up time and cannot be started as quickly as containers.

## Starting Containers

The \`docker run\` command starts new container.

```
docker run [OPTIONS] IMAGE [COMMAND] [ARGS]
```

Lets take a look at command to start a Nginx container and name it as \`*webserver*\`

```
docker run -d --name webserver nginx
```
![](https://miro.medium.com/v2/resize:fit:1400/1*6rXySkYjes-Oq_Y0KwY34Q.png)

## How does Docker create Containers?

![](https://miro.medium.com/v2/resize:fit:1400/1*mANdHhsz_ZF7FOKL_2lIDg.jpeg)

Docker Engine utilises something called **Namespaces** to create isolated containers. Namespaces are a feature of linux kernel that partitions the resources. It provides abstraction so that the processes seem to have their own little world isolated from the rest of the processes. From an OS perspective all containers are nothing but merely processes. Currently there are 7 Linux Namespaces

- Mount
- PID
- Network
- Cgroup
- IPC
- Time
- UTS
- User

We can take look at all the namespaces in our system by using the command \`*sudo lsns*\`.

![](https://miro.medium.com/v2/resize:fit:1400/1*07ORlQ_rdbzZwjC4UvA2zw.png)

We can see that most processes in the system share multiple namespaces. Now lets start a Nginx container using previous command.

```
docker run -d --name webserver nginx
```

Now if we try \`*sudo lsns*\` we can see that new namespaces are created for for our Nginx container.

![](https://miro.medium.com/v2/resize:fit:1400/1*EsgNIdna16NIZD7SETqB6A.png)

Now lets open a bash shell inside the container with the following command.

```
docker exec -it webserver /bin/bash
```

This will create a bash shell and give us access inside a container.  
But wait if containers are just processes how are we able to go inside a container and open a bash shell? Try using \`*ls*\` command you will come to know that they have their own file system. How does a process have it’s own file system?

![](https://miro.medium.com/v2/resize:fit:1400/1*y-ufr3iLxWQrxhTK58KBjA.png)

To understand this lets create a file named \`*test\_file.txt*\` using the \`*touch*\` command and exit the bash shell by typing \`*exit*\` command.

![](https://miro.medium.com/v2/resize:fit:1400/1*b7uHrSCDMKFfykO6iaNxkg.png)

Now how can we access the files inside a container? The answer lies in the proc filesystem ([procfs](https://docs.kernel.org/filesystems/proc.html)). Linux processes have their own virtual filesystem that is created and destroyed with them. Every process is represented as a sub directories inside the \`*proc*\` directory. Let’s identify the PID (process id) of our container in the system (remember all containers are processes).

```
docker inspect -f '{{.State.Pid}}' webserver
```
![](https://miro.medium.com/v2/resize:fit:1400/1*uPFckaeYUaKK8-CeoPBm8w.png)

The PID here is 3414, it might be different for every system. Now lets take a look at the root directory of the process by using the following command.

```
sudo ls /proc/3414/root
```
![](https://miro.medium.com/v2/resize:fit:1400/1*tbnKTQam_npP_hV6N2TQdA.png)

We can see the \`*test\_file.txt*\` that we created inside the root directory of our container. Namespaces give us capability to create child processes that execute within the namespace. The bash shell we created inside the container is basically a child process of the container isolated from the host’s process namespace.

In fact we can create new set of namespaces and run commands in it using \`*unshare*\` command in Linux. The \`[*unshare*](https://man7.org/linux/man-pages/man1/unshare.1.html)\` command creates a new namespace and executes the given command in that namespace (if no command is given then bash shell is executed). Lets open a bash shell in a new PID and user namespace.

![](https://miro.medium.com/v2/resize:fit:1370/1*bvgzVf4brDKif_NhKprf2Q.png)

Notice how the \`*/bin/bash*\` process has PID as 1 because it is the first child process forked from the parent namespace. Let’s try \`*top*\` command in this namespace.

![](https://miro.medium.com/v2/resize:fit:1400/1*vdw40kPU53qBTmig3s_ICg.png)

Now open another terminal in the host and take a look at the processes using \`*ps -ef*\` command.

![](https://miro.medium.com/v2/resize:fit:1400/1*0RM2PvQf76O9RmzoucdzWA.png)

To our host system the process inside the forked namespace has a different PID. The PID inside the forked namespace is translated to a different PID so that the kernel will treat the process like just any other process. Also Notice that we are root user inside the forked namespace but to the host all the processes in that namespace were started by the user \`*hades*\`. The root privileges are only applicable with in that forked namespace rather than the host. So with help of namespaces we can give root access to non-root users in a new namespace.(Note that this root user won’t be able to perform root operations on the host namespace).

This is a good example of how isolation works in containers. The host can view inside the container but the vice-versa is not possible. Docker Engine makes use of the \`*unshare*\` command to create newly forked namespaces for the containers.

Docker also allows us to share the namespaces among containers. This can be particularly helpful to debug application containers. For example, lets try running a debugger container that will share the network and PID namespace of the Nginx webserver container we created previously.

```
docker run -it --name=debugger --pid=container:webserver --network=container:webserver alpine
```

This docker run command with arguments \` *— network*\` and \` *— pid*\` will make sure the \`*debugger*\` container will share the PID and network namespace of the \`webserver\` container.

![](https://miro.medium.com/v2/resize:fit:1400/1*i5HIS6OWblrHKDcRJo7Wpg.png)

We can see the processes that are in the \`*webserver*\` container from the \`*debugger*\`. Since we shared the network namespace with the debugger it would be possible to view the connection ports opened by the \`*webserver*\` container.

![](https://miro.medium.com/v2/resize:fit:1400/1*pi6ZTr6VozCH94C2y7vuqA.png)

## Conclusion

This is how containers are able to share the host kernel to emulate virtual environments and provide secure isolation. But remember that we are sharing the host kernel with the containers which means there is a vulnerability of compromising the host kernel. Even if one container is compromised the whole system can be hacked. That’s why it is important to know how containers work in the fundamental level and follow best practices to minimize such exploitations.