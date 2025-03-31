require "http/client"
require "json"

require "./cryflare/version"
require "./cryflare/endpoint"
require "./cryflare/resource"
require "./cryflare/**"

struct Cryflare
  def initialize(*, token : String)
    set_headers
    authenticate(token: token)
  end

  def initialize(*, key : String)
    set_headers
    authenticate(key: key)
  end

  def initialize(*, email : String, key : String)
    set_headers
    authenticate(email, key)
  end

  forward_missing_to http_client

  def accounts : Account::Endpoint
    Account::Endpoint.new(self)
  end

  def account_access_rules : AccountAccessRule::Endpoint
    AccountAccessRule::Endpoint.new(self)
  end

  def account_members : AccountMember::Endpoint
    AccountMember::Endpoint.new(self)
  end

  def account_roles : AccountRole::Endpoint
    AccountRole::Endpoint.new(self)
  end

  def cloudflare_ips : CloudflareIp::Endpoint
    CloudflareIp::Endpoint.new(self)
  end

  def dns_records : DnsRecord::Endpoint
    DnsRecord::Endpoint.new(self)
  end

  def filters : Filter::Endpoint
    Filter::Endpoint.new(self)
  end

  def firewall_rules : FirewallRule::Endpoint
    FirewallRule::Endpoint.new(self)
  end

  def user : User::Endpoint
    User::Endpoint.new(self)
  end

  def user_access_rules : UserAccessRule::Endpoint
    UserAccessRule::Endpoint.new(self)
  end

  def user_organizations : UserOrganization::Endpoint
    UserOrganization::Endpoint.new(self)
  end

  def zones : Zone::Endpoint
    Zone::Endpoint.new(self)
  end

  def zone_access_rules : ZoneAccessRule::Endpoint
    ZoneAccessRule::Endpoint.new(self)
  end

  def zone_settings : ZoneSetting::Endpoint
    ZoneSetting::Endpoint.new(self)
  end

  def self.path : String
    "/client/v4"
  end

  def self.uri : URI
    URI.parse("https://api.cloudflare.com#{path}")
  end

  private def http_client : HTTP::Client
    @http_client ||= HTTP::Client.new(self.class.uri)
  end

  private def set_headers
    http_client.before_request do |request|
      set_content_type(request.headers)
      set_user_agent(request.headers)
    end
  end

  private def authenticate(*, token : String)
    http_client.before_request do |request|
      request.headers["Authorization"] = "Bearer #{token}"
    end
  end

  private def authenticate(*, key : String)
    http_client.before_request do |request|
      request.headers["X-Auth-User-Service-Key"] = key
    end
  end

  private def authenticate(email : String, key : String)
    http_client.before_request do |request|
      request.headers["X-Auth-Email"] = email
      request.headers["X-Auth-Key"] = key
    end
  end

  private def set_content_type(headers)
    headers["Content-Type"] = "application/json; charset=UTF-8"
  end

  private def set_user_agent(headers)
    headers["User-Agent"] = "Cryflare/#{Cryflare::VERSION} \
      (+https://github.com/GrottoPress/cryflare)"
  end
end
