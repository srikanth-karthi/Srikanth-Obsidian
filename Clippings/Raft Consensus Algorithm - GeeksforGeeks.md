---
title: Raft Consensus Algorithm - GeeksforGeeks
source: https://www.geeksforgeeks.org/raft-consensus-algorithm/
author:
  - "[[GeeksforGeeks]]"
published: 2018-11-09
created: 2024-12-15
description: A Computer Science portal for geeks. It contains well written, well thought and well explained computer science and programming articles, quizzes and practice/competitive programming/company interview Questions.
tags:
  - Algo
---
This article will help you give a brief history about Raft, what is consensus, what is the RAFT protocol, what are the advantages, how is it better than its alternatives, what are some limitations of the RAFT protocol. 

## Introduction

Raft protocol was developed by Diego Ongaro and John Ousterhout (Stanford University) which won Diego his Ph.D in 2014(The link for the paper is in the References section at the end of the article). Raft was designed for better understandability of how Consensus(we will explain what consensus is, in a moment) can be achieved considering that its predecessor, the Paxos Algorithm, developed by Lesli Lamport is very difficult to understand and implement. Hence, the title of the paper by Diego, ‘In Search of an Understandable Consensus Algorithm’. Before Raft, Paxos was considered the holy grail in achieving Consensus..   
Lets start. 

## Consensus

So, to understand Raft, we shall first have a look at the problem which the Raft protocol tries to solve and that is achieving Consensus. Consensus means multiple servers agreeing on same information, something imperative to design fault-tolerant distributed systems. Lets describe it with the help of couple visuals.   
So, lets first define the process used when a client interacts with a server to clarify the process.   
****Process**** : The client sends a message to the server and the server responds back with a reply. 

A consensus protocol tolerating failures must have the following features :   
 

- ****Validity**** : If a process decides(read/write) a value, then it must have been proposed by some other correct process
- ****Agreement**** : Every correct process must agree on the same value
- ****Termination**** : Every correct process must terminate after a finite number of steps.
- ****Integrity**** : If all correct processes decide on the same value, then any process has the said value.

Now, there can be two types of systems assuming only one client(for the sake of understandability):   
 

- ****Single Server system**** : The client interacts with a system having only one server with no backup. There is no problem in achieving consensus in such a system.

