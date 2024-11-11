output "nodes_ips" {
  value = { for node in var.nodes : node.hostname => module.nodes[node.hostname].ips }
}
