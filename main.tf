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
  source     = "./node"
  depends_on = [libvirt_pool.kube_pool]
  for_each   = { for idx, node in var.nodes : idx => node }

  os_base_volume      = var.base_os_vol_name
  ip                  = each.value.ip
  hostname            = each.value.hostname
  vol_size            = each.value.vol_size
  ssh_username        = var.ssh_username
  ssh_password        = var.ssh_password
  vcpus               = each.value.vcpus
  memory              = each.value.memory
  ssh_authorized_keys = var.ssh_authorized_keys
  network_name        = var.network_name
  pool_name           = libvirt_pool.kube_pool.name
}
