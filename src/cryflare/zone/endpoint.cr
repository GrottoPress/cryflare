struct Cryflare::Zone::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @client.post(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(id : String, **params)
    yield update(id, **params)
  end

  def update(id : String, **params) : Item
    @client.patch(
      "#{self.class.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def delete(id : String)
    yield delete(id)
  end

  def delete(id : String) : Item
    @client.delete("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    @client.get(
      "#{self.class.path}?#{URI::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def fetch(id : String)
    yield fetch(id)
  end

  def fetch(id : String) : Item
    @client.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def check_activation(id : String)
    yield check_activation(id)
  end

  def check_activation(id : String) : Item
    @client.put("#{self.class.path}/#{id}/activation_check") do |response|
      Item.from_json(response.body_io)
    end
  end

  def purge_cache(id : String, **params)
    yield purge_cache(id, **params)
  end

  def purge_cache(id : String, **params) : Item
    @client.post(
      "#{self.class.path}/#{id}/purge_cache",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Cryflare.path}/zones"
  end

  def self.uri : URI
    uri = Cryflare.uri
    uri.path = path
    uri
  end
end
