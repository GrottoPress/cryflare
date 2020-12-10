class Cryflare::Account::Endpoint
  def initialize(@client : Client)
  end

  def replace(__ id : String, **params)
    yield replace(id, **params)
  end

  def replace(__ id : String, **params) : Item
    @client.put("#{self.class.path}/#{id}", body: params.to_json) do |response|
      Item.from_json(response.body_io)
    end
  end

  def index(**params)
    yield index(**params)
  end

  def index(**params) : List
    @client.get(
      "#{self.class.path}?#{HTTP::Params.encode(params)}"
    ) do |response|
      List.from_json(response.body_io)
    end
  end

  def show(id : String)
    yield show(id)
  end

  def show(id : String) : Item
    @client.get("#{self.class.path}/#{id}") do |response|
      Item.from_json(response.body_io)
    end
  end

  def self.path : String
    "#{Client.path}/accounts"
  end

  def self.uri : URI
    uri = Client.base_uri
    uri.path = path
    uri
  end
end
