# Terraform libvirt multimaster

What's this? This is a repo, that can help you
deploy multiple nodes in your qemu daemon, using terraform?

When should I use it? Well, if you're a devOps engineer and
sometimes you want to test your ansible scripts, then this is 
a good fit for you.

Requirements:
- terraform >= 0.12.6
- libvirt
- qemu
- dnsmasq


## Usage

You have two options how to use this repo.

### By cloning

1. Clone this repo somewhere.
2. Run `terraform init`
3. You're ready to go.

### By using as the dependency

Create a new terraform project.
Add a file with contents like this:

```terraform
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

module "mymod" {
  source = "git::https://github.com/s3rius/terraform-libvirt-kube"

  libvirt_uri = "qemu:///system"
}

resource "local_file" "inventory_out" {
  content  = module.mymod.inventory
  filename = "${path.module}/inventory.ini"
}
```

Run `terraform init` and `terraform apply`.

## Configuration


This project has a lot of variables, and all of them can be found in [variables.tf](./variables.tf) file.


I prefer using .tfvars files.

```
os_image="/home/user/ubuntu-22.10-server-cloudimg-amd64-disk-kvm.img"

num_of_workers=3
num_of_masters=3

ssh_username=test
ssh_password=test

masters_memory=4096
worker_memory=2048
```
