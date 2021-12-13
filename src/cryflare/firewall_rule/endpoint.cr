struct Cryflare::FirewallRule::Endpoint
  include Hapi::Endpoint

  def create(zone_id : String, rules : Array(NamedTuple))
    yield create(zone_id, rules)
  end

  def create(zone_id : String, rules : Array(NamedTuple)) : List
    @client.post(self.class.path(zone_id), body: rules.to_json) do |response|
      List.from_json(response.body_io)
    end
  end

  def replace(zone_id : String, rules : Array(NamedTuple))
    yield replace(zone_id, rules)
  end

  def replace(zone_id : String, rules : Array(NamedTuple)) : List
    @client.put(self.class.path(zone_id), body: rules.to_json) do |response|
      List.from_json(response.body_io)
    end
  end

  def replace(zone_id : String, __ id : String, **params)
    yield replace(zone_id, id, **params)
  end

  def replace(zone_id : String, __ id : String, **params) : Item
    @client.put(
      "#{self.class.path(zone_id)}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def delete(zone_id : String, id : String)
    yield delete(zone_id, id)
  end

  def delete(zone_id : String, id : String) : Item
    @client.delete("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def list(zone_id : String, **params)
    yield list(zone_id, **params)
  end

  def list(zone_id : String, **params) : List
    @client.get(
      "#{self.class.path(zone_id)}?#{URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def fetch(zone_id : String, id : String)
    yield fetch(zone_id, id)
  end

  def fetch(zone_id : String, id : String) : Item
    @client.get("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path(zone_id : String) : String
    "#{Zone::Endpoint.path}/#{zone_id}/firewall/rules"
  end

  def self.uri(zone_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(zone_id)
    uri
  end
end
