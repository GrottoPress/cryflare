struct Cryflare::Zone::Endpoint
  include Hapi::Endpoint

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    response = @client.post(self.class.path, body: params.to_json)
    Item.from_json(response.body)
  end

  def update(id : String, **params)
    yield update(id, **params)
  end

  def update(id : String, **params) : Item
    response = @client.patch("#{self.class.path}/#{id}", body: params.to_json)
    Item.from_json(response.body)
  end

  def delete(id : String)
    yield delete(id)
  end

  def delete(id : String) : Item
    response = @client.delete("#{self.class.path}/#{id}")
    Item.from_json(response.body)
  end

  def list(**params)
    yield list(**params)
  end

  def list(**params) : List
    response = @client.get("#{self.class.path}?#{URI::Params.encode(params)}")
    List.from_json(response.body)
  end

  def fetch(id : String)
    yield fetch(id)
  end

  def fetch(id : String) : Item
    response = @client.get("#{self.class.path}/#{id}")
    Item.from_json(response.body)
  end

  def check_activation(id : String)
    yield check_activation(id)
  end

  def check_activation(id : String) : Item
    response = @client.put("#{self.class.path}/#{id}/activation_check")
    Item.from_json(response.body)
  end

  def purge_cache(id : String, **params)
    yield purge_cache(id, **params)
  end

  def purge_cache(id : String, **params) : Item
    response = @client.post(
      "#{self.class.path}/#{id}/purge_cache",
      body: params.to_json
    )

    Item.from_json(response.body)
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
