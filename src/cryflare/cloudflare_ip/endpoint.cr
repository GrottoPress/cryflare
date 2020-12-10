class Cryflare::CloudflareIp::Endpoint
  def initialize(@client : Client)
  end

  def show
    yield show
  end

  def show : Item
    @client.get(self.class.path) do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Client.path}/ips"
  end

  def self.uri : URI
    uri = Client.base_uri
    uri.path = path
    uri
  end
end
