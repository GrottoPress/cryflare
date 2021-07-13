struct Cryflare::User::Endpoint
  include Hapi::Endpoint

  def update(**params)
    yield update(**params)
  end

  def update(**params) : Item
    @client.patch(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
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
    "#{Cryflare.path}/user"
  end

  def self.uri : URI
    uri = Cryflare.uri
    uri.path = path
    uri
  end
end
