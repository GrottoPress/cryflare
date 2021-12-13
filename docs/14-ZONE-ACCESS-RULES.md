## Zone Access Rules

A *Zone Access Rule* represents a *Cloudflare* firewall access rule for a zone.

### Schema

A zone access rule is represented as `Cryflare::ZoneAccessRule`.

See https://api.cloudflare.com/#firewall-access-rule-for-a-zone-properties for the raw JSON schema.

### Usage Examples

1. Create new access rule:

   ```crystal
   client.zone_access_rules.create(
     "zone-id",
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
   client.zone_access_rules.update(
     "zone-id",
     "rule-id",
     mode: "whitelist"
   ) do |response|
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
   client.zone_access_rules.delete(
     "zone-id",
     "rule-id",
     cascade: "basic"
   ) do |response|
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

1. Get all account members:

   ```crystal
   client.zone_access_rules.list("zone-id", mode: "js_challenge") do |response|
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
