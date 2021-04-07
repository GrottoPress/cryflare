class Cryflare::Zone::Endpoint
  def initialize(@cryflare : Cryflare)
  end

  def create(**params)
    yield create(**params)
  end

  def create(**params) : Item
    @cryflare.post(self.class.path, body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def update(id : String, **params)
    yield update(id, **params)
  end

  def update(id : String, **params) : Item
    @cryflare.patch(
      "#{self.class.path}/#{id}",
      body: params.to_json
    ) do |response|
      Item.from_json(response.body_io)
    end
  end

  def destroy(id : String)
    yield destroy(id)
  end

  def destroy(id : String) : Item
    @cryflare.delete("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(**params)
    yield index(**params)
  end

  def index(**params) : List
    @cryflare.get(
      "#{self.class.path}?#{HTTP::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def show(id : String)
    yield show(id)
  end

  def show(id : String) : Item
    @cryflare.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def check_activation(id : String)
    yield check_activation(id)
  end

  def check_activation(id : String) : Item
    @cryflare.put("#{self.class.path}/#{id}/activation_check") do |response|
      Item.from_json(response.body_io)
    end
  end

  def purge_cache(id : String, **params)
    yield purge_cache(id, **params)
  end

  def purge_cache(id : String, **params) : Item
    @cryflare.post(
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
    uri = Cryflare.base_uri
    uri.path = path
    uri
  end
end
