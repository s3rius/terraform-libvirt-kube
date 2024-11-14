resource "libvirt_network" "kube_network" {

  # the name used by libvirt
  name = var.network_name

  # mode can be: "nat" (default), "none", "route", "open", "bridge"
  mode = var.network_type

  # (optional) the bridge device defines the name of a bridge device
  # which will be used to construct the virtual network.
  # (only necessary in "bridge" mode)
  bridge = var.network_bridge

  # (optional) the MTU for the network. If not supplied, the underlying device's
  # default is used (usually 1500)
  mtu = var.network_mtu

  #  the domain used by the DNS server in this network
  domain = var.base_domain

  autostart = true

  # list of subnets the addresses allowed for domains connected
  # also derived to define the host addresses
  # also derived to define the addresses served by the DHCP server
  addresses = var.network_addresses

  # (Optional) DNS configuration
  dns {
    enabled    = true
    local_only = false

    # For each node that has an ip defined
    # create a dns record with the hostname.
    dynamic "hosts" {
      for_each = toset([for node in var.nodes : node if node["ip"] != null && var.base_domain != null])
      iterator = node

      content {
        hostname = "${node.value.hostname}.${var.base_domain}"
        ip       = node.value.ip
      }
    }

    # Extra hosts configuration.
    # This block will iterate over all hosts
    # that have had extra_hosts and ips and will
    # create dns records for them.
    dynamic "hosts" {
      for_each = flatten(
        [
          for node in var.nodes : [for host in node["extra_hosts"] : { "host" : host, "ip" : node["ip"] }]
          if length(node["extra_hosts"]) > 0 && node["ip"] != null
        ]
      )
      iterator = extra_host

      content {
        hostname = extra_host.value.host
        ip       = extra_host.value.ip
      }
    }
  }
}
