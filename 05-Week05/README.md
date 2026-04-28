### Overview

In this lab, I re-ran the in-class Terraform workflow and documented each step using screenshots. The goal was to reinforce the Infrastructure as Code (IaC) lifecycle by following the standard Terraform execution sequence: **Init → Validate → Plan → Apply → Destroy (IVPAD)**.

---

### Terraform Workflow (IVPAD)

The following commands were executed in order:

* `terraform init` – Initialized the working directory and downloaded required providers
* `terraform validate` – Verified that the Terraform configuration is syntactically valid
* `terraform plan` – Generated an execution plan showing the changes Terraform would make
* `terraform apply` – Provisioned infrastructure in Google Cloud Platform
* `terraform destroy` – Removed all provisioned resources

---

### Verification

After running `terraform destroy`, I confirmed that all resources were successfully removed from GCP.

I then executed the following command to verify my local environment:

```bash
date && hostname && whoami
```

---

### Screenshots

The following screenshots are included to demonstrate each step of the workflow:

* Terraform Init
* Terraform Validate
* Terraform Plan
* Terraform Apply
* Terraform Destroy
* System Verification (`date && hostname && whoami`)

---

### Key Takeaway

This lab reinforced the full Terraform lifecycle and demonstrated how infrastructure can be reliably created and destroyed using a repeatable, declarative workflow.
