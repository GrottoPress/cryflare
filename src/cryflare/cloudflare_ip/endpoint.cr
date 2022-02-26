struct Cryflare::CloudflareIp::Endpoint
  include Hapi::Endpoint

  def fetch
    yield fetch
  end

  def fetch : Item
    @client.get(self.class.path) do |response|
      Item.new(response)
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
