struct Cryflare::ZoneAccessRule::Endpoint
  include Hapi::Endpoint

  def create(zone_id : String, **params)
    yield create(zone_id, **params)
  end

  def create(zone_id : String, **params) : Item
    @client.post(
      self.class.path(zone_id),
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(zone_id : String, id : String, **params)
    yield update(zone_id, id, **params)
  end

  def update(zone_id : String, id : String, **params) : Item
    @client.patch(
      "#{self.class.path(zone_id)}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def delete(zone_id : String, id : String, **params)
    yield delete(zone_id, id, **params)
  end

  def delete(zone_id : String, id : String, **params) : Item
    @client.delete(
      "#{self.class.path(zone_id)}/#{id}",
      body: params.to_json
    ) do |response|
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

  def self.path(zone_id : String) : String
    "#{Zone::Endpoint.path}/#{zone_id}/firewall/access_rules/rules"
  end

  def self.uri(zone_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(zone_id)
    uri
  end
end
