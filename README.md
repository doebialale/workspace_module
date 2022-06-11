# terraform-tfe-workspace

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | ~> 2.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.2 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.25 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | ~> 2.1 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.25 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_team_access.support](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_variable.environment](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.region](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.variables](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.main](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [external_external.oauth_token](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.tf_vars](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.workspace_slug](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [tfe_ssh_key.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/ssh_key) | data source |
| [tfe_team.support](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |
| [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The default environment. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the workspace | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The default region. | `string` | n/a | yes |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The default version of Terraform to use for this workspace. | `string` | n/a | yes |
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | Whether destroy plans can be queued on the workspace. | `bool` | `true` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Workspace auto-apply default value | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The workspace description. | `string` | `""` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | Whether to filter runs based on the changed files in a VCS push. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run. Defaults to true. | `bool` | `true` | no |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | Whether the workspace should start automatically performing runs immediately after its creation. When set to false, runs triggered by a webhook (such as a commit in VCS) will not be queued until at least one run has been manually queued. Defaults to true. Note: This default differs from the Terraform Cloud API default, which is false. The provider uses true as any workspace provisioned with false would need to then have a run manually queued out-of-band before accepting webhooks. | `bool` | `true` | no |
| <a name="input_speculative_enabled"></a> [speculative\_enabled](#input\_speculative\_enabled) | Whether this workspace allows speculative plans. Setting this to false prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests, which can improve security if the VCS repository is public or includes untrusted contributors. | `bool` | `true` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | The organization's ssh\_key name | `string` | `"tf_ssh_key"` | no |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | List of repository-root-relative paths which describe all locations to be tracked for changes. | `list(string)` | `[]` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | List of variable objects to apply to the workspace | <pre>list(object({<br>    description = string<br>    key         = string<br>    value       = string<br>    category    = string<br>    sensitive   = bool<br>    hcl         = bool<br>  }))</pre> | `[]` | no |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | The vcs repo block. | `map(string)` | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | A relative path that Terraform will execute within. Defaults to the root of your repository. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_vars_try_count"></a> [api\_vars\_try\_count](#output\_api\_vars\_try\_count) | The number of attempts to retrieve the WSM variables. |
| <a name="output_workspace"></a> [workspace](#output\_workspace) | The TFE workspace |
<!-- END_TF_DOCS -->