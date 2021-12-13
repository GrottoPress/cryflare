## Accounts

An *account* represents a *Cloudflare* account.

### Schema

An account is represented as `Cryflare::Account`.

See https://api.cloudflare.com/#accounts-properties for the raw JSON schema.

### Usage Examples

1. Update account:

   ```crystal
   # `Cryflare::Account::Endpoint#replace` uses
   # `PUT` request method, instead of `PATCH` used by
   # its `#update` counterpart
   client.accounts.replace(
     "account-id",
     id: "account-id",
     name: "account-name",
     settings: {enforce_twofactor: false},
     created_on: Time.utc
   ) do |response|
     if response.success?
       response.result.try do |account|
         puts account.id
         puts account.name
         puts account.settings
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

1. Get all accounts:

   ```crystal
   client.accounts.list(per_page: 20, page: 2) do |response|
     if response.success?
       response.result.try &.each do |account|
         puts account.id
         puts account.name
         puts account.created_on
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

1. Get single account:

   ```crystal
   client.accounts.fetch("account-id") do |response|
     if response.success?
       response.result.try do |account|
         puts account.id
         puts account.name
         puts account.settings
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
