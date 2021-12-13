## Cloudflare IPs

*Cloudflare IPs* represents *Cloudflare* IP addresses.

### Schema

Cloudflare IPs is represented as `Cryflare::CloudflareIp`.

See https://api.cloudflare.com/#cloudflare-ips-properties for the raw JSON schema.

### Usage Examples

1. Get Cloudflare IP addresses:

   ```crystal
   client.cloudflare_ips.fetch do |response|
     if response.success?
       response.result.try do |cloudflare_ips|
         cloudflare_ips.ipv4_cidrs.each { |ip| puts ip }
         cloudflare_ips.ipv6_cidrs.each { |ip| puts ip }
         puts cloudflare_ips.etag
       end
     else
       response.errors.each do |error|
         puts error.code
         puts error.message
       end
     end
   end
   ```
