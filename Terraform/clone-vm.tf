resource "proxmox_vm_qemu" "clone-vm" {
    name = "test-terraform1"
    desc = "VM created by terraform"
    target_node = "homelab"
    clone = "Ubuntu-template-2025" # The name of the template
    agent = 1 #enbles qemu guest agent
    full_clone = true #will create an entirely seperate VM

    #hardware config
    os_type = "ubuntu"
    memory = 1024
    cores = 1
    scsihw = "virtio-scsi-single"

    # Setup the disk
    disks {
        ide {
            ide0 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size            = 20
                    storage         = "local-lvm"
                    discard         = true
                    emulatessd      = true
                }
            }
        }
    }

    # Setup the network interface and assign a vlan tag: 256
    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
        firewall = true
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0  = "ip=dhcp,ip6=dhcp"
    skip_ipv6  = true

    serial {
      id = 0
      type = "socket"
    }

    vga {
      type = "serial0"
    }

    ciuser = "ste"
    cipassword = "Masteron!1"

}