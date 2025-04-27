### 🧮 **What is Batch Size in Machine Learning?**

**Batch size** is a **hyperparameter** that defines **how many data samples** the model processes **before updating** the weights and bias.

---

### 🚀 **Why Not Use the Whole Dataset at Once?**

- In large datasets (e.g., millions of samples), calculating the loss and gradient for the **entire dataset at once** (called **full-batch gradient descent**) is **computationally expensive** and **slow**.
    
- Instead, models use **smaller batches** of data to approximate the gradients.
    

---

### ⚖️ **Common Gradient Descent Strategies**

|Method|Batch Size|Characteristics|
|---|---|---|
|**Stochastic Gradient Descent (SGD)**|1|Fast, but **noisy**; gradient updates after each example.|
|**Mini-Batch SGD**|Between 2 and total number of examples|**Balanced** approach—less noise, faster convergence.|
|**Batch Gradient Descent**|Entire dataset|Smooth but **slow and memory-heavy**.|

---

### 📉 **Loss Curve Behavior**

- **SGD:** Loss curve is **jittery** (lots of ups and downs), especially during early and late training stages.
    
- **Mini-Batch SGD:** Loss curve is **smoother** with **minor fluctuations**, leading to **more stable convergence**.
    

---

### 💡 **Key Insight**

- **Small batch size** = more noise = better generalization (can escape local minima).
    
- **Large batch size** = stable but may lead to poor generalization.


next [[Epoch]]