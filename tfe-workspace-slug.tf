# https://www.terraform.io/docs/cloud/run/run-environment.html#environment-variables
data "external" "workspace_slug" {
  program = ["bash", "-c", templatefile("${path.module}/templates/tfe-workspace-slug.sh", {})]
}