## User

A *user* represents the current *Cloudflare* user.

### Schema

A user is represented as `Cryflare::User`.

See https://api.cloudflare.com/#user-properties for the raw JSON schema.

### Usage Examples

1. Update user:

   ```crystal
   client.users.update(first_name: "John") do |response|
     if response.success?
       response.result.try do |user|
         puts user.id
         puts user.first_name
         puts user.last_name
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

1. Get user details:

   ```crystal
   client.users.fetch do |response|
     if response.success?
       response.result.try do |user|
         puts user.telephone
         puts user.country
         puts user.zipcode
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
