# TODO:
# - `#import`
# - `#export`
struct Cryflare::DnsRecord::Endpoint
  include Hapi::Endpoint

  def create(zone_id : String, **params)
    yield create(zone_id, **params)
  end

  def create(zone_id : String, **params) : Item
    @client.post(
      "#{self.class.path(zone_id)}",
      body: params.to_json
    ) do |response|
      Item.new(response)
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
      Item.new(response)
    end
  end

  def replace(zone_id : String, id : String, **params)
    yield replace(zone_id, id, **params)
  end

  def replace(zone_id : String, id : String, **params) : Item
    @client.put(
      "#{self.class.path(zone_id)}/#{id}",
      body: params.to_json
    ) do |response|
      Item.new(response)
    end
  end

  def delete(zone_id : String, id : String)
    yield delete(zone_id, id)
  end

  def delete(zone_id : String, id : String) : Item
    @client.delete("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.new(response)
    end
  end

  def list(zone_id : String, **params)
    yield list(zone_id, **params)
  end

  def list(zone_id : String, **params) : List
    @client.get(
      "#{self.class.path(zone_id)}?#{URI::Params.encode(params)}"
    ) do |response|
      List.new(response)
    end
  end

  def fetch(zone_id : String, id : String)
    yield fetch(zone_id, id)
  end

  def fetch(zone_id : String, id : String) : Item
    @client.get("#{self.class.path(zone_id)}/#{id}") do |response|
      Item.new(response)
    end
  end

  def self.path(zone_id : String) : String
    "#{Zone::Endpoint.path}/#{zone_id}/dns_records"
  end

  def self.uri(zone_id : String) : URI
    uri = Cryflare.uri
    uri.path = path(zone_id)
    uri
  end
end
