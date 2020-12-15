## User Access Rules

An *User Access Rule* represents a *Cloudflare* user-level firewall access rule.

### Schema

A user access rule is represented as `Cryflare::UserAccessRule`.

See https://api.cloudflare.com/#user-level-firewall-access-rule-properties for the raw JSON schema.

### Usage Examples

1. Create new access rule:

   ```crystal
   client.user_access_rules.create(
     mode: "block",
     configuration: {target: "ip", value: "127.0.0.1"},
     notes: "Who in their right mind blocks 'localhost'?"
   ) do |response|
     if response.success?
       response.result.try do |access_rule|
         puts access_rule.id
         puts access_rule.mode
         puts access_rule.notes
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

1. Update existing access rule:

   ```crystal
   client.user_access_rules.update("rule-id", mode: "whitelist") do |response|
     if response.success?
       response.result.try do |access_rule|
         puts access_rule.configuration.try &.target
         puts access_rule.configuration.try &.value
         puts access_rule.scope.try &.id
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

1. Remove access rule:

   ```crystal
   client.user_access_rules.destroy("rule-id") do |response|
     if response.success?
       response.result.try do |access_rule|
         puts access_rule.id
       end
     else
       response.errors.each do |error|
         puts error.code
         puts error.message
       end
     end
   end
   ```

1. Get all access rules:

   ```crystal
   client.user_access_rules.index(mode: "js_challenge") do |response|
     if response.success?
       response.result.try &.each do |access_rule|
         puts access_rule.created_on
         puts access_rule.modified_on
         puts access_rule.scope.try &.type
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
