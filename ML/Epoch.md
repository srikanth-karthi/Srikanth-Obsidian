### 🔄 **What is an Epoch?**

An **epoch** is **one complete pass** through the **entire training dataset**.

For example:

- If you have **1,000 examples** and use a **mini-batch size of 100**, it takes **10 iterations** to complete **1 epoch**.
    
- If you train for **20 epochs**, the model will see each training example **20 times** in total.
    

---

### 📊 **How Epochs Affect Training**

- **More epochs** generally allow the model to learn better (i.e., **lower loss, better accuracy**).
    
- But **too many epochs** can lead to **overfitting**—where the model performs well on training data but poorly on new, unseen data.
    
- **Early stopping** can be used to stop training when the model stops improving.
    

---

### ⚙️ **Epochs, Batches, and Updates**

|Batch Type|When Updates Happen|Example (1,000 samples, 20 epochs)|
|---|---|---|
|**Full Batch**|Once per epoch|20 updates (1 per epoch)|
|**SGD (Batch = 1)**|Once per example|20,000 updates (1,000 × 20)|
|**Mini-Batch (e.g., 100)**|Once per mini-batch|200 updates (10 per epoch × 20)|