class Cryflare::User::Endpoint
  def initialize(@client : Client)
  end

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
    @client.get(self.class.path) { |response| Item.from_json(response.body_io) }
  end

  def self.path : String
    "#{Client.path}/user"
  end

  def self.uri : URI
    uri = Client.base_uri
    uri.path = path
    uri
  end
end
