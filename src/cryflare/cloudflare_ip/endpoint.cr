struct Cryflare::CloudflareIp::Endpoint
  include Cryflare::Endpoint

  def fetch
    yield fetch
  end

  def fetch : Item
    response = @client.get(self.class.path)
    Item.from_json(response.body)
  end

  def self.path : String
    "#{Cryflare.path}/ips"
  end

  def self.uri : URI
    uri = Cryflare.uri
    uri.path = path
    uri
  end
end
