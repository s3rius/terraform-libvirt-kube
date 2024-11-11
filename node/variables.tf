variable "pool_name" {
  description = "Name of volumes pool"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "os_base_volume" {
  description = "Link to the OS image"
  type        = string
}

variable "vol_size" {
  description = "Size of a volume in GB"
  type        = number
}

variable "hostname" {
  description = "master vm hostname"
  default     = "node"
  type        = string
}

variable "ip" {
  description = "Node's IP"
  type        = string
  default     = null
}

variable "ssh_username" {
  description = "the ssh user to use"
  type        = string
}

variable "ssh_password" {
  description = "the ssh password for user"
  type        = string
}

variable "vcpus" {
  description = "Number of virtual cpus for node"
  type        = number
}

variable "memory" {
  description = "Node memory in bytes"
  type        = number
}

variable "ssh_authorized_keys" {
  description = "Authorized ssh keys"
  type        = list(string)
}
