variable "address" {
  description = "IP address for the provisioned machine"
  type        = string
  default     = ""
}

variable "base_volume_id" {
  description = "Path to the CentOS base image"
  type        = string
}

variable "gateway" {
  description = "Network gateway IP for the provisioned machine"
  type        = string
  default     = ""
}

variable "memory" {
  description = "Memory for the provisioned machine"
  type        = string
  default     = "2048"
}

variable "name" {
  description = "VM name"
  type        = string
}

variable "network_name" {
  description = "Network name to attach VM to"
  type        = string
  default     = "default"
}

variable "pool" {
  description = "Pool to deploy into"
  type        = string
  default     = "default"
}

variable "tag" {
  description = "Unique tag to identify the machine with"
  type        = string
  default     = "terraform"
}

variable "ssh_key" {
  description = "SSH Public Key to apply to the instance"
  type        = string
}

variable "username" {
  description = "Default sudo user to add to the instance"
  type        = string
  default     = "centos"
}

variable "vcpu" {
  description = "VCPUs for the provisioned machine"
  type        = number
  default     = 1
}
