struct Cryflare::CloudflareIp::Item
  include Response

  struct Resource
    getter result : CloudflareIp?
  end
end
