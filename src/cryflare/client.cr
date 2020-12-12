class Cryflare::Client
  def initialize(*, token : String)
    initialize

    http_client.before_request do |request|
      request.headers["Authorization"] = "Bearer #{token}"
    end
  end

  def initialize(*, key : String)
    initialize

    http_client.before_request do |request|
      request.headers["X-Auth-User-Service-Key"] = key
    end
  end

  def initialize(*, email : String, key : String)
    initialize

    http_client.before_request do |request|
      request.headers["X-Auth-Email"] = email
      request.headers["X-Auth-Key"] = key
    end
  end

  delegate :close,
      :compress=,
      :compress?,
      :connect_timeout=,
      :delete,
      :dns_timeout=,
      :get,
      :patch,
      :port,
      :post,
      :put,
      :read_timeout=,
      :write_timeout=,
    to: http_client

  def accounts : Account::Endpoint
    @accounts ||= Account::Endpoint.new(self)
  end

  def account_members : AccountMember::Endpoint
    @account_members ||= AccountMember::Endpoint.new(self)
  end

  def account_roles : AccountRole::Endpoint
    @account_roles ||= AccountRole::Endpoint.new(self)
  end

  def cloudflare_ips : CloudflareIp::Endpoint
    @cloudflare_ips ||= CloudflareIp::Endpoint.new(self)
  end

  def dns_records : DnsRecord::Endpoint
    @dns_records ||= DnsRecord::Endpoint.new(self)
  end

  def user : User::Endpoint
    @user ||= User::Endpoint.new(self)
  end

  def user_organizations : UserOrganization::Endpoint
    @user_organizations ||= UserOrganization::Endpoint.new(self)
  end

  def zones : Zone::Endpoint
    @zones ||= Zone::Endpoint.new(self)
  end

  def zone_settings : ZoneSetting::Endpoint
    @zone_settings ||= ZoneSetting::Endpoint.new(self)
  end

  def self.path : String
    "/client/v4"
  end

  def self.uri : URI
    uri = base_uri
    uri.path = path
    uri
  end

  def self.base_uri : URI
    URI.parse("https://api.cloudflare.com")
  end

  private def initialize
    http_client.before_request do |request|
      set_content_type(request.headers)
      set_user_agent(request.headers)
    end
  end

  private def http_client : HTTP::Client
    @http_client ||= HTTP::Client.new(self.class.base_uri)
  end

  private def set_content_type(headers)
    headers["Content-Type"] = "application/json; charset=UTF-8"
  end

  private def set_user_agent(headers)
    headers["User-Agent"] = "Cryflare/#{Cryflare::VERSION} \
      (+https://github.com/GrottoPress/cryflare)"
  end
end
