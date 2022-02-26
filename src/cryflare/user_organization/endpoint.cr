struct Cryflare::UserOrganization::Endpoint
  include Hapi::Endpoint

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

  def fetch(id : String)
    yield fetch(id)
  end

  def fetch(id : String) : Item
    @client.get("#{self.class.path}/#{id}") do |response|
      Item.new(response)
    end
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
