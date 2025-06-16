# AzureCode01-InfraSetup
AzureCode01-InfraSetup - To setup RG, Vnet, Subnet, NIC, NSG, Public IP, VM by dynacally providing resource group name.

## Step 01 - Update backend configuration in the below mentioned file.
#### ✅ Update the values to be used to backend configuration.
#### ⚠️ This is pre-requisite to execute the code.
#### ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.
````yaml
.\INFRA01\backend-config-infra01.hcl
---------------------------------------------------------------------------------------------------
# ✅ Update the values to be used to backend configuration.
# ⚠️ This is pre-requisite to execute the code.
# ❌ If the below resources are not present in the Azure Cloud, the terraform code will ❌ FAIL.

resource_group_name  = <ENTER backend - Resource Group>          # Example: "rg-backend"
storage_account_name = <ENTER backend - Storage Account>         # Example: "storageaccount"
container_name       = <ENTER backend - Storage Container Name>  # Example: "storagecontainer"
key                  = <ENTER backend - State File Name>         # Example: "a.terraform.tfstate"
````

## Step 02 - Update azure subscription id in the below mentioned file.
#### ✅ Update this with your own subscription ID.
````yaml
infra01.auto.tfvars
---------------------------------------------------------------------------------------------------
# ✅ Update this with your own subscription ID.
main_provider_subscription_id = "00000000-0000-0000-00000000"
````

## Step 03 - Update variables in the below mentioned file.
#### All variables like Resource Group Location, VNet Address, Subnet Address needs to be updated.
````yaml
infra01.auto.tfvars
---------------------------------------------------------------------------------------------------
# ✅ Update this with your own Azure region.
root_resource_location        = "East US"

# ✅ Update this with your own VNet address space.
root_vnet_address_space       = ["46.87.0.0/24"]

# ✅ Update this with your own subnet address prefixes.
root_subnet_address_prefixes  = ["46.87.0.0/28"]
````

## Step 04 - Following command needs to be executed to initialize the backend.
#### ✅ Run with -backend-config parameter, else the initialize will ask for user input.
````yaml
terraform init -backend-config='backend-config-infra01.hcl'
````

## Step 05 - Following commands can be used to proceed with infrastructure creation.
````yaml
terraform validate
terraform plan
````

## ❌ DO Not run terraform apply with auto-approve as user input is needed for user prefix.
#### ✅ Only run terrafom apply, as user input is need for dynamically creating resource names.
````yaml
terraform apply

# ❌ Do Not run terraform apply -auto-approve
````
