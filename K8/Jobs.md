---
tags:
  - k8
---
### Kubernetes **Jobs**

A **Job** in Kubernetes is used for running **one-off tasks** that run to completion. It ensures that a specified number of Pods complete successfully, even if some Pods fail or nodes go down. Jobs are commonly used for tasks like batch processing, data migration, and database backup.

---

### **Key Features of Jobs**

1. **Run-to-Completion Tasks**:
   - Jobs create one or more Pods and retry failed Pods until a specified number of completions are reached.
   - Once complete, the Job stops, and its status reflects success or failure.

2. **Fault Tolerance**:
   - If a Pod fails or is deleted (e.g., due to a node failure), the Job controller recreates it until the desired completions are achieved.

3. **Supports Parallelism**:
   - Jobs can be configured to run tasks in parallel for faster execution.

4. **Deletion and Suspension**:
   - Deleting a Job removes all its Pods.
   - Jobs can also be suspended, which terminates active Pods until resumed.

---

### **When to Use Jobs**

- **One-Time Tasks**:
  - Data processing, report generation, backups, and analytics.
  
- **Parallel Workloads**:
  - Dividing a large task into smaller tasks that can be processed concurrently.

- **Fail-Safe Task Execution**:
  - Ensures tasks run reliably, even in the event of Pod or node failures.

For scheduled tasks, use a **CronJob**.

---

### **How Jobs Work**

1. **Job Creation**:
   - A Job object defines a task to run in one or more Pods.
   - Kubernetes ensures the desired number of successful completions.

2. **Pod Lifecycle**:
   - Pods are created based on the Job's template.
   - Restart policies dictate how Pods are recreated on failure:
     - `Never`: Pod does not restart after failure.
     - `OnFailure`: Container restarts on failure within the same Pod.

3. **Retries and Backoff**:
   - Jobs retry Pods on failure with exponential backoff (default limit: 6 retries).

4. **Completion**:
   - Once the specified number of successful completions is reached, the Job is marked as complete.

---

### **Writing a Job Spec**

A Job specification (`.yaml`) defines:
- **Pod Template**:
  - The Pod to be created for the Job.
  - Must include the `RestartPolicy` (allowed values: `Never` or `OnFailure`).
- **Parallelism** and **Completions**:
  - Configure how many Pods run in parallel and the total completions required.

#### **Example: A Simple Job**

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: example-job
spec:
  parallelism: 1
  completions: 1
  backoffLimit: 4
  template:
    spec:
      containers:
      - name: compute-pi
        image: perl:5.34.0
        command: ["perl", "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
```

- **`parallelism`**: Number of Pods to run concurrently.
- **`completions`**: Total number of Pods that need to complete successfully.
- **`backoffLimit`**: Maximum retries per Pod before marking the Job as failed.

---

### **Monitoring Jobs**

- **View Job Status**:
  ```bash
  kubectl get jobs
  kubectl describe job <job-name>
  ```

- **Check Completed Pods**:
  ```bash
  kubectl get pods --selector=batch.kubernetes.io/job-name=<job-name>
  ```

- **View Logs of a Job**:
  ```bash
  kubectl logs jobs/<job-name>
  ```

---

### **Parallelism in Jobs**

Kubernetes Jobs can be configured for parallel execution:

1. **Non-Parallel Jobs**:
   - Single Pod runs to completion.
   - Set both `parallelism` and `completions` to `1`.

2. **Fixed Completion Count**:
   - Specify `completions` > 1.
   - The Job runs `completions` number of Pods.

3. **Work Queue Pattern**:
   - Pods fetch tasks from a queue.
   - `completions` is unset; parallelism dictates the number of active Pods.

4. **Indexed Jobs**:
   - Pods are assigned unique indices for deterministic behavior.
   - Use `.spec.completionMode: Indexed`.

---

### **Advanced Features**

#### **1. Pod Failure Policies**
Customize how Job handles Pod failures:
- Ignore transient errors or retry based on specific failure codes.
- Use `.spec.podFailurePolicy`.

#### **2. Active Deadline**
Set a time limit for the Job to run:
```yaml
spec:
  activeDeadlineSeconds: 600
```

#### **3. TTL for Finished Jobs**
Automatically clean up completed or failed Jobs:
```yaml
spec:
  ttlSecondsAfterFinished: 100
```

#### **4. Suspend and Resume Jobs**
Suspend a Job:
```bash
kubectl patch job <job-name> --patch '{"spec": {"suspend": true}}'
```

Resume a Job:
```bash
kubectl patch job <job-name> --patch '{"spec": {"suspend": false}}'
```

#### **5. Success Policy**
Define criteria for a Job to succeed:
```yaml
spec:
  successPolicy:
    rules:
    - succeededCount: 3
```

---

### **Best Practices**

1. **Use `RestartPolicy: Never`** for simplicity unless specific behavior is needed.
2. **Monitor Logs**:
   - Use centralized logging to capture Job output.
3. **Define Backoff Limits**:
   - Avoid infinite retries by setting a reasonable `backoffLimit`.
4. **Optimize Parallelism**:
   - Balance resource utilization with task requirements.
5. **Clean Up**:
   - Use TTL to delete finished Jobs automatically.

---

### **Job Alternatives**

1. **Bare Pods**:
   - Use for tasks not requiring retries or fault tolerance.
   - Not recommended for production due to lack of self-healing.

2. **CronJobs**:
   - Schedule Jobs to run periodically.

3. **Replication Controllers**:
   - For long-running tasks like web servers or background processes.

---

### **What’s Next?**
- Learn about **CronJobs** for scheduling tasks.
- Explore **Indexed Jobs** for parallel tasks with deterministic work assignments.
- Practice setting up **Pod Failure Policies** and **Success Policies**.
