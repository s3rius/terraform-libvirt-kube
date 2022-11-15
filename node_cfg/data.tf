data "template_file" "user_data" {
  template = templatefile(
    "${path.module}/resources/cloud_init.yml",
    {
      ssh_user : var.ssh_username,
      ssh_pass : var.ssh_password,
      hostname : "${var.node_name_prefix}${var.node_index}"
    }
  )
}

data "template_file" "network_config" {
  template = file("${path.module}/resources/network_cfg.yml")
}
