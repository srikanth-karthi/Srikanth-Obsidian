---
tags:
  - Devops
---


# Dynamic Blocks

Dynamic blocks are used to generate nested configuration blocks dynamically
`
```
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

resource "aws_security_group" "example" {
  name = "example-sg"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}

variable "ingress_rules" {
  default = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
  ]
}


```


#  for_each 

it creates three buckets

```variable "bucket_names" {
  type    = list(string)
  default = ["bucket1", "bucket2", "bucket3"]
}

resource "aws_s3_bucket" "my_buckets" {
  for_each = var.bucket_names

  bucket = each.value  # Use the bucket name from the list
  acl    = "private"
}

```

## Terraform Commands Cheat Sheet

### Meta-Arguments
1. **`depends_on`**: Ensures a resource is created only after the specified resources have been created.
   ```hcl
   resource "aws_instance" "example" {
     depends_on = [aws_vpc.example]
   }
   ```

2. **`count`**: Creates multiple instances of a resource.
   ```hcl
   resource "aws_instance" "example" {
     count = 3
   }
   ```

3. **`for_each`**: Iterates over a map or set to create multiple resources.
   ```hcl
   resource "aws_security_group_rule" "example" {
     for_each = var.security_group_rules
   }
   ```

4. **`lifecycle`**: Customizes the behavior of a resource’s lifecycle.
   ```hcl
   resource "aws_instance" "example" {
     lifecycle {
       prevent_destroy = true
     }
   }
   ```

5. **`provider`**: Specifies the provider for the resource.
   ```hcl
   provider "aws" {
     region = "us-east-1"
   }
   ```

### Provisioners
1. **`local-exec`**: Runs a command locally after resource creation.
   ```hcl
   provisioner "local-exec" {
     command = "echo Hello"
   }
   ```

2. **`remote-exec`**: Runs a command on the resource after it's created.
   ```hcl
   provisioner "remote-exec" {
     inline = [
       "echo Hello",
     ]
   }
   ```

3. **`file`**: Copies a file from the local machine to the resource.
   ```hcl
   provisioner "file" {
     source      = "localfile.txt"
     destination = "/remote/path/localfile.txt"
   }
   ```

4. **`null_resource`**: A resource that does nothing but can use provisioners.
   ```hcl
   resource "null_resource" "example" {}
   ```

### Functions
- **`lookup`**: Retrieves a value from a map.
  ```hcl
  lookup(var.map_variable, "key", "default_value")
  ```

- **`try`**: Returns the first argument that does not produce an error.
  ```hcl
  try(some_expression, "default_value")
  ```

- **`merge`**: Merges multiple maps into one.
  ```hcl
  merge(map1, map2)
  ```

- **`range`**: Creates a list of numbers.
  ```hcl
  range(1, 5)  # Outputs [1, 2, 3, 4]
  ```

- **`toset`**: Converts a list to a set.
  ```hcl
  toset(["a", "b", "c"])
  ```

- **`file`**: Reads the contents of a file.
  ```hcl
  file("path/to/file")
  ```

### Expressions
- **For Expressions**: Create a new list or map based on an existing one.
  ```hcl
  [for item in var.list : item if item > 0]
  ```

- **Conditional Expressions**: Return values based on a condition.
  ```hcl
  var.enabled ? "enabled" : "disabled"
  ```

### Workspaces
- **Creating Workspaces**: Separate environments (dev, prod).
  ```bash
  terraform workspace new dev
  ```

- **Listing Workspaces**:
  ```bash
  terraform workspace list
  ```

- **Selecting a Workspace**:
  ```bash
  terraform workspace select dev
  ```

### Import Command
- **Importing Resources**: Import existing infrastructure into Terraform management.
  ```bash
  terraform import aws_instance.example i-02e3b6249c8aef6a9
  ```

### Taint Command
- **Tainting Resources**: Mark a resource for recreation.
  ```bash
  terraform taint aws_instance.example
  ```

- **Untainting Resources**: Remove the taint from a resource.
  ```bash
  terraform untaint aws_instance.example
  ```

