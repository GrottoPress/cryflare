struct Cryflare::AccountRole::Endpoint
  include Cryflare::Endpoint

  def list(account_id : String)
    yield list(account_id)
  end

  def list(account_id : String) : List
    response = @client.get(self.class.path account_id)
    List.from_json(response.body)
  end

  def fetch(account_id : String, id : String)
    yield fetch(account_id, id)
  end

  def fetch(account_id : String, id : String) : Item
    response = @client.get("#{self.class.path(account_id)}/#{id}")
    Item.from_json(response.body)
  end

  def self.path(account_id : String) : String
    "#{Account::Endpoint.path}/#{account_id}/roles"
  end

  def self.uri(account_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(account_id)
    uri
  end
end
