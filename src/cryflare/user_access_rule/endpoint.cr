class Cryflare::UserAccessRule::Endpoint
  def initialize(@cryflare : Cryflare)
  end

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @cryflare.post(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(id : String, **params)
    yield update(id, **params)
  end

  def update(id : String, **params) : Item
    @cryflare.patch(
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
    @cryflare.delete("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(**params)
    yield index(**params)
  end

  def index(**params) : List
    @cryflare.get(
      "#{self.class.path}?#{HTTP::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{User::Endpoint.path}/firewall/access_rules/rules"
  end

  def self.uri : URI
    uri = Cryflare.base_uri
    uri.path = path
    uri
  end
end
