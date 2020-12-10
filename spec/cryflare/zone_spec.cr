require "../spec_helper"

describe Cryflare::Zone::Endpoint do
  describe "#create" do
    it "creates new zone" do
      response_json = IO::Memory.new <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "023e105f4ecef8ad9ca31a8372d0c353",
            "name": "example.tld",
            "development_mode": 7200,
            "original_name_servers": [
              "ns1.originaldnshost.com",
              "ns2.originaldnshost.com"
            ],
            "original_registrar": "GoDaddy",
            "original_dnshost": "NameCheap",
            "created_on": "2014-01-01T05:20:00.12345Z",
            "modified_on": "2014-01-01T05:20:00.12345Z",
            "activated_on": "2014-01-02T00:01:00.12345Z",
            "owner": {
              "id": {},
              "email": {},
              "type": "user"
            },
            "account": {
              "id": "01a7362d577a6c3019a474fd6f485823",
              "name": "Demo Account"
            },
            "permissions": [
              "#zone:read",
              "#zone:edit"
            ],
            "plan": {
              "id": "e592fd9519420ba7405e1307bff33214",
              "name": "Pro Plan",
              "price": 20,
              "currency": "USD",
              "frequency": "monthly",
              "legacy_id": "pro",
              "is_subscribed": true,
              "can_subscribe": true
            },
            "plan_pending": {
              "id": "e592fd9519420ba7405e1307bff33214",
              "name": "Pro Plan",
              "price": 20,
              "currency": "USD",
              "frequency": "monthly",
              "legacy_id": "pro",
              "is_subscribed": true,
              "can_subscribe": true
            },
            "status": "active",
            "paused": false,
            "type": "full",
            "name_servers": [
              "tony.ns.cloudflare.com",
              "woz.ns.cloudflare.com"
            ]
          }
        }
        JSON

      WebMock.stub(:post, "https://api.cloudflare.com/client/v4/zones")
        .with(body: %({"name":"example.tld"}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zones.create(name: "example.tld") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Zone)
      end
    end
  end

  describe "#update" do
    it "updates existing zone" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "023e105f4ecef8ad9ca31a8372d0c353",
          "name": "example.com",
          "development_mode": 7200,
          "original_name_servers": [
            "ns1.originaldnshost.com",
            "ns2.originaldnshost.com"
          ],
          "original_registrar": "GoDaddy",
          "original_dnshost": "NameCheap",
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "activated_on": "2014-01-02T00:01:00.12345Z",
          "owner": {
            "id": {},
            "email": {},
            "type": "user"
          },
          "account": {
            "id": "01a7362d577a6c3019a474fd6f485823",
            "name": "Demo Account"
          },
          "permissions": [
            "#zone:read",
            "#zone:edit"
          ],
          "plan": {
            "id": "e592fd9519420ba7405e1307bff33214",
            "name": "Pro Plan",
            "price": 20,
            "currency": "USD",
            "frequency": "monthly",
            "legacy_id": "pro",
            "is_subscribed": true,
            "can_subscribe": true
          },
          "plan_pending": {
            "id": "e592fd9519420ba7405e1307bff33214",
            "name": "Pro Plan",
            "price": 20,
            "currency": "USD",
            "frequency": "monthly",
            "legacy_id": "pro",
            "is_subscribed": true,
            "can_subscribe": true
          },
          "status": "active",
          "paused": true,
          "type": "full",
          "name_servers": [
            "tony.ns.cloudflare.com",
            "woz.ns.cloudflare.com"
          ]
        }
      }
      JSON

      WebMock.stub(:patch, "https://api.cloudflare.com/client/v4/zones/a1b2c3")
        .with(body: %({"paused":true}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zones.update("a1b2c3", paused: true) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Zone)
      end
    end
  end

  describe "#delete" do
    it "deletes zone" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "9a7806061c88ada191ed06f989cc3dac"
        }
      }
      JSON

      WebMock.stub(:delete, "https://api.cloudflare.com/client/v4/zones/a1b2c3")
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zones.destroy("a1b2c3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Zone)
      end
    end
  end

  describe "#index" do
    it "lists zones" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "023e105f4ecef8ad9ca31a8372d0c353",
            "name": "example.com",
            "development_mode": 7200,
            "original_name_servers": [
              "ns1.originaldnshost.com",
              "ns2.originaldnshost.com"
            ],
            "original_registrar": "GoDaddy",
            "original_dnshost": "NameCheap",
            "created_on": "2014-01-01T05:20:00.12345Z",
            "modified_on": "2014-01-01T05:20:00.12345Z",
            "activated_on": "2014-01-02T00:01:00.12345Z",
            "owner": {
              "id": {},
              "email": {},
              "type": "user"
            },
            "account": {
              "id": "01a7362d577a6c3019a474fd6f485823",
              "name": "Demo Account"
            },
            "permissions": [
              "#zone:read",
              "#zone:edit"
            ],
            "plan": {
              "id": "e592fd9519420ba7405e1307bff33214",
              "name": "Pro Plan",
              "price": 20,
              "currency": "USD",
              "frequency": "monthly",
              "legacy_id": "pro",
              "is_subscribed": true,
              "can_subscribe": true
            },
            "plan_pending": {
              "id": "e592fd9519420ba7405e1307bff33214",
              "name": "Pro Plan",
              "price": 20,
              "currency": "USD",
              "frequency": "monthly",
              "legacy_id": "pro",
              "is_subscribed": true,
              "can_subscribe": true
            },
            "status": "active",
            "paused": false,
            "type": "full",
            "name_servers": [
              "tony.ns.cloudflare.com",
              "woz.ns.cloudflare.com"
            ]
          }
        ]
      }
      JSON

      WebMock.stub(:get, "https://api.cloudflare.com/client/v4/zones")
        .with(query: {"name" => "example.tld"})
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zones.index(name: "example.tld") do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::Zone))
      end
    end
  end

  describe "#show" do
    it "shows zone" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "023e105f4ecef8ad9ca31a8372d0c353",
          "name": "example.com",
          "development_mode": 7200,
          "original_name_servers": [
            "ns1.originaldnshost.com",
            "ns2.originaldnshost.com"
          ],
          "original_registrar": "GoDaddy",
          "original_dnshost": "NameCheap",
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "activated_on": "2014-01-02T00:01:00.12345Z",
          "owner": {
            "id": {},
            "email": {},
            "type": "user"
          },
          "account": {
            "id": "01a7362d577a6c3019a474fd6f485823",
            "name": "Demo Account"
          },
          "permissions": [
            "#zone:read",
            "#zone:edit"
          ],
          "plan": {
            "id": "e592fd9519420ba7405e1307bff33214",
            "name": "Pro Plan",
            "price": 20,
            "currency": "USD",
            "frequency": "monthly",
            "legacy_id": "pro",
            "is_subscribed": true,
            "can_subscribe": true
          },
          "plan_pending": {
            "id": "e592fd9519420ba7405e1307bff33214",
            "name": "Pro Plan",
            "price": 20,
            "currency": "USD",
            "frequency": "monthly",
            "legacy_id": "pro",
            "is_subscribed": true,
            "can_subscribe": true
          },
          "status": "active",
          "paused": false,
          "type": "full",
          "name_servers": [
            "tony.ns.cloudflare.com",
            "woz.ns.cloudflare.com"
          ]
        }
      }
      JSON

      WebMock.stub(:get, "https://api.cloudflare.com/client/v4/zones/a1b2c3")
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zones.show("a1b2c3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Zone)
      end
    end
  end

  describe "#check_activation" do
    it "checks zone's activation status" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "9a7806061c88ada191ed06f989cc3dac"
        }
      }
      JSON

      WebMock.stub(
        :put,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/activation_check"
      ).to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zones.check_activation("a1b2c3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Zone)
      end
    end
  end

  describe "#purge_cache" do
    it "purges zone's cache" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "9a7806061c88ada191ed06f989cc3dac"
        }
      }
      JSON

      WebMock.stub(
        :post,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/purge_cache"
      )
        .with(body: %({"purge_everything":true}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zones.purge_cache("a1b2c3", purge_everything: true) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Zone)
      end
    end
  end
end
