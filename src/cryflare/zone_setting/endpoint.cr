struct Cryflare::ZoneSetting::Endpoint
  include Hapi::Endpoint

  def update(zone_id : String, **params)
    yield update(zone_id, **params)
  end

  def update(zone_id : String, **params) : List
    @client.patch(
      "#{self.class.path(zone_id)}",
      body: params.to_json
    ) do |response|
      List.from_json(response.body_io)
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

  def index(zone_id : String)
    yield index(zone_id)
  end

  def index(zone_id : String) : List
    @client.get("#{self.class.path(zone_id)}") do |response|
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
    "#{Zone::Endpoint.path}/#{zone_id}/settings"
  end

  def self.uri(zone_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(zone_id)
    uri
  end
end
