## Firewall Rules

A *Firewall rule* represents a *Cloudflare* firewall rule.

### Schema

A firewall rule is represented as `Cryflare::FirewallRule`.

See https://api.cloudflare.com/#firewall-rules-properties for the raw JSON schema.

### Usage Examples

1. Create new firewall rules:

   ```crystal
   client.firewall_rules.create(
     "zone-id",
     [{action: "log", filter: {id: "filter-id", expression: "ip.addr eq 1.2.3.4"}}]
   ) do |response|
     if response.success?
       response.result.try &.each do |firewall_rule|
         puts firewall_rule.id
         puts firewall_rule.paused?
         puts firewall_rule.priority
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

1. Update single firewall rule:

   ```crystal
   client.firewall_rules.replace(
     "zone-id",
     "rule-id",
     id: "rule-id",
     paused: true
   ) do |response|
     if response.success?
       response.result.try do |firewall_rule|
         puts firewall_rule.id
         puts firewall_rule.paused?
         puts firewall_rule.ref
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

1. Update multiple firewall rules:

   ```crystal
   client.firewall_rules.replace(
     "zone-id",
     [{id: "rule-id", paused: true}, {id: "another-rule-id", ref: "FIL-20"}]
   ) do |response|
     if response.success?
       response.result.try &.each do |firewall_rule|
         puts firewall_rule.action
         puts firewall_rule.description
         puts firewall_rule.filter.id
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

1. Delete single firewall rule:

   ```crystal
   client.firewall_rules.delete("zone-id", "rule-id") do |response|
     if response.success?
       response.result.try do |firewall_rule|
         puts firewall_rule.id
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

1. Get all firewall rules:

   ```crystal
   client.firewall_rules.list(
     "zone-id",
     paused: "true",
     per_page: "25"
   ) do |response|
     if response.success?
       response.result.try &.each do |firewall_rule|
         puts firewall_rule.action_parameters.uri.path.value
         puts firewall_rule.action_parameters.uri.query.value
         firewall_rule.products.each { |product| puts product }
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

1. Get single firewall rule:

   ```crystal
   client.firewall_rules.fetch("zone-id", "rule-id") do |response|
     if response.success?
       response.result.try do |firewall_rule|
         puts firewall_rule.id
         puts firewall_rule.paused?
         puts firewall_rule.priority
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
