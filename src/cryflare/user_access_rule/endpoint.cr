struct Cryflare::UserAccessRule::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.path, body: params.to_json) do |response|
      Item.new(response)
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
      Item.new(response)
    end
  end

  def delete(id : String)
    yield delete(id)
  end

  def delete(id : String) : Item
    @client.delete("#{self.class.path}/#{id}") do |response|
      Item.new(response)
    end
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    @client.get(
      "#{self.class.path}?#{URI::Params.encode(params)}"
    ) do |response|
      List.new(response)
    end
  end

  def self.path : String
    "#{User::Endpoint.path}/firewall/access_rules/rules"
  end

  def self.uri : URI
    uri = Cryflare.uri
    uri.path = path
    uri
  end
end
