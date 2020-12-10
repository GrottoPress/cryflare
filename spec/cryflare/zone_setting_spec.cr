require "../spec_helper"

describe Cryflare::ZoneSetting::Endpoint do
  describe "#update" do
    it "updates zone setting" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "browser_cache_ttl",
          "value": 14400,
          "editable": true,
          "modified_on": "2014-01-01T05:20:00.12345Z"
        }
      }
      JSON

      WebMock.stub(
        :patch,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/settings/browser_cache_ttl"
      )
        .with(body: %({"value":14400}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zone_settings.update(
        "a1b2c3",
        "browser_cache_ttl",
        value: 14400
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::ZoneSetting)
      end
    end

    it "updates all zone settings" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": []
      }
      JSON

      WebMock.stub(
        :patch,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/settings"
      )
        .with(body: %({"items":[{"id":"always_online","value":"on"}]}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zone_settings.update(
        "a1b2c3",
        items: [{id: "always_online", value: "on"}]
      ) do |response|
        response.success?.should be_true
      end
    end
  end

  describe "#index" do
    it "lists zone settings" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": []
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/settings"
      ).to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zone_settings.index("a1b2c3") do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Array(Cryflare::ZoneSetting))
      end
    end
  end

  describe "#show" do
    it "shows zone setting" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "advanced_ddos",
          "value": "off",
          "editable": true,
          "modified_on": "2014-01-01T05:20:00.12345Z"
        }
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/settings/advanced_ddos"
      ).to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.zone_settings.show("a1b2c3", "advanced_ddos") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::ZoneSetting)
      end
    end
  end
end
