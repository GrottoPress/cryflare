## Filters

A *Filter* represents a *Cloudflare* filter.

### Schema

A filter is represented as `Cryflare::Filter`.

See https://api.cloudflare.com/#filters-properties for the raw JSON schema.

### Usage Examples

1. Create new filters:

   ```crystal
   client.filters.create(
     "zone-id",
     [{expression: "ip.addr eq 1.2.3.4"}]
   ) do |response|
     if response.success?
       response.result.try &.each do |filter|
         puts filter.id
         puts filter.expression
         puts filter.description
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

1. Update single filter:

   ```crystal
   client.filters.replace(
     "zone-id",
     "filter-id",
     id: "filter-id",
     paused: true
   ) do |response|
     if response.success?
       response.result.try do |filter|
         puts filter.id
         puts filter.paused?
         puts filter.ref
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

1. Update multiple filters:

   ```crystal
   client.filters.replace(
     "zone-id",
     [{id: "filter-id", paused: true}, {id: "another-filter-id", ref: "FIL-20"}]
   ) do |response|
     if response.success?
       response.result.try &.each do |filter|
         puts filter.id
         puts filter.paused?
         puts filter.ref
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

1. Delete single filter:

   ```crystal
   client.filters.delete("zone-id", "filter-id") do |response|
     if response.success?
       response.result.try do |filter|
         puts filter.id
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

1. Get all filters:

   ```crystal
   client.filters.list("zone-id", paused: "true", per_page: "25") do |response|
     if response.success?
       response.result.try &.each do |filter|
         puts filter.id
         puts filter.expression
         puts filter.description
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

1. Get single filter:

   ```crystal
   client.filters.fetch("zone-id", "filter-id") do |response|
     if response.success?
       response.result.try do |filter|
         puts filter.id
         puts filter.expression
         puts filter.description
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
