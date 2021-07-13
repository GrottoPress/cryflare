struct Cryflare::CloudflareIp::Endpoint
  include Hapi::Endpoint

  def show
    yield show
  end

  def show : Item
    @client.get(self.class.path) do |response|
      Item.from_json(response.body_io)
    end
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
