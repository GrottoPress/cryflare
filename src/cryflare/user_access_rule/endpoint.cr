class Cryflare::UserAccessRule::Endpoint
  def initialize(@client : Client)
  end

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(id : String, **params)
    yield update(id, **params)
  end

  def update(id : String, **params) : Item
    @client.patch(
      "#{self.class.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def destroy(id : String)
    yield destroy(id)
  end

  def destroy(id : String) : Item
    @client.delete("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(**params)
    yield index(**params)
  end

  def index(**params) : List
    @client.get(
      "#{self.class.path}?#{HTTP::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{User::Endpoint.path}/firewall/access_rules/rules"
  end

  def self.uri : URI
    uri = Client.base_uri
    uri.path = path
    uri
  end
end
