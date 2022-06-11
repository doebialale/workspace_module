# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source
data "external" "oauth_token" {
  program = ["bash", "-c", templatefile("${path.module}/templates/tfe-oauth-token-id-by-name.sh", { organization = local.organization, connection = try(var.vcs_repo.connection, "") })]
}