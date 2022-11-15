resource "libvirt_pool" "my_pool" {
  name = var.pool_name
  type = "dir"
  path = var.libvirt_disk_path
}

resource "libvirt_volume" "base_os_vol" {
  name   = var.base_os_vol_name
  pool   = libvirt_pool.my_pool.name
  source = var.os_image
  format = "qcow2"
}
