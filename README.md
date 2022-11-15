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

1. Clone this repo somewhere.
2. Run `terraform init`
3. You're ready to go.


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
