## DNS Records

A *DNS record* represents a *Cloudflare* DNS record.

### Schema

A DNS record is represented as `Cryflare::DnsRecord`.

See https://api.cloudflare.com/#dns-records-for-a-zone-properties for the raw JSON schema.

### Usage Examples

1. Create new DNS record:

   ```crystal
   client.dns_records.create(
     "zone-id",
     type: "A",
     name: "example.com",
     content: "127.0.0.1",
     ttl: 120
   ) do |response|
     if response.success?
       response.result.try do |dns_record|
         puts dns_record.id
         puts dns_record.name
         puts dns_record.content
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

1. Update existing DNS record:

   ```crystal
   client.dns_records.update(
      "zone-id",
      "dns-record-id",
      type: "A",
      content: "127.0.0.1"
   ) do |response|
     if response.success?
       response.result.try do |dns_record|
         puts dns_record.type
         puts dns_record.name
         puts dns_record.content
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

1. Replace existing DNS record:

   ```crystal
   # `Cryflare::DnsRecord::Endpoint#replace` uses
   # `PUT` request method, instead of `PATCH` used by
   # its `#update` counterpart
   client.dns_records.replace(
      "zone-id",
      "dns-record-id",
      type: "A",
      name: "example.com",
      content: "127.0.0.1",
      ttl: 120
   ) do |response|
     if response.success?
       response.result.try do |dns_record|
         puts dns_record.type
         puts dns_record.name
         puts dns_record.content
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

1. Delete DNS record:

   ```crystal
   client.dns_records.delete("zone-id", "dns-record-id") do |response|
     if response.success?
       response.result.try do |dns_record|
         puts dns_record.id
       end
     else
       response.errors.each do |error|
         puts error.code
         puts error.message
       end
     end
   end
   ```

1. Get all DNS records:

   ```crystal
   client.dns_records.list("zone-id", per_page: 10) do |response|
     if response.success?
       response.result.try &.each do |dns_record|
         puts dns_record.created_on
         puts dns_record.ttl
         puts dns_record.zone_name
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

1. Get single DNS record:

   ```crystal
   client.dns_records.fetch("zone-id", "dns-record-id") do |response|
     if response.success?
       response.result.try do |dns_record|
         puts dns_record.modified_on
         puts dns_record.priority
         puts dns_record.proxied?
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

1. Get a single zone by name, and get its DNS records:

   ```crystal
   client.zones.list(name: "example.tld") do |response|
     return unless response.errors.empty?

     response.result.try &.first?.try do |zone|
       dns_response = client.dns_records.list(zone.id, per_page: 100)

       dns_response.result.try &.each do |dns_record|
         puts dns_record.id
         # ...
       end
     end
   end
   ```
