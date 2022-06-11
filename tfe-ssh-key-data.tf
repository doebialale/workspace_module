# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/ssh_key
data "tfe_ssh_key" "default" {
  count = var.ssh_key_name == "" ? 0 : 1

  name         = var.ssh_key_name
  organization = local.organization
}