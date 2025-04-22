resource "proxmox_vm_qemu" "cloudinit-example" {
    name = "test-terraform1"
    target_node = "homelab"
    desc = "VM created from cloud init template by terraform"
    agent = 1 #enbles qemu guest agent
    clone = "ubuntu-template-2025" # The name of the template
    full_clone = true #will create an entirely seperate VM

    #hardware config
    memory = 1024
    sockets = 1
    cores = 2
    os_type = "cloud-init"
    cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
    nameserver = "1.1.1.1 8.8.8.8"
    ipconfig0  = "ip=192.168.0.0/32,gw=192.168.0.2,ip6=dhcp"
    skip_ipv6  = true
    scsihw = "virtio-scsi-single"

    #network config
    network {
        id = 0
        bridge = "vmbr0"
        model  = "virtio"
  }

    disk {
        slot = "scsi0"
        storage = "local-lvm"
        type = "disk"
        size = "15G"
  }
}