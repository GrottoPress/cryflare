## Zone Settings

A *zone setting* represents a *Cloudflare* zone setting.

### Schema

A zone setting is represented as `Cryflare::ZoneSetting`.

See https://api.cloudflare.com/#zone-settings-properties for the raw JSON schema.

### Usage Examples

1. Update mutiple settings for a zone:

   ```crystal
   client.zone_settings.update(
      "zone-id",
      items: [
        {id: "always_online", value: "on"},
        {id: "browser_cache_ttl", value: 18000}
      ]
    ) do |response|
     if response.success?
       response.result.try &.each do |zone_setting|
         puts zone_setting.id
         puts zone_setting.value
         puts zone_setting.editable?
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

1. Update a single setting for a zone:

   ```crystal
   client.zone_settings.update(
      "zone-id",
      "browser_cache_ttl",
      value: 14400
    ) do |response|
     if response.success?
       response.result.try do |zone_setting|
         puts zone_setting.id
         puts zone_setting.value
         puts zone_setting.editable?
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

1. Get all settings for a zone:

   ```crystal
   client.zone_settings.list("zone-id") do |response|
     if response.success?
       response.result.try &.each do |zone_setting|
         puts zone_setting.id
         puts zone_setting.value
         puts zone_setting.modified_on
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

1. Get a single setting for a zone:

   ```crystal
   client.zone_settings.fetch("zone-id", "zone-setting-id") do |response|
     if response.success?
       response.result.try do |zone_setting|
         puts zone_setting.id
         puts zone_setting.value
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

1. Get a single zone by name, and get its settings:

   ```crystal
   client.zones.list(name: "example.tld") do |response|
     return unless response.errors.empty?

     response.result.try &.first?.try do |zone|
       stg_response = client.zone_settings.list(zone.id)

       stg_response.result.try &.each do |zone_setting|
         puts zone_setting.id
         # ...
       end
     end
   end
   ```
