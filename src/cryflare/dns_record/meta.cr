struct Cryflare::DnsRecord::Meta
  include Hapi::Resource

  getter? auto_added : Bool
  getter source : String
end
