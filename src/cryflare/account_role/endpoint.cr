struct Cryflare::AccountRole::Endpoint
  include Hapi::Endpoint

  def list(account_id : String)
    yield list(account_id)
  end

  def list(account_id : String) : List
    @client.get(self.class.path account_id) do |response|
      List.new(response)
    end
  end

  def fetch(account_id : String, id : String)
    yield fetch(account_id, id)
  end

  def fetch(account_id : String, id : String) : Item
    @client.get("#{self.class.path(account_id)}/#{id}") do |response|
      Item.new(response)
    end
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
