---
tags:
  - k8
---
### Kubernetes **CronJob**

A **CronJob** in Kubernetes is used to schedule and manage **periodic jobs**. It is similar to the `cron` system utility in Unix/Linux. Each CronJob is responsible for creating a **Job** based on a defined schedule, ensuring tasks like backups, report generation, or cleanup are executed at specified intervals.

---

### **Key Features of CronJobs**

1. **Schedule-Based Execution**:
   - CronJobs allow you to define execution schedules using **Cron syntax**.

2. **One-Off Jobs**:
   - Each CronJob creates a **Job**, and the Job handles the execution of Pods.

3. **Fault Tolerance**:
   - If a CronJob fails to execute due to system downtime or other reasons, missed schedules can be handled using configurations like `startingDeadlineSeconds`.

4. **Concurrency Policies**:
   - Control how CronJobs handle overlapping schedules (e.g., skip, replace, or allow).

5. **History Management**:
   - CronJobs allow configuration of how many successful or failed Jobs should be retained.

6. **Time Zone Support**:
   - As of Kubernetes v1.27, CronJobs support time zones.

---

### **Basic CronJob Example**

Here’s a CronJob that prints the current time and a message every minute:

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "* * * * *"  # Runs every minute
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox:1.28
            command:
            - /bin/sh
            - -c
            - date; echo Hello from the Kubernetes cluster
          restartPolicy: OnFailure
```

### **Cron Syntax**

The `schedule` field uses standard Cron syntax:

| Field            | Range       | Description                |
|-------------------|-------------|----------------------------|
| **Minute**        | `0-59`      | Minute of the hour         |
| **Hour**          | `0-23`      | Hour of the day            |
| **Day of Month**  | `1-31`      | Day of the month           |
| **Month**         | `1-12`      | Month of the year          |
| **Day of Week**   | `0-6`       | Day of the week (Sunday=0) |

**Examples**:
- `0 3 * * 1` → Every Monday at 3:00 AM.
- `*/15 * * * *` → Every 15 minutes.
- `@hourly` → Shortcut for `0 * * * *`.

You can generate expressions using tools like [crontab.guru](https://crontab.guru).

---

### **Important Fields in a CronJob**

#### **1. Job Template**
Defines the Pod template and behavior for the Jobs that the CronJob will create. It is similar to writing a Job spec.

#### **2. Concurrency Policy**
Specifies how concurrent executions are handled:
- `Allow` (default): Allows overlapping Jobs.
- `Forbid`: Skips new Job runs if the previous Job is still running.
- `Replace`: Stops the currently running Job to start the new Job.

#### **3. Starting Deadline**
The `.spec.startingDeadlineSeconds` field defines how late a Job can be started after its scheduled time. If the delay exceeds this value, the Job is skipped.

#### **4. History Limits**
Limits how many successful or failed Job histories are retained:
- `.spec.successfulJobsHistoryLimit`: Defaults to 3.
- `.spec.failedJobsHistoryLimit`: Defaults to 1.

#### **5. Suspend**
Setting `.spec.suspend` to `true` pauses the execution of the CronJob. Already running Jobs are unaffected.

#### **6. Time Zones**
Use `.spec.timeZone` to specify a valid time zone, ensuring the schedule aligns with your desired time zone.

---

### **Behavior of CronJobs**

1. **Job Creation**:
   - The CronJob controller creates a Job for each scheduled execution.
   - The Job creates and manages Pods for task execution.

2. **Missed Jobs**:
   - If the controller misses a schedule, it calculates how many schedules were missed and decides whether to create a Job.
   - More than 100 missed schedules are logged but not executed.

3. **Job Deletion**:
   - When you delete a CronJob, its associated Jobs and Pods are also deleted.

4. **Immutable Jobs**:
   - Modifications to the CronJob affect only future Jobs. Existing Jobs and their Pods remain unchanged.

---

### **Advanced Example**

A CronJob that runs weekly on Monday at 2 AM to clean up temporary files:

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: cleanup
spec:
  schedule: "0 2 * * 1"  # Every Monday at 2:00 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: cleaner
            image: busybox:1.28
            command:
            - /bin/sh
            - -c
            - rm -rf /tmp/*; echo "Cleanup complete"
          restartPolicy: OnFailure
  successfulJobsHistoryLimit: 5
  failedJobsHistoryLimit: 3
  concurrencyPolicy: Forbid
  startingDeadlineSeconds: 3600
```

---

### **Monitoring CronJobs**

- **Check CronJobs**:
  ```bash
  kubectl get cronjobs
  ```

- **Describe a CronJob**:
  ```bash
  kubectl describe cronjob <name>
  ```

- **View Logs for Jobs**:
  ```bash
  kubectl logs jobs/<job-name>
  ```

- **Suspend/Resume a CronJob**:
  ```bash
  kubectl patch cronjob <name> --patch '{"spec": {"suspend": true}}'  # Suspend
  kubectl patch cronjob <name> --patch '{"spec": {"suspend": false}}'  # Resume
  ```

---

### **Limitations**

1. **Missed Schedules**:
   - If more than 100 schedules are missed, Kubernetes logs an error and skips them.

2. **Time Zone**:
   - Time zone specifications inside `.spec.schedule` using `CRON_TZ` or `TZ` are not supported.

3. **Job Idempotency**:
   - Jobs created by CronJobs should be idempotent to handle retries gracefully.

4. **Starting Deadline**:
   - If `startingDeadlineSeconds` is set too low (e.g., under 10 seconds), the Job may fail to schedule.

---

### **Best Practices**

1. **Set History Limits**:
   - Use `successfulJobsHistoryLimit` and `failedJobsHistoryLimit` to avoid excessive resource usage.

2. **Handle Concurrency**:
   - Choose an appropriate `concurrencyPolicy` to prevent overlapping executions if tasks are not idempotent.

3. **Use Deadlines**:
   - Configure `startingDeadlineSeconds` to manage delayed starts effectively.

4. **Leverage Time Zones**:
   - Use `.spec.timeZone` for schedules dependent on specific time zones.

5. **Monitor and Cleanup**:
   - Regularly monitor CronJobs and clean up finished Jobs automatically.

---

### **CronJob Alternatives**

- **Job**:
  - For one-time tasks.
- **DaemonSet**:
  - For tasks that need to run on all or specific nodes.
- **Deployment**:
  - For long-running, stateless applications.

---

### **What’s Next?**
- Learn more about [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/).
- Explore [CronJob API Reference](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/cron-job-v1/).
- Practice creating and monitoring CronJobs in your cluster.