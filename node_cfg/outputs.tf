output "node_ip" {
  value = libvirt_domain.node-domain.network_interface[0].addresses[0]
}

output "node_idx" {
  value = var.node_index
}
