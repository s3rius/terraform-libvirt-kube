module "masters" {
  for_each = toset([for i in range(var.num_of_masters) : format("%d", i)])

  source = "./node_cfg"

  network_name     = libvirt_network.kube_network.name
  pool_name        = libvirt_pool.my_pool.name
  os_base_volume   = libvirt_volume.base_os_vol.id
  ssh_password     = var.ssh_password
  ssh_username     = var.ssh_username
  node_name_prefix = var.master_node_prefix
  node_index       = each.key
  vol_size         = var.node_volume_size
  memory           = var.masters_memory
  vcpus            = var.masters_vcpus
}


module "workers" {
  for_each = toset([for i in range(var.num_of_workers) : format("%d", i)])

  source = "./node_cfg"

  network_name     = libvirt_network.kube_network.name
  pool_name        = libvirt_pool.my_pool.name
  os_base_volume   = libvirt_volume.base_os_vol.id
  ssh_password     = var.ssh_password
  ssh_username     = var.ssh_username
  node_name_prefix = var.worker_node_prefix
  node_index       = each.key
  vol_size         = var.node_volume_size
  memory           = var.worker_memory
  vcpus            = var.worker_vcpus
}
