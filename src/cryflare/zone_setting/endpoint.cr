struct Cryflare::ZoneSetting::Endpoint
  include Cryflare::Endpoint

  def update(zone_id : String, **params)
    yield update(zone_id, **params)
  end

  def update(zone_id : String, **params) : List
    response = @client.patch(
      "#{self.class.path(zone_id)}",
      body: params.to_json
    )

    List.from_json(response.body)
  end

  def update(zone_id : String, id : String, **params)
    yield update(zone_id, id, **params)
  end

  def update(zone_id : String, id : String, **params) : Item
    response = @client.patch(
      "#{self.class.path(zone_id)}/#{id}",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def list(zone_id : String)
    yield list(zone_id)
  end

  def list(zone_id : String) : List
    response = @client.get("#{self.class.path(zone_id)}")
    List.from_json(response.body)
  end

  def fetch(zone_id : String, id : String)
    yield fetch(zone_id, id)
  end

  def fetch(zone_id : String, id : String) : Item
    response = @client.get("#{self.class.path(zone_id)}/#{id}")
    Item.from_json(response.body)
  end

  def self.path(zone_id : String) : String
    "#{Zone::Endpoint.path}/#{zone_id}/settings"
  end

  def self.uri(zone_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(zone_id)
    uri
  end
end
