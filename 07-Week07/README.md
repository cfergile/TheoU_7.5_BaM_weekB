## Overview

In this lab I used official Terraform documentation from the Terraform Registry to implement both local and cloud platform provisioned infrastructure using HCL. In doing so I was able to use core IaC skills to build foundational concepts.


## Local Infrastructure:
Using terraform documentaion from the offical Terraform Registry I used the local_file resource. This resource crates a text file on your local machine. In the instance of this lab, I created a text file that states my favorite food.

This demonstatrates how Terraform can manage local resources as well as cloud infrastructure.


## GCP Infrastructure:
For the cloud provsioned portion, I created two Virtual Private Cloud(VPC) in Google Cloud Platform using Terraform.

To ensure that the structure was scalable and human readable, I oraganized the infrastructure into multiple files. Each file responsible for a specific component of the infrastructure (provider, vpc, outputs). In doing so the structure in clean, readable, and easier to modify, providing flexibility for the fine details without affecting the entire configuration.

Taking adavtage of Terraforms declarative state I was able to plan the desired state of my infrastruture while keeping the codebase sectional.


