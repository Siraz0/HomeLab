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

variable "lxc_name" {
  type = string
}

variable "lxc_ip" {
  type = string
}

variable "lxc_id" {
  type = number
}

