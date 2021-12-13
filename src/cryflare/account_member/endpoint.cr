struct Cryflare::AccountMember::Endpoint
  include Hapi::Endpoint

  def create(account_id : String, **params)
    yield create(account_id, **params)
  end

  def create(account_id : String, **params) : Item
    @client.post(
      self.class.path(account_id),
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def replace(account_id : String, __ id : String, **params)
    yield replace(account_id, id, **params)
  end

  def replace(account_id : String, __ id : String, **params) : Item
    @client.put(
      "#{self.class.path(account_id)}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def delete(account_id : String, id : String)
    yield delete(account_id, id)
  end

  def delete(account_id : String, id : String) : Item
    @client.delete("#{self.class.path(account_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(account_id : String, **params)
    yield index(account_id, **params)
  end

  def index(account_id : String, **params) : List
    @client.get(
      "#{self.class.path(account_id)}?#{URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def show(account_id : String, id : String)
    yield show(account_id, id)
  end

  def show(account_id : String, id : String) : Item
    @client.get("#{self.class.path(account_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path(account_id : String) : String
    "#{Account::Endpoint.path}/#{account_id}/members"
  end

  def self.uri(account_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(account_id)
    uri
  end
end
