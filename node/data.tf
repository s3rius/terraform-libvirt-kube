data "template_file" "user_data" {
  template = templatefile(
    "${path.module}/res/cloud-init.yaml",
    {
      ssh_user : var.ssh_username,
      ssh_pass : var.ssh_password,
      hostname : var.hostname,
      ssh_authorized_keys : var.ssh_authorized_keys
    }
  )
}

data "template_file" "network_config" {
  template = file("${path.module}/res/network-cfg.yaml")
}
