# Cryflare

*Cryflare* is a low-level API client for *Cloudflare&reg;* v4. It features an intuitive interface that maps perfectly to the *Cloudflare* API.

### Usage Examples

```crystal
# Create a new client
client = Cryflare::Client.new(
  email: "cloudflare-email",
  key: "cloudflare-api-key"
)
```

1. Get zone by name
   ```crystal
   client.zones.index(name: "grottopress.com") do |response|
     if response.success?
       response.result.try &.first?.try do |zone|
         puts zone.id
         puts zone.name
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

1. Create new DNS record
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

1. Delete firewall rule
   ```crystal
   client.firewall_rules.destroy("zone-id", "rule-id") do |response|
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

## Documentation

Find the complete documentation in the `docs/` directory of this repository.

## Todo

- [x] Accounts
- [x] Account members
- [x] Account roles
- [x] User
- [ ] User memberships
- [x] User organizations
- [x] Zones
- [x] Zone settings
- [x] DNS records
- [x] Cloudflare IPs
- [x] User-level Firewall Access Rule
- [x] Account-level Firewall access rule
- [x] Firewall Access Rule for a Zone
- [x] Filters
- [x] Firewall rules
- [ ] Page Rules for a Zone
- [ ] Available Page Rules for a Zone

## Development

Create a `.env` file:

```bash
CLOUDFLARE_EMAIL=myemail@example.tld
CLOUDFLARE_KEY=abcdefghijklmnopqrstuvwxyz
```

Update the file with your own details. Then run tests with `docker-compose run --rm spec`. If you need to update shards before that, run `docker-compose run --rm shards`.

If you would rather run tests on your local machine (ie, without docker), create a `.env.sh` file:

```bash
#!/bin/bash
#
export CLOUDFLARE_EMAIL='myemail@example.tld'
export CLOUDFLARE_KEY='abcdefghijklmnopqrstuvwxyz'
```

Update the file with your own details. Then run tests with `source .env.sh && crystal spec`.

**IMPORTANT**: Remember to set permissions for your env files to `0600` or stricter: `chmod 0600 .env*`.

## Contributing

1. [Fork it](https://github.com/GrottoPress/cryflare/fork)
1. Switch to the `dev` branch: `git checkout dev`
1. Create your feature branch: `git checkout -b my-new-feature`
1. Make your changes, updating changelog and documentation as appropriate.
1. Commit your changes: `git commit`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a new *Pull Request* against the `GrottoPress:dev` branch.

## Security

Kindly report suspected security vulnerabilities in private, via contact details outlined in this repository's `.security.txt` file.

## Legal

*Cloudflare is a registered trademark of Cloudflare, Inc.*
