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

variable "ssh_pass_auth" {
  description = "Wether to use password auth"
  type        = bool
}

variable "packages" {
  description = "List of packages to install"
  type        = list(string)
}

variable "package_update" {
  description = "Wether to update packages"
  type        = bool
}

variable "package_upgrade" {
  description = "Wether to upgrade packages"
  type        = bool
}

variable "run_commands" {
  description = "List of commands to run"
  type        = list(any)
}

variable "extra_files" {
  description = "Extra files to create"
  type = map(object({
    owner       = optional(string)
    permissions = optional(string)
    encoding    = optional(string)
    content     = string
  }))
  default = {}
}

variable "cpu_mode" {
  description = "CPU configuration of a machine"
  type        = string
  nullable    = true
}

variable "cpu_arch" {
  description = "Architecture of the CPU"
  type        = string
  default     = "x86_64"
}
