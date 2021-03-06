struct Cryflare::Filter::Endpoint
  include Hapi::Endpoint

  def create(zone_id : String, filters : Array(NamedTuple))
    yield create(zone_id, filters)
  end

  def create(zone_id : String, filters : Array(NamedTuple)) : List
    @client.post(
      self.class.path(zone_id),
      body: filters.to_json
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def replace(zone_id : String, filters : Array(NamedTuple))
    yield replace(zone_id, filters)
  end

  def replace(zone_id : String, filters : Array(NamedTuple)) : List
    @client.put(self.class.path(zone_id), body: filters.to_json) do |response|
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

  def destroy(zone_id : String, id : String)
    yield destroy(zone_id, id)
  end

  def destroy(zone_id : String, id : String) : Item
    @client.delete("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(zone_id : String, **params)
    yield index(zone_id, **params)
  end

  def index(zone_id : String, **params) : List
    @client.get(
      "#{self.class.path(zone_id)}?#{URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def show(zone_id : String, id : String)
    yield show(zone_id, id)
  end

  def show(zone_id : String, id : String) : Item
    @client.get("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
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
