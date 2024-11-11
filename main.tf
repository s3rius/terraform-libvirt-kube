resource "libvirt_pool" "kube_pool" {
  name = var.pool_name
  type = "dir"
  path = var.libvirt_disk_path
}

resource "libvirt_volume" "base_os_vol" {
  name   = var.base_os_vol_name
  pool   = libvirt_pool.kube_pool.name
  source = var.os_image
  format = "qcow2"
}


module "nodes" {
  source   = "./node"
  for_each = { for idx, node in var.nodes : node.hostname => node }

  pool_name      = libvirt_pool.kube_pool.name
  network_name   = libvirt_network.kube_network.name
  os_base_volume = libvirt_volume.base_os_vol.id

  ip       = each.value.ip
  hostname = each.value.hostname
  vol_size = each.value.vol_size
  vcpus    = each.value.vcpus
  memory   = each.value.memory

  ssh_username        = var.ssh_username
  ssh_password        = var.ssh_password
  ssh_authorized_keys = var.ssh_authorized_keys
}