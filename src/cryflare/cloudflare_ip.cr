struct Cryflare::CloudflareIp
  include JSON::Serializable

  getter ipv4_cidrs : Array(String)
  getter ipv6_cidrs : Array(String)
  getter etag : String
end
