locals {
    instance_id = "${var.name}-${var.tag}"
}

resource "libvirt_volume" "this" {
  name           = "${local.instance_id}.qcow2"
  base_volume_id = var.base_volume_id
  pool           = var.pool
}

resource "libvirt_cloudinit_disk" "this" {
  name           = "${local.instance_id}.iso"
  user_data      = templatefile("${path.module}/user_data.yml.tmpl", { username = var.username, ssh_key = var.ssh_key })
  meta_data      = templatefile("${path.module}/meta_data.yml.tmpl", { instance_id = local.instance_id, hostname = var.name })
  network_config = templatefile("${path.module}/network_config.yml.tmpl", { address = var.address, gateway = var.gateway })
  pool           = var.pool
}

resource "libvirt_domain" "this" {
  name   = local.instance_id
  memory = var.memory
  vcpu   = var.vcpu

  cloudinit = libvirt_cloudinit_disk.this.id

  network_interface {
    network_name = var.network_name
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.this.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
