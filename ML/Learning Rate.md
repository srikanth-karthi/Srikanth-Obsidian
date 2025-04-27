### 🔍 **What is Learning Rate in Machine Learning?**

**Learning rate** is a small decimal number (like 0.01 or 0.001) that controls **how big a step** the model takes toward minimizing the loss during each iteration of **gradient descent**.

---

### ⚙️ **How It Works**

- At each training step, the model calculates the **gradient** (slope) of the loss function.
    
- The **learning rate** is multiplied with the gradient to decide how much the model’s parameters (like weights and bias) should change.
    
    Parameter update=−(learning rate)×(gradient)Parameter update=−(learning rate)×(gradient)
    
    > Example: If the gradient is **2.5** and learning rate is **0.01**, the model updates the weight by **0.025**.
    

---

### 🎯 **Why It Matters**

- **Too small** → Training is **very slow**, might take forever to converge.
    
- **Too large** → Model may **overshoot** the minimum and never settle (it may oscillate or even diverge).
    
- **Just right** → Model **converges efficiently** in fewer iterations.



next [[Bath Size]]