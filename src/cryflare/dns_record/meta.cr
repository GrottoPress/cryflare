struct Cryflare::DnsRecord::Meta
  include Cryflare::Resource

  getter? auto_added : Bool
  getter source : String
end
