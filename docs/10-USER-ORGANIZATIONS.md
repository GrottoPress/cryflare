## User Organizations

A *user organization* represents a *Cloudflare* user organization.

### Schema

A user organization is represented as `Cryflare::UserOrganization`.

See https://api.cloudflare.com/#user-s-organizations-properties for the raw JSON schema.

### Usage Examples

1. Leave organization:

   ```crystal
   client.user_organizations.delete("organization-id") do |response|
     if response.success?
       response.result.try do |user_organization|
         puts user_organization.id
         puts user_organization.name
         user_organization.roles.try &.each { |role| puts role }
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

1. Get all of your organizations:

   ```crystal
   client.user_organizations.list(status: "member") do |response|
     if response.success?
       response.result.try &.each do |user_organization|
         puts user_organization.id
         puts user_organization.name
         puts user_organization.status
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

1. Get single organization:

   ```crystal
   client.user_organizations.fetch("organization-id") do |response|
     if response.success?
       response.result.try do |user_organization|
         puts user_organization.id
         puts user_organization.name

         user_organization.permissions.try &.each do |permission|
           puts permission
         end
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
