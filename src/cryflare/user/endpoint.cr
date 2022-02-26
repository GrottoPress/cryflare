struct Cryflare::User::Endpoint
  include Hapi::Endpoint

  def update(**params)
    yield update(**params)
  end

  def update(**params) : Item
    response = @client.patch(self.class.path, body: params.to_json)
    Item.new(response)
  end

  def fetch
    yield fetch
  end

  def fetch : Item
    response = @client.get(self.class.path)
    Item.new(response)
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
