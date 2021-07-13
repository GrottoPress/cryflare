struct Cryflare::CloudflareIp
  include Hapi::Resource

  getter ipv4_cidrs : Array(String)
  getter ipv6_cidrs : Array(String)
  getter etag : String
end
