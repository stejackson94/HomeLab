variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

variable "homelab_node" {
    type = string
}

variable "vm_name" {
    type = string
}

variable "username" {
    type = string
}

variable "password" {
    type = string
    sensitive = true
}