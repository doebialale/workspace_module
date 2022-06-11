output "workspace" {
  description = "The TFE workspace"
  value       = tfe_workspace.main
}

output "api_vars_try_count" {
  description = "The number of attempts to retrieve the WSM variables."
  value       = data.external.tf_vars.result.try_count
}