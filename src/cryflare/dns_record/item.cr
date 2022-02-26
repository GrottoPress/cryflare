struct Cryflare::DnsRecord::Item
  include Response

  struct Resource
    getter result : DnsRecord?
  end
end
