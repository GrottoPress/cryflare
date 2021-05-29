struct Cryflare::AccountRole::Endpoint
  def initialize(@cryflare : Cryflare)
  end

  def index(account_id : String)
    yield index(account_id)
  end

  def index(account_id : String) : List
    @cryflare.get(self.class.path account_id) do |response|
      List.from_json(response.body_io)
    end
  end

  def show(account_id : String, id : String)
    yield show(account_id, id)
  end

  def show(account_id : String, id : String) : Item
    @cryflare.get("#{self.class.path(account_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path(account_id : String) : String
    "#{Account::Endpoint.path}/#{account_id}/roles"
  end

  def self.uri(account_id : String) : URI
    uri = Cryflare.base_uri
    uri.path = path(account_id)
    uri
  end
end
