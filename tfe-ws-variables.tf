# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace
data "tfe_workspace" "this" {
  name         = local.workspace_name
  organization = local.organization
}

# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source
data "external" "tf_vars" {
  program = ["bash", "-c", templatefile("${path.module}/templates/tfe-variables.sh", { workspace_id = data.tfe_workspace.this.id })]
}

locals {
  iam_credential_variables = try(jsondecode(base64decode(data.external.tf_vars.result.base64)), [])
}