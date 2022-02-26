struct Cryflare::UserOrganization::Endpoint
  include Hapi::Endpoint

  def delete(id : String)
    yield delete(id)
  end

  def delete(id : String) : Item
    response = @client.delete("#{self.class.path}/#{id}")
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
    "#{User::Endpoint.path}/organizations"
  end

  def self.uri : URI
    uri = Cryflare.uri
    uri.path = path
    uri
  end
end
