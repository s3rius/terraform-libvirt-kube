output "inventory" {
  value = templatefile(
    "${path.module}/resources/inventory_templ.ini",
    {
      masters : module.masters,
      workers : module.workers,
      ssh_username : var.ssh_username,
      ssh_password : var.ssh_password,
  })
}

