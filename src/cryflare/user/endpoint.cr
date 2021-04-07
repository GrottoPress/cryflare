class Cryflare::User::Endpoint
  def initialize(@cryflare : Cryflare)
  end

  def update(**params)
    yield update(**params)
  end

  def update(**params) : Item
    @cryflare.patch(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
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
    "#{Cryflare.path}/user"
  end

  def self.uri : URI
    uri = Cryflare.base_uri
    uri.path = path
    uri
  end
end
