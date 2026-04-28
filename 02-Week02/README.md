### Overview

In this lab, I deployed a virtual machine (VM) instance in Google Cloud Platform using the provided `supera.sh` script. After deployment, I validated the success of the setup using the provided “gate” script.

---

### Deployment

The VM instance was provisioned by executing:

```bash
./supera.sh
```

This script automated the initial setup and configuration of the instance. It also performed **bootstrapping**, meaning it configured the VM at creation time (via startup/metadata) to ensure it was ready for use immediately after deployment.


---

### Validation

To verify that the deployment was successful, I ran the gate script:

```bash
./gate_gcp_vm_http_ok.sh
```

The script checks whether the VM is correctly configured and accessible, confirming a successful deployment.