![single server raft visual](https://media.geeksforgeeks.org/wp-content/uploads/single-server-1-raft-visual.png)

single server raft visual

- ****Multiple Server system**** : The client interacts with a system having multiple servers. Such systems can be of two types :
- Symmetric :- Any of the multiple servers can respond to the client and all the other servers are supposed to sync up with the server that responded to the client’s request, and
- Asymmetric :- Only the elected leader server can respond to the client. All other servers then sync up with the leader server.

Such a system in which all the servers replicate(or maintain) similar data(shared state) across time can for now be referred to as, replicated state machine. 

We shall now define some terms used to refer individual servers in a distributed system.   
 

- ****Leader**** – Only the server elected as leader can interact with the client. All other servers sync up themselves with the leader. At any point of time, there can be ****at most one leader****(possibly 0, which we shall explain later)
- ****Follower**** – Follower servers sync up their copy of data with that of the leader’s after every regular time intervals. When the leader server goes down(due to any reason), one of the followers can contest an election and become the leader.
- ****Candidate**** – At the time of contesting an election to choose the leader server, the servers can ask other servers for votes. Hence, they are called candidates when they have requested votes. Initially, all servers are in the Candidate state.

So, the above system can now be labelled as in the following snap.   
 

![multiple server labelled raft visual](https://media.geeksforgeeks.org/wp-content/uploads/multiple-server-labelled-raft-visual.png)

multiple server labelled raft visual

****CAP theorem**** CAP Theorem is a concept that a distributed database system can only have 2 of the 3: 

- ****Consistency**** – The data is same in all the server nodes(leader or follower), implying the system has nearly instantaneous sync capabilities
- ****Availability**** – Every request gets a response(success/failure). It requires the system to be operational 100% of the time to serve requests, and
- ****Partition Tolerance**** – The system continues to respond, even after some of the server nodes fail. This implies that the system maintains all the requests/responses function somehow.

## What is the Raft protocol

Raft is a consensus algorithm that is designed to be easy to understand. It’s equivalent to Paxos in fault-tolerance and performance. The difference is that it’s decomposed into relatively independent subproblems, and it cleanly addresses all major pieces needed for practical systems. We hope Raft will make consensus available to a wider audience, and that this wider audience will be able to develop a variety of higher quality consensus-based systems than are available today. 

## Raft consensus algorithm explained

To begin with, Raft states that each node in a replicated state machine(server cluster) can stay in any of the three states, namely, leader, candidate, follower. The image below will provide the necessary visual aid.   
 

![](https://media.geeksforgeeks.org/wp-content/uploads/20201003144908/nodestatustransitions-300x150.png)

Under normal conditions, a node can stay in any one of the above three states. Only a leader can interact with the client; any request to the follower node is redirected to the leader node. A candidate can ask for votes to become the leader. A follower only responds to candidate(s) or the leader. 

To maintain these server status(es), the Raft algorithm divides time into small terms of arbitrary length. Each term is identified by a monotonically increasing number, called ****term number****.   
****Term number****   
This term number is maintained by every node and is passed while communications between nodes. Every term starts with an election to determine the new leader. The candidates ask for votes from other server nodes(followers) to gather majority. If the majority is gathered, the candidate becomes the leader for the current term. If no majority is established, the situation is called a ****split vote**** and the term ends with no leader. Hence, a term can have ****at most**** one leader.   
****Purpose of maintaining term number****   
Following tasks are executed by observing the term number of each node:   
 

- Servers update their term number if their term number is less than the term numbers of other servers in the cluster. This means that when a new term starts, the term numbers are tallied with the leader or the candidate and are updated to match with the latest one(Leader’s)
- Candidate or Leader demotes to the Follower state if their term number is out of date(less than others). If at any point of time, any other server has a higher term number, it can become the Leader immediately.
- As we said earlier that the term number of the servers are also communicated, if a request is achieved with a stale term number, the said request is rejected. This basically means that a server node will not accept requests from server with lower term number

Raft algorithm uses two types of Remote Procedure Calls(RPCs) to carry out the functions :   
 

- ****RequestVotes**** RPC is sent by the Candidate nodes to gather votes during an election
- ****AppendEntries**** is used by the Leader node for replicating the log entries and also as a heartbeat mechanism to check if a server is still up. If heartbeat is responded back to, the server is up else, the server is down. Be noted that the heartbeats do not contain any log entries.

Now, lets have a look at the process of leader election.   
 

## Leader election

In order to maintain authority as a Leader of the cluster, the Leader node sends heartbeat to express dominion to other Follower nodes. A leader election takes place when a Follower node times out while waiting for a heartbeat from the Leader node. At this point of time, the timed out node changes it state to Candidate state, votes for itself and issues RequestVotes RPC to establish majority and attempt to become the Leader. The election can go the following three ways:   
 

- The Candidate node becomes the Leader by receiving the majority of votes from the cluster nodes. At this point of time, it updates its status to Leader and starts sending heartbeats to notify other servers of the new Leader.
- The Candidate node fails to receive the majority of votes in the election and hence the term ends with no Leader. The Candidate node returns to the Follower state.
- If the term number of the Candidate node requesting the votes is less than other Candidate nodes in the cluster, the AppendEntries RPC is rejected and other nodes retain their Candidate status. If the term number is greater, the Candidate node is elected as the new Leader.

![raft leader election](https://media.geeksforgeeks.org/wp-content/uploads/raft-leader-election.png)

raft leader election

The following excerpt from the Raft paper(linked in the references below) explains a significant aspect of server timeouts. 

> Raft uses randomized election timeouts to ensure that split votes are rare and that they are resolved quickly. To prevent split votes in the first place, election timeouts are chosen randomly from a fixed interval (e.g., 150–300ms). This spreads out the servers so that in most cases only a single server will time out; it wins the election and sends heartbeats before any other servers time out. The same mechanism is used to handle split votes. Each candidate restarts its randomized election timeout at the start of an election, and it waits for that timeout to elapse before starting the next election; this reduces the likelihood of another split vote in the new election.   
>  

## Log Replication

For the sake of simplicity while explaining to the beginner level audience, we will restrict our scope to client making only write requests. Each request made by the client is stored in the Logs of the Leader. This log is then replicated to other nodes(Followers). Typically, a log entry contains the following three information :   
 

- ****Command**** specified by the client to execute
- ****Index**** to identify the position of entry in the log of the node. The index is 1-based(starts from 1).
- ****Term Number**** to ascertain the time of entry of the command.

The Leader node fires AppendEntries RPCs to all other servers(Followers) to sync/match up their logs with the current Leader.The Leader keeps sending the RPCs until all the Followers safely replicate the new entry in their logs. 

There is a concept of entry commit in the algorithm. When the majority of the servers in the cluster successfully copy the new entries in their logs, it is considered committed. At this point, the Leader also commits the entry in its log to show that it has been successfully replicated. All the previous entries in the log are also considered committed due to obvious reasons. After the entry is committed, the leader executes the entry and responds back with the result to the client.   
It should be noted that these entries are executed in the order they are received. 

If two entries in different logs(Leader’s and Followers’) have identical index and term, they are guaranteed to store the same command and the logs are identical upto that point(Index). 

However, in case the Leader crashes, the logs may become inconsistent. Quoting the Raft paper :   
 

> In Raft, the leader handles inconsistencies by forcing the followers’ logs to duplicate its own. This means that conflicting entries in follower logs will be overwritten with entries from the leader’s log.   
>  

The Leader node will look for the last matched index number in the Leader and Follower, it will then overwrite any extra entries further that point(index number) with the new entries supplied by the Leader. This helps in Log matching the Follower with the Leader. The AppendEntries RPC will iteratively send the RPCs with reduced Index Numbers so that a match is found. When the match is found, the RPC succeeds. 

## Safety

In order to maintain consistency and same set of server nodes, it is ensured by the Raft consensus algorithm that the leader will have all the entries from the previous terms committed in its log. 

During a leader election, the RequestVote RPC also contains information about the candidate’s log(like term number) to figure out which one is the latest. If the candidate requesting the vote has less updated data than the Follower from which it is requesting vote, the Follower simply doesn’t vote for the said candidate. The following excerpt from the original Raft paper clears it in a similar and profound way.   
 

> Raft determines which of two logs is more up-to-date by comparing the index and term of the last entries in the logs. If the logs have last entries with different terms, then the log with the later term is more up-to-date. If the logs end with the same term, then whichever log is longer is more up-to-date.   
>  

****Rules for Safety in the Raft protocol****   
The Raft protocol guarantees the following safety against consensus malfunction by virtue of its design :   
 

- ****Leader election safety**** – At most one leader per term)
- ****Log Matching safety****(If multiple logs have an entry with the same index and term, then those logs are guaranteed to be identical in all entries up through to the given index.
- ****Leader completeness**** – The log entries committed in a given term will always appear in the logs of the leaders following the said term)
- ****State Machine safety**** – If a server has applied a particular log entry to its state machine, then no other server in the server cluster can apply a different command for the same log.
- ****Leader is Append-only**** – A leader node(server) can only append(no other operations like overwrite, delete, update are permitted) new commands to its log
- ****Follower node crash**** – When the follower node crashes, all the requests sent to the crashed node are ignored. Further, the crashed node can’t take part in the leader election for obvious reasons. When the node restarts, it syncs up its log with the leader node

## Cluster membership and Joint Consensus

When the status of nodes in the cluster changes(cluster configuration changes), the system becomes susceptible to faults which can break the system. So, to prevent this, Raft uses what is known as a two phase approach to change the cluster membership. So, in this approach, the cluster first changes to an intermediate state(known as ****joint consensus****) before achieving the new cluster membership configuration. Joint consensus makes the system available to respond to client requests even when the transition between configurations is taking place. Thus, increasing the availability of the distributed system, which is a main aim. 

## What are its advantages/Features

- The Raft protocol is designed to be easily understandable considering that the most popular way to achieve consensus on distributed systems was the Paxos algorithm, which was very hard to understand and implement. Anyone with basic knowledge and common sense can understand major parts of the protocol and the research paper published by Diego Ongaro and John Ousterhout
- It is comparatively easy to implement than other alternatives, primarily the Paxos, because of a more targeted use case segment, assumptions about the distributed system. Many open source implementations of the Raft are available on the internet. Some are in Go, C++, Java
- The Raft protocol has been decomposed into smaller subproblems which can be tackled relatively independently for better understanding, implementation, debugging, optimizing performance for a more specific use case
- The distributed system following the Raft consensus protocol will remain operational even when minority of the servers fail. For example, if we have a 5 server node cluster, if 2 nodes fail, the system can still operate.
- The leader election mechanism employed in the Raft is so designed that one node will always gain the majority of votes within a maximum of 2 terms.
- The Raft employs RPC(remote procedure calls) to request votes and sync up the cluster(using AppendEntries). So, the load of the calls does not fall on the leader node in the cluster.
- Raft was designed recently, so it employs modern concepts which were not yet understood at the time of the formulation of the Paxos and similar protocols.
- Any node in the cluster can become the leader. So, it has a certain degree of fairness.
- Many different open source implementations for different use cases are already out there on GitHub and related places
- Companies like MongoDB, HashiCorp, etc. are using it!

## Raft Alternatives

- Paxos – Variants :- multi-paxos, cheap paxos, fast paxos, generalised paxos
- Practical Byzantine Fault Tolerance algorithm (PBFT)
- Proof-of-Stake algorithm (PoS)
- Delegated Proof-of-Stake algorithm (DPoS)

## Limitations

- Raft is strictly single Leader protocol. Too much traffic can choke the system. Some variants of Paxos algorithm exist that address this bottleneck.
- There are a lot of assumptions considered to be acting, like non-occurrence of Byzantine failures, which sort of reduces the real life applicability.
- Raft is a more specialized approach towards a ****subset of problems**** which arise in achieving consensus.
- Cheap-paxos(a variant of Paxos), can work even when there is only one node functioning in the server cluster. To generalise, K+1 replicated servers can tolerate shutting down of/ fault in K servers.

  

***Get ready to boost your rank and secure an exceptional GATE 2025 score with confidence!***

Our [**GATE CS & IT Test Series 2025**](https://gfgcdn.com/tu/U2H/) offers **60 PYQs Quizzes**, **60 Subject-Wise Mock Tests**, **4500+ PYQs** and **practice questions**, and over **20 Full-Length Mock Tests** that ensure you’re well-prepared to tackle the toughest questions and secure a top-rank in the GATE 2025 exam. Get personalized insights with student rankings based on performance and benefit from expert-designed tests created by industry pros and GATE CS toppers.

Plus, don’t miss out on these exclusive features:

**\--> All India Mock Test**  
**\--> Live GATE CSE Mentorship Classes**  
**\--> Live Doubt Solving Sessions** 

*Join now and stay ahead in your GATE 2025 journey!*

  

[![News](https://media.geeksforgeeks.org/auth-dashboard-uploads/Google-news.svg)](https://news.google.com/publications/CAAqBwgKMLTrzwsw44bnAw?hl=en-IN&gl=IN&ceid=IN%3Aen)

Improve