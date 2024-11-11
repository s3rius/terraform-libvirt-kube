# Terraform libvirt helper

This repo will help you to create multiple nodes using libvirt and will bind it them the one network.

Requires:
* terraform >= 0.12.6
* libvirt
* qemu
* dnsmasq

For archlinux users:

```bash
pacman -S terraform libvirt qemu-full dnsmasq
```

# Usage

You have two options how to use this repo.

1. Clone it;
2. Use as a dependency.

For the fist option it's faily straightforward. 

```bash
git clone https://github.com/s3rius/terraform-libvirt-kube.git
cd terraform-libvirt-kube
terraform init
# Use this file to supply additional parameters.
touch vars.tfvars

terraform apply -var-file vars.tfvars
```

The second option is almost as simple as the first one, but requires a separate tf project.

```
touch main.tf
```

Put this inside the `main.tf` file

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
```

Run `tf init` and then you can run `tf apply` as usual.

### Configuration

You can lookup all project variables in [variables.tf](https://github.com/s3rius/terraform-libvirt-kube/blob/master/variables.tf).

Here's a samle config:

```terraform
libvirt_uri = "qemu:///system"

base_domain      = "kube.local"
netork_addresses = ["10.17.0.0/24"]

# You can speedup booting by creating VMs from a downloaded img.
os_image = "/home/s3rius/imgs/ubuntu-22.04-server-cloudimg-amd64-disk-kvm.img"
ssh_authorized_keys = [
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AACCIGyxBPmyfXSMl5MSk5ff1pX43GULHpHandCb32P4nMid meme@example.com",
]

nodes = [
  {
    hostname    = "lb"           # Name of a node
    ip          = "10.17.0.10"   # IP of a node
    extra_hosts = ["kube.local"] # Additional hosts
    memory      = 2048           # In MB
    vcpus       = 2              # In CPUs
    vol_size    = 5              # In GB
  },
  {
    hostname = "m1"
    ip       = "10.17.0.11"
  },
  {
    hostname = "m2"
    ip       = "10.17.0.12"
  },
  {
    hostname = "m3"
    ip       = "10.17.0.13"
  },
]
```

