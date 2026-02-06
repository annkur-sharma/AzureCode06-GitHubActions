# ✅ Update the values to be used to backend configuration.
# ⚠️ This is pre-requisite to execute the code.
# ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.

resource_group_name  = "ankurbackend01"                        # Example: "rg-backend"
storage_account_name = "ankur01storage01af01"                      # Example: "rgbackendtorageaccount"
container_name       = "ankurstorage01container01"             # Example: "rgbackendstoragecontainer"
key                  = "AzureCode06-GithubActions.terraform.tfstate"     # Example: "infra01.terraform.tfstate"
