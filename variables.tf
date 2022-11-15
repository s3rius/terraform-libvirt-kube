variable "libvirt_disk_path" {
  description = "path for libvirt pool"
  default     = "/tmp/libvirt-pool"
}

variable "os_image" {
  description = "Link to the OS image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/22.10/release/ubuntu-22.10-server-cloudimg-amd64-disk-kvm.img"
}

variable "master_node_prefix" {
  description = "master vm name prefix"
  type        = string
  default     = "kvn-master"
}

variable "worker_node_prefix" {
  description = "worker vm name prefix"
  type        = string
  default     = "kvn-worker"
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


variable "num_of_workers" {
  description = "Number of worker nodes"
  default     = 1
  type        = number
}

variable "num_of_masters" {
  description = "Number of master nodes"
  default     = 1
  type        = number
}


variable "libvirt_uri" {
  description = "URL of a libvirt daemon"
  type        = string
  default     = "qemu:///system"
}

variable "node_volume_size" {
  description = "Size of a volume of one node"
  type        = number
  default     = 5000000000
}

variable "base_os_vol_name" {
  description = "Name of a base volume with os"
  type        = string
  default     = "os_base_volume"
}

variable "pool_name" {
  description = "Name of a pool"
  type        = string
  default     = "my-pool"
}

variable "network_name" {
  description = "Name of a  libvirt network"
  type        = string
  default     = "k8snet"
}


variable "masters_vcpus" {
  description = "Number of virtual cpus for master nodes"
  type        = number
  default     = 2
}

variable "masters_memory" {
  descrition = "Master node memory in MB"
  type       = string
  default    = "2048"
}


variable "worker_vcpus" {
  description = "Number of virtual cpus for worker nodes"
  type        = number
  default     = 2
}

variable "worker_memory" {
  descrition = "Worker node memory in MB"
  type       = string
  default    = "2048"
}
