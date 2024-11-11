resource "libvirt_volume" "node-volume" {
  name           = "volume-${var.hostname}"
  pool           = var.pool_name
  base_volume_id = var.os_base_volume
  size           = var.vol_size * 1000000000 # 1e9 (bytes to GBs)
}

# for more info about paramater check this out
# https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
# Use CloudInit to add our ssh-key to the instance
# you can add also meta_data field
resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "cloudinit-${var.hostname}"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = var.pool_name
}


resource "libvirt_domain" "node-domain" {
  name   = var.hostname
  memory = var.memory
  vcpu   = var.vcpus

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    macvtap        = "eth0"
    network_name   = var.network_name
    wait_for_lease = true
    hostname       = var.hostname
    addresses      = var.ip != null ? [var.ip] : []
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.node-volume.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

}

