terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url          = "https://192.168.100.252:8006/api2/json"
  pm_api_token_id     = "root@pam!terraformhugd"  # Token ID
  pm_api_token_secret = "7c49b331-dfd0-42a5-80db-defde3252050"  # Clé secrète associée au Token ID
  pm_tls_insecure     = true
}

resource "proxmox_vm_qemu" "my_vm" {
  name        = "lafoliemeguette"
  target_node = "proxmox12"
  clone       = "Debian12"
  cores       = 2
  memory      = 2048

  disk {
    storage = "Vm"
    size    = "10G"
    type    = "scsi"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
}
