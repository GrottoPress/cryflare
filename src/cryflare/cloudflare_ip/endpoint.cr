class Cryflare::CloudflareIp::Endpoint
  def initialize(@cryflare : Cryflare)
  end

  def show
    yield show
  end

  def show : Item
    @cryflare.get(self.class.path) do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Cryflare.path}/ips"
  end

  def self.uri : URI
    uri = Cryflare.base_uri
    uri.path = path
    uri
  end
end
