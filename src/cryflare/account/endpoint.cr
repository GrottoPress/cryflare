struct Cryflare::Account::Endpoint
  include Hapi::Endpoint

  def replace(__ id : String, **params)
    yield replace(id, **params)
  end

  def replace(__ id : String, **params) : Item
    response = @client.put("#{self.class.path}/#{id}", body: params.to_json)
    Item.from_json(response.body)
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    response = @client.get("#{self.class.path}?#{URI::Params.encode(params)}")
    List.from_json(response.body)
  end

  def fetch(id : String)
    yield fetch(id)
  end

  def fetch(id : String) : Item
    response = @client.get("#{self.class.path}/#{id}")
    Item.from_json(response.body)
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
