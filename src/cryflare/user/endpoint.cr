struct Cryflare::User::Endpoint
  include Cryflare::Endpoint

  def update(**params)
    yield update(**params)
  end

  def update(**params) : Item
    response = @client.patch(self.class.path, body: params.to_json)
    Item.from_json(response.body)
  end

  def fetch
    yield fetch
  end

  def fetch : Item
    response = @client.get(self.class.path)
    Item.from_json(response.body)
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
