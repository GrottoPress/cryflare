struct Cryflare::User::Endpoint
  include Hapi::Endpoint

  def update(**params)
    yield update(**params)
  end

  def update(**params) : Item
    @client.patch(self.class.path, body: params.to_json) do |response|
      Item.new(response)
    end
  end

  def fetch
    yield fetch
  end

  def fetch : Item
    @client.get(self.class.path) do |response|
      Item.new(response)
    end
  end

  def self.path : String
    "#{Cryflare.path}/user"
  end

  def self.uri : URI
    uri = Cryflare.uri
    uri.path = path
    uri
  end
end
