resource "proxmox_vm_qemu" "ubuntu-srv" {
  name        = var.vm_name
  target_node = "shire"
  clone       = "ubuntu2004-srv-cloud"
  vmid        = var.vm_id

  agent  = 1
  cores  = var.vm_cores
  memory = var.vm_memory
  onboot = true

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "20G"
  }


  os_type    = "cloud-init"
  ipconfig0  = "ip=${var.vm_ip}/24,gw=192.168.1.1"
  nameserver = "192.168.1.1"
  ciuser     = "admin"
  sshkeys    = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDxvuhF8mha2/Lmtj6I8ttmD9QdJxJO3eM3I8WKPEnJKYWy8ueHLd3qWaS2pBXotHHtIdfNhTh+y6taqDo2Dss8p2P8NX78vS5lt7prWlG44xwxUqRmKCWlf2bMdNxB8t88mMGpUbnYbhnbDcHOP33hoGoowEQ79QaGg1FjEpcuUrjhHxRPWcrKG7rxoFKZ+jHI8s2+YTPAfknlmgOIsedUPyeSPKlfuuPAoOYgEyOaFjGuuYhZqRyykDe8BBjVnkl1KJI+3h1N2bat0Wmv0hsPtTBISFxLzBIHerMh9nDxoRMBgY7+3Y9nkAecGJ4m9LqZub5FHoew3wy/PYmuqZoC2HDcBXy/NlN1TJdvtv4jBjonhBcTuC4EOatMXdjJCgb04hWgEbrEVE+8BHyP45v37CczoCltxNmXDobE6bsDHRjAASo72aNsfnx5bSZYjVnTsWVbdDlNXA7hFVQ4jpVrGDfSdLafmv8gHqvrpoDZ5JsOTNJRbj3SbxDmrL3Kx5c= sirazo@Home-PC
EOF
}