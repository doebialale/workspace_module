
# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace
resource "tfe_workspace" "main" {
  name                  = var.name
  description           = var.description
  organization          = local.organization
  terraform_version     = var.terraform_version
  auto_apply            = var.auto_apply
  ssh_key_id            = data.tfe_ssh_key.default[0].id
  speculative_enabled   = var.speculative_enabled
  allow_destroy_plan    = var.allow_destroy_plan
  file_triggers_enabled = var.file_triggers_enabled
  queue_all_runs        = var.queue_all_runs
  trigger_prefixes      = var.trigger_prefixes
  working_directory     = var.working_directory

  dynamic "vcs_repo" {
    # if vcs_repo is set within config, then add it; else don't
    for_each = var.vcs_repo == null ? [] : ["vcs_repo is not null and set within config"]
    content {
      identifier         = var.vcs_repo.identifier
      branch             = var.vcs_repo.branch
      ingress_submodules = try(var.vcs_repo.ingress_submodules, false)
      oauth_token_id     = data.external.oauth_token.result.id
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team
data "tfe_team" "support" {
  name         = join("-", [local.team_prefix, "support"])
  organization = local.organization
}

# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access
resource "tfe_team_access" "support" {
  access       = "read"
  team_id      = data.tfe_team.support.id
  workspace_id = tfe_workspace.main.id
}

# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "region" {
  key          = "region"
  value        = var.region
  category     = "terraform"
  workspace_id = tfe_workspace.main.id
  description  = "The primary region where resources are deployed."
  hcl          = false
  sensitive    = false
}

# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "environment" {
  key          = "environment"
  value        = var.environment
  category     = "terraform"
  workspace_id = tfe_workspace.main.id
  description  = "The environment indicator for this deployment."
  hcl          = false
  sensitive    = false
}

# https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable
resource "tfe_variable" "variables" {
  for_each     = { for variable in local.variables : variable.key => variable }
  key          = each.value.key
  value        = each.value.value
  category     = each.value.category
  workspace_id = tfe_workspace.main.id
  description  = each.value.description
  hcl          = each.value.hcl
  sensitive    = each.value.sensitive
}