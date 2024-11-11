data "template_file" "user_data" {
  template = templatefile(
    "${path.module}/res/cloud-init.yaml",
    {
      ssh_user        = var.ssh_username,
      ssh_pass        = var.ssh_password,
      hostname        = var.hostname,
      packages        = var.packages,
      package_update  = var.package_update,
      package_upgrade = var.package_upgrade,

      ssh_authorized_keys = var.ssh_authorized_keys

      runcmd = {
        "runcmd" : var.run_commands
      }
      write_files = {
        "write_files" : [
          for path, file in var.extra_files : {
            path        = path
            owner       = file.owner != null ? file.owner : "${var.ssh_username}:${var.ssh_username}"
            permissions = file.permissions != null ? file.permissions : "0644"
            encoding    = file.encoding
            content     = file.content
          }
        ]
      }
    }
  )
}

data "template_file" "network_config" {
  template = file("${path.module}/res/network-cfg.yaml")
}
