struct Cryflare::DnsRecord::Meta
  include JSON::Serializable

  getter? auto_added : Bool
  getter source : String
end
