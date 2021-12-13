## Account Members

An *Account Memeber* represents a *Cloudflare* account member.

### Schema

An account member is represented as `Cryflare::AccountMember`.

See https://api.cloudflare.com/#account-members-properties for the raw JSON schema.

### Usage Examples

1. Create new account member:

   ```crystal
   client.account_members.create(
     "account-id",
     email: "email-address",
     roles: ["role-id", "another-role-id"]
   ) do |response|
     if response.success?
       response.result.try do |account_member|
         puts account_member.id
         puts account_member.code
         puts account_member.status
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

1. Update existing account member:

   ```crystal
   client.account_members.update(
     "account-id",
     "member-id",
     code: "activation-code",
     status: "pending"
   ) do |response|
     if response.success?
       response.result.try do |account_member|
         puts account_member.id
         puts account_member.roles.try &.first?.try &.id
         puts account_member.user.try &.id
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

1. Remove account member:

   ```crystal
   client.account_members.delete("account-id", "member-id") do |response|
     if response.success?
       response.result.try do |account_member|
         puts account_member.id
       end
     else
       response.errors.each do |error|
         puts error.code
         puts error.message
       end
     end
   end
   ```

1. Get all account members:

   ```crystal
   client.account_members.index(
     "account-id",
     per_page: "20",
     direction: "desc"
   ) do |response|
     if response.success?
       response.result.try &.each do |account_member|
         puts account_member.id
         puts account_member.roles.try &.first?.try &.id
         puts account_member.user.try &.id
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

1. Get single account member:

   ```crystal
   client.account_members.show("account-id", "member-id") do |response|
     if response.success?
       response.result.try do |account_member|
         puts account_member.id
         puts account_member.code
         puts account_member.status
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
