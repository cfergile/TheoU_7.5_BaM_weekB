### Terraform

# The Required Arguments for a VM in Terraform
1. boot_disk
2. machine_type
3. name
4. network_interface

| Argument            | Description |
| ------------------- | ----------- |
| `name`              | The name given to the VM instance. It must be different from other VM names in the same project and zone. |
| `machine_type`      | Determines how much CPU power and memory the VM instance will have. |
| `boot_disk`         | Contains the operating system for the VM instance. An image must be provided to choose which operating system will be installed. |
| `network_interface` | Connects the VM instance to a VPC network so it can communicate with other resources and access the internet. |

# Getting Internal and External IP Addresses Output
 Both attributes are listed in the [Terraform Registry docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#attributes-reference). Stackflow and [Reddit](https://www.reddit.com/r/Terraform/comments/rd8mx0/how_to_get_external_ip_address_that_google_cloud/) also has useful code that is worth testing out.

```bash
output "internal_ip" {
  description = "The internal (private) IP of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
}

output "external_ip" {
  description = "The external (public) IP of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
```

# Non-required VM arguments
1. labels 
2. tags

| Term | Description |
| --- | --- |
| `labels` | When assigned to a resource, a VM in this case, it helps you organize and manage the cost of said resource. You can filter your resources using their assigned label in case you want to single out a particular resource. |
| `tags` | Also used for organizing purposes similar to labels however they have the ability to searve as somewhat of a defacto tool of access controll and policy enforcement. |


# How to find CentOS image
As far as formatting goes, the [Terraform Registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#nested_boot_disk) will be the source for that aspect. In order to find image itself you should run:
```bash
gcloud compute images list
```
which will list all available images as well as their "PROJECT" AND "FAMILY" which will be the necessary elements when formatting our terraform infrastructure.

```
initialize_params {
      image = "centos-cloud/centos-stream-10"
```

# name vs id vs self_link Attributes

name is typically the user-given name used to identify a particular resource.

id is the provider-generated reference that represents the location of the resource within the infrastructure hierarchy.

self_link is the provider-generated API URL that

| Term | Description |
| --- | --- |
| `name` | name is typically the user-given name used to identify a particular resource. |
| `id` | id is the provider-generated reference that represents the location of the resource within the infrastructure hierarchy. |
| `self_link` | self_link is the provider-generated API URL that references the specific resource. |