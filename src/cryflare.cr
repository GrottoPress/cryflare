require "http/client"
require "json"

require "./cryflare/version"
require "./cryflare/endpoint"
require "./cryflare/resource"
require "./cryflare/**"

class Cryflare
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

  getter accounts : Account::Endpoint do
    Account::Endpoint.new(self)
  end

  getter account_access_rules : AccountAccessRule::Endpoint do
    AccountAccessRule::Endpoint.new(self)
  end

  getter account_members : AccountMember::Endpoint do
    AccountMember::Endpoint.new(self)
  end

  getter account_roles : AccountRole::Endpoint do
    AccountRole::Endpoint.new(self)
  end

  getter cloudflare_ips : CloudflareIp::Endpoint do
    CloudflareIp::Endpoint.new(self)
  end

  getter dns_records : DnsRecord::Endpoint do
    DnsRecord::Endpoint.new(self)
  end

  getter filters : Filter::Endpoint do
    Filter::Endpoint.new(self)
  end

  getter firewall_rules : FirewallRule::Endpoint do
    FirewallRule::Endpoint.new(self)
  end

  getter user : User::Endpoint do
    User::Endpoint.new(self)
  end

  getter user_access_rules : UserAccessRule::Endpoint do
    UserAccessRule::Endpoint.new(self)
  end

  getter user_organizations : UserOrganization::Endpoint do
    UserOrganization::Endpoint.new(self)
  end

  getter zones : Zone::Endpoint do
    Zone::Endpoint.new(self)
  end

  getter zone_access_rules : ZoneAccessRule::Endpoint do
    ZoneAccessRule::Endpoint.new(self)
  end

  getter zone_settings : ZoneSetting::Endpoint do
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
