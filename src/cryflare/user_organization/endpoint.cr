class Cryflare::UserOrganization::Endpoint
  def initialize(@cryflare : Cryflare)
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

  def show(id : String)
    yield show(id)
  end

  def show(id : String) : Item
    @cryflare.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{User::Endpoint.path}/organizations"
  end

  def self.uri : URI
    uri = Cryflare.base_uri
    uri.path = path
    uri
  end
end
