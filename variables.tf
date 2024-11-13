variable "libvirt_uri" {
  description = "URL of a libvirt daemon"
  type        = string
  default     = "qemu:///system"
}

variable "base_os_vol_name" {
  description = "Name of a base volume with os"
  type        = string
  default     = "os_base_volume"
}

variable "pool_name" {
  description = "Name of volumes pool"
  type        = string
  default     = "kube-pool"
}

variable "libvirt_disk_path" {
  description = "path for libvirt pool"
  default     = "/tmp/libvirt-pool"
}

variable "os_image" {
  description = "Link to the OS image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/22.10/release/ubuntu-22.10-server-cloudimg-amd64-disk-kvm.img"
}

variable "network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "kube_network"
}

variable "base_domain" {
  description = "Base domain name for the network"
  type        = string
  default     = "k8s.local"
}

variable "network_addresses" {
  description = "List of possible network addresses (can be CIDRs)"
  type        = list(string)
  default     = ["10.17.0.0/24"]
}

variable "dns_local_only" {
  description = "Wether to use local for virtual network dns only."
  type        = bool
  default     = false
}

variable "nodes" {
  description = "Nodes config"
  type = list(object({
    hostname        = string                           # Hostname of the node.
    vcpus           = optional(number, 1)              # Number of virtual CPUs
    memory          = optional(number, 1024)           # Memory in MB
    vol_size        = optional(number, 4)              # Volume size in GB
    ip              = optional(string)                 # Optional IP address. If not set, DHCP will be used to assign an IP.
    extra_hosts     = optional(list(string), [])       # Additional hosts to add to the DNS server.
    ssh_pass_auth   = optional(bool, null)             # Use pass auth for this server.
    packages        = optional(list(string), [])       # Commands to run on startup
    package_update  = optional(bool, false)            # Run package update on startup
    package_upgrade = optional(bool, false)            # Run package upgrade on startup
    service_enable  = optional(list(string), [])       # Services to enable on startup
    run_commands    = optional(list(list(string)), []) # Commands to run on fist startup
    cpu_mode        = optional(string)                 # CPU configuration of a machine
    arch            = optional(string)                 # Architecture of the machine (same as host by default)
    extra_files = optional(map(object({                # Map of extra files to create on startup
      owner       = optional(string, null)
      permissions = optional(string, "0644")
      encoding    = optional(string, "plain")
      content     = string
    })), {})
  }))

  default = [{ hostname = "node1" }]
}

variable "ssh_username" {
  description = "the ssh user to use"
  type        = string
  default     = "user"
}

variable "ssh_password" {
  description = "the ssh password for user"
  type        = string
  default     = "pass"
}

variable "ssh_pass_auth" {
  description = "Wether to use password authentication for ssh"
  type        = bool
  default     = true
}

variable "ssh_authorized_keys" {
  description = "Authorized ssh keys"
  type        = list(string)
  default     = []
}
