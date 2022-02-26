struct Cryflare::Filter::Endpoint
  include Hapi::Endpoint

  def create(zone_id : String, filters : Array(NamedTuple))
    yield create(zone_id, filters)
  end

  def create(zone_id : String, filters : Array(NamedTuple)) : List
    response = @client.post(self.class.path(zone_id), body: filters.to_json)
    List.from_json(response.body)
  end

  def replace(zone_id : String, filters : Array(NamedTuple))
    yield replace(zone_id, filters)
  end

  def replace(zone_id : String, filters : Array(NamedTuple)) : List
    response = @client.put(self.class.path(zone_id), body: filters.to_json)
    List.from_json(response.body)
  end

  def replace(zone_id : String, __ id : String, **params)
    yield replace(zone_id, id, **params)
  end

  def replace(zone_id : String, __ id : String, **params) : Item
    response = @client.put(
      "#{self.class.path(zone_id)}/#{id}",
      body: params.to_json
    )

    Item.from_json(response.body)
  end

  def delete(zone_id : String, id : String)
    yield delete(zone_id, id)
  end

  def delete(zone_id : String, id : String) : Item
    response = @client.delete("#{self.class.path(zone_id)}/#{id}")
    Item.from_json(response.body)
  end

  def list(zone_id : String, **params)
    yield list(zone_id, **params)
  end

  def list(zone_id : String, **params) : List
    response = @client.get(
      "#{self.class.path(zone_id)}?#{URI::Params.encode(params)}"
    )

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
    "#{Zone::Endpoint.path}/#{zone_id}/filters"
  end

  def self.uri(zone_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(zone_id)
    uri
  end
end
