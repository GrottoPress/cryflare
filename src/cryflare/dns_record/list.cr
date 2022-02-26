struct Cryflare::DnsRecord::List
  include Response

  struct Resource
    getter result : Array(DnsRecord)?
  end
end
