# ✅ Update the values to be used to backend configuration.
# ⚠️ This is pre-requisite to execute the code.
# ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.

resource_group_name  = "ankur01backendrg"                               # Example: "rg-backend"
storage_account_name = "ankur01storage01"                               # Example: "rgbackendtorageaccount"
container_name       = "ankur01storage01container"                      # Example: "rgbackendstoragecontainer"
key                  = "AzureCode05GitHubActions.terraform.tfstate"     # Example: "infra01.terraform.tfstate"
