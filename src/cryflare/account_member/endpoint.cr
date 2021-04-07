class Cryflare::AccountMember::Endpoint
  def initialize(@cryflare : Cryflare)
  end

  def create(account_id : String, **params)
    yield create(account_id, **params)
  end

  def create(account_id : String, **params) : Item
    @cryflare.post(
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
    @cryflare.put(
      "#{self.class.path(account_id)}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def destroy(account_id : String, id : String)
    yield destroy(account_id, id)
  end

  def destroy(account_id : String, id : String) : Item
    @cryflare.delete("#{self.class.path(account_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(account_id : String, **params)
    yield index(account_id, **params)
  end

  def index(account_id : String, **params) : List
    @cryflare.get(
      "#{self.class.path(account_id)}?#{HTTP::Params.encode(params)}"
    ) do |response|
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
    "#{Account::Endpoint.path}/#{account_id}/members"
  end

  def self.uri(account_id : String) : URI
    uri = Cryflare.base_uri
    uri.path = path(account_id)
    uri
  end
end
