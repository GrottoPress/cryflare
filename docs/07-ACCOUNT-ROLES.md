## Account Roles

An *account role* represents a *Cloudflare* account role.

### Schema

An account role is represented as `Cryflare::AccountRole`.

See https://api.cloudflare.com/#account-roles-properties for the raw JSON schema.

### Usage Examples

1. Get all account roles:

   ```crystal
   client.account_roles.list("account-id") do |response|
     if response.success?
       response.result.try &.each do |account_role|
         puts account_role.id
         puts account_role.name
         puts account_role.description
         # ...
       end
     else
       response.errors.each do |error|
         puts error.code
         puts error.message
       end
     end
   end
   ```

1. Get single account role:

   ```crystal
   client.account_roles.show("account-id", "role-id") do |response|
     if response.success?
       response.result.try do |account_role|
         puts account_role.id
         puts account_role.name
         puts account_role.permissions.billing.read?
         # ...
       end
     else
       response.errors.each do |error|
         puts error.code
         puts error.message
       end
     end
   end
   ```
