struct Cryflare::DnsRecord::List
  include Response

  getter result : Array(DnsRecord)?
end
