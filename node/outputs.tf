output "ips" {
  value = libvirt_domain.node-domain.network_interface[0].addresses
}
