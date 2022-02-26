struct Cryflare::AccountAccessRule::Endpoint
  include Hapi::Endpoint

  def create(account_id : String, **params)
    yield create(account_id, **params)
  end

  def create(account_id : String, **params) : Item
    response = @client.post(self.class.path(account_id), body: params.to_json)
    Item.from_json(response.body)
  end

  def update(account_id : String, __ id : String, **params)
    yield update(account_id, id, **params)
  end

  def update(account_id : String, __ id : String, **params) : Item
    response = @client.patch(
      "#{self.class.path(account_id)}/#{id}",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def delete(account_id : String, id : String)
    yield delete(account_id, id)
  end

  def delete(account_id : String, id : String) : Item
    response = @client.delete("#{self.class.path(account_id)}/#{id}")
    Item.from_json(response.body)
  end

  def list(account_id : String, **params)
    yield list(account_id, **params)
  end

  def list(account_id : String, **params) : List
    response = @client.get(
      "#{self.class.path(account_id)}?#{URI::Params.encode(params)}"
    )

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
    "#{Account::Endpoint.path}/#{account_id}/firewall/access_rules/rules"
  end

  def self.uri(account_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(account_id)
    uri
  end
end
