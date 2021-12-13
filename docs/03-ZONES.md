## Zones

A *zone* represents a *Cloudflare* zone.

### Schema

A zone is represented as `Cryflare::Zone`.

See https://api.cloudflare.com/#zone-properties for the raw JSON schema.

### Usage Examples

1. Create new zone:

   ```crystal
   client.zones.create(
     name: "example.tld",
     account: {id: "account-id"},
     jump_start: true
   ) do |response|
     if response.success?
       response.result.try do |zone|
         puts zone.id
         puts zone.name
         puts zone.development_mode
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

1. Update existing zone:

   ```crystal
   client.zones.update("zone-id", paused: true) do |response|
     if response.success?
       response.result.try do |zone|
         puts zone.modified_on
         zone.name_servers.try &.each { |name_server| puts name_server }
         puts zone.original_dnshost
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

1. Delete a zone:

   ```crystal
   client.zones.delete("zone-id") do |response|
     if response.success?
       response.result.try do |zone|
         puts zone.id
       end
     else
       response.errors.each do |error|
         puts error.code
         puts error.message
       end
     end
   end
   ```

1. Get all zones:

   ```crystal
   client.zones.index(order: "name", status: "active") do |response|
     if response.success?
       response.result.try &.each do |zone|
         zone.original_name_servers.try &.each { |ns| puts ns }
         puts zone.original_registrar
         puts zone.owner.name
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

   You may get a single zone by name, by passing the `name` parameter:

   ```crystal
   client.zones.index(name: "example.tld") do |response|
     puts response.result.try &.first?.try &.id
   end
   ```

1. Get single zone:

   ```crystal
   client.zones.show("zone-id") do |response|
     if response.success?
       response.result.try do |zone|
         puts zone.paused?
         zone.permissions.try &.each { |permission| puts permission }
         puts zone.plan.try &.id
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

1. Check activation:

   ```crystal
   client.zones.check_activation("zone-id") do |response|
     if response.success?
       response.result.try do |zone|
         puts zone.plan_pending.try &.id
         puts zone.status
         puts zone.type
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

1. Purge cache:

   ```crystal
   client.zones.purge_cache("zone-id", purge_everything: true) do |response|
     if response.success?
       response.result.try do |zone|
         puts zone.account.try &.id
         puts zone.activated_on
         puts zone.created_on
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
