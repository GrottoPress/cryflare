require "hapi"

require "./cryflare/version"
require "./cryflare/**"

class Cryflare
  include Hapi::Client

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

  private def initialize
    http_client.before_request do |request|
      set_content_type(request.headers)
      set_user_agent(request.headers)
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
