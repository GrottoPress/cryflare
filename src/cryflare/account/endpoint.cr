struct Cryflare::Account::Endpoint
  include Hapi::Endpoint

  def replace(__ id : String, **params)
    yield replace(id, **params)
  end

  def replace(__ id : String, **params) : Item
    @client.put(
      "#{self.class.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    @client.get(
      "#{self.class.path}?#{URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def show(id : String)
    yield show(id)
  end

  def show(id : String) : Item
    @client.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Cryflare.path}/accounts"
  end

  def self.uri : URI
    uri = Cryflare.uri
    uri.path = path
    uri
  end
end
