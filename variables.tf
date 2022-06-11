locals {
  workspace_slug = split("/", data.external.workspace_slug.result.workspace_slug)
  organization   = local.workspace_slug[0]
  workspace_name = local.workspace_slug[1]
  team_prefix = join("-", concat(["tfe"], try(
    slice(split("-", local.organization), 0, 2),
  tolist([local.organization]))))
  variables = toset(concat(try(var.variables, []), local.iam_credential_variables))
}

variable "allow_destroy_plan" {
  description = "Whether destroy plans can be queued on the workspace."
  type        = bool
  default     = true
}

variable "auto_apply" {
  description = "Workspace auto-apply default value"
  type        = bool
  default     = true
}

variable "description" {
  description = "The workspace description."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The default environment."
  type        = string
}

variable "file_triggers_enabled" {
  description = "Whether to filter runs based on the changed files in a VCS push. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run. Defaults to true."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the workspace"
  type        = string
}

variable "queue_all_runs" {
  description = "Whether the workspace should start automatically performing runs immediately after its creation. When set to false, runs triggered by a webhook (such as a commit in VCS) will not be queued until at least one run has been manually queued. Defaults to true. Note: This default differs from the Terraform Cloud API default, which is false. The provider uses true as any workspace provisioned with false would need to then have a run manually queued out-of-band before accepting webhooks."
  type        = bool
  default     = true
}

variable "region" {
  description = "The default region."
  type        = string
}

variable "speculative_enabled" {
  description = "Whether this workspace allows speculative plans. Setting this to false prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests, which can improve security if the VCS repository is public or includes untrusted contributors."
  type        = bool
  default     = true
}

variable "ssh_key_name" {
  description = "The organization's ssh_key name"
  type        = string
  default     = "tf_ssh_key"
}

variable "terraform_version" {
  description = "The default version of Terraform to use for this workspace."
  type        = string
}

variable "trigger_prefixes" {
  description = "List of repository-root-relative paths which describe all locations to be tracked for changes."
  type        = list(string)
  default     = []
}

variable "variables" {
  description = "List of variable objects to apply to the workspace"
  type = list(object({
    description = string
    key         = string
    value       = string
    category    = string
    sensitive   = bool
    hcl         = bool
  }))
  default = []
}

variable "vcs_repo" {
  description = "The vcs repo block."
  type        = map(string)
  default     = null
}

variable "working_directory" {
  description = "A relative path that Terraform will execute within. Defaults to the root of your repository."
  type        = string
  default     = ""
}