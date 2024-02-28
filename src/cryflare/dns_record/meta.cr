struct Cryflare::DnsRecord::Meta
  include Cryflare::Resource

  getter? auto_added : Bool?
  getter source : String?
  getter managed_by_apps : Bool?
  getter managed_by_argo_tunnel : Bool?
end
