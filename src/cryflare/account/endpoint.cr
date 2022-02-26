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

  def fetch(id : String)
    yield fetch(id)
  end

  def fetch(id : String) : Item
    @client.get("#{self.class.path}/#{id}") do |response|
      Item.new(response)
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
