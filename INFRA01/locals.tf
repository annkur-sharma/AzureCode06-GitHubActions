locals {
  # formatted_user_prefix = "${lower(var.user_prefix)}"
  formatted_user_prefix = "${lower(random_string.root_random_string.result)}"
}

locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "sandbox"
  }
}