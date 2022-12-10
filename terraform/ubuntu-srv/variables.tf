variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "vm_name" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "vm_cores" {
  type = number
}

variable "vm_memory" {
  type = number
}

variable "vm_ip" {
  type      = string
  sensitive = true
}

variable "vm_ssd_root_size" {
  type = number
}

variable "vm_hdd_size" {
  type = number
}