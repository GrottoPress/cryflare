# TODO:
# - `#import`
# - `#export`
class Cryflare::DnsRecord::Endpoint
  def initialize(@cryflare : Cryflare)
  end

  def create(zone_id : String, **params)
    yield create(zone_id, **params)
  end

  def create(zone_id : String, **params) : Item
    @cryflare.post(
      "#{self.class.path(zone_id)}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(zone_id : String, id : String, **params)
    yield update(zone_id, id, **params)
  end

  def update(zone_id : String, id : String, **params) : Item
    @cryflare.patch(
      "#{self.class.path(zone_id)}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def replace(zone_id : String, id : String, **params)
    yield replace(zone_id, id, **params)
  end

  def replace(zone_id : String, id : String, **params) : Item
    @cryflare.put(
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
    @cryflare.delete("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(zone_id : String, **params)
    yield index(zone_id, **params)
  end

  def index(zone_id : String, **params) : List
    @cryflare.get(
      "#{self.class.path(zone_id)}?#{HTTP::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def show(zone_id : String, id : String)
    yield show(zone_id, id)
  end

  def show(zone_id : String, id : String) : Item
    @cryflare.get("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path(zone_id : String) : String
    "#{Zone::Endpoint.path}/#{zone_id}/dns_records"
  end

  def self.uri(zone_id : String) : URI
    uri = Cryflare.base_uri
    uri.path = path(zone_id)
    uri
  end
end
