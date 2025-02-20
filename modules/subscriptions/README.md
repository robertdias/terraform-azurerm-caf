# Azure Subscription Creation

This module can create Azure Subscriptions under an Enterprise Agreement (EA) or a Microsoft Customer Agreement (MCA).

Note -> It has not been tested for a Microsoft Partner Agreement (MPA). Open an issue if you have such requirement.

The following pre-requisites must be performed before using that module.

## Pre-requisites

This module must be executed with
- An Azure Active Directory user being and EA Account Owner
- An Azure Active directory User that has been delegated the subscription creation role
- An Azure Active directory App SPN that has been delegated the subscription creation role
- An Azure System Managed Identity (system MSI) that has been delegated the subscription creation role
- An Azure User Managed Identity (user MSI) that has been delegated the subscription creation role

### Enteprise Agreement

```bash

az rest --method get --uri https://management.azure.com/providers/Microsoft.Billing/billingaccounts/?api-version=2020-05-01

# The billing account should be in the form of
# /providers/Microsoft.Billing/billingAccounts/7777777/enrollmentAccounts/666666

# When you have identified the billing profile you can retrieve the enrollment account under the billing profile
# the following command retrieve the the first one --> enrollmentAccounts[0]

enrollmentAccount=$(az rest --method get \
  --uri https://management.azure.com/providers/Microsoft.Billing/billingaccounts?api-version=2020-05-01 \
  --query "value[?properties.agreementType=='EnterpriseAgreement'].{id:properties.enrollmentAccounts[0].id}" -o tsv)

```


### Delegate the subscription creation permission role


``` bash

tenantId=$(az account show --query tenantId -o tsv)

# Object to delegate the subscription creation role.
# Set the ObjectID of the AAD App SP
# Set the principalID of the MSI
principalId=""

billing_role_definition_id=$(az rest --method GET --url https://management.azure.com${enrollmentAccount}/billingRoleDefinitions?api-version=2019-10-01-preview --query "value[?properties.roleName=='Enrollment account subscription creator'].{id:id}" -o tsv)

az rest --method PUT --url https://management.azure.com/${enrollmentAccount}/billingRoleAssignments/0525cbc2-c84e-4279-b639-adab918a96b8?api-version=2019-10-01-preview --body "{\"properties\": {\"principalId\": \"${principalId}\",\"principalTenantId\": \"${tenantId}\",\"roleDefinitionId\": \"${enrollmentAccount}/billingRoleDefinitions/${billing_role_definition_id}\"}}

# Login as the principalId and create a subscription to confirm the delegation of permission is effective.

az account alias create \
  --name "alias_name" \
  --billing-scope "${enrollmentAccount}" \
  --display-name "name of the subscription" \
  --workload "Production"

```