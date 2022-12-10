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
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfgBJMyC58lL3iZvyi1f4OXzcwBtM5U3YVhC9IfwBLDClA503+vPmu1nVA7cWz+mJWZFNomPfbax8cBQ64hVKdAcBQb4j639geUzF4eqCAYQu8IJ+6+YIxUV87Gb9001uwSL47E6aJ74cGkv4S8DoEmakK1t3TpTeNcotUxNMjGqdfNk7BlmHieH701nWN09Uc2uHoMx3+5y+JPLgYWYKJNa1aQLWOiCZevItdIDv54LKJuWMiob/aWTNveXXzjNvZGunwfRKOW1fQwJ3WSa+MnOhfrzDdzhpDq1KuP8+E4vctYpMUt74ZGMQ8vrbDtjNn1Bce7hnU5wdf3emShgLd0b7ryrU+CLa4sjLsPSCKTg6kh0FPM2S/pJ08Jdo4QofcOtlBJ+eeJSMil/u5PE2oQ1dBwBflXmLmj4HD4h1rUCD02UX+ulozJx1m2D3q6teh0hrARPUSEDi+pmxrhzua1xSAXYY852Tnv3E1T2hYNsjO6g0fE63a5XjiRuzs0f0= sirazo@devops
EOF
}