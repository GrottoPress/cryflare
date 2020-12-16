require "../spec_helper"

describe Cryflare::AccountAccessRule::Endpoint do
  describe "#create" do
    it "creates new account access rule" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "92f17202ed8bd63d69a66b86a49a8f6b",
          "notes": "On because of an event that occured on date X",
          "allowed_modes": [
            "whitelist",
            "block",
            "challenge",
            "js_challenge"
          ],
          "mode": "challenge",
          "configuration": {
            "target": "ip",
            "value": "198.51.100.4"
          },
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "scope": {
            "id": "7c5dae5552338874e5053f2534d2767a",
            "email": "user@example.com",
            "type": "user"
          }
        }
      }
      JSON

      WebMock.stub(
        :post,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/firewall/access_rules/rules"
      )
        .with(body: %({"mode":"block"}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.account_access_rules.create("a1b2c3", mode: "block") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountAccessRule)
      end
    end
  end

  describe "#update" do
    it "updates existing account access rule" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "92f17202ed8bd63d69a66b86a49a8f6b",
          "notes": "This rule is on because of an event that occured on date X",
          "allowed_modes": [
            "whitelist",
            "block",
            "challenge",
            "js_challenge"
          ],
          "mode": "challenge",
          "configuration": {
            "target": "ip",
            "value": "198.51.100.4"
          },
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "scope": {
            "id": "7c5dae5552338874e5053f2534d2767a",
            "email": "user@example.com",
            "type": "user"
          }
        }
      }
      JSON

      WebMock.stub(
        :patch,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/firewall/access_rules/rules/d4e5f6"
      )
        .with(body: %({"id":"d4e5f6","mode":"block"}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.account_access_rules.update(
        "a1b2c3",
        "d4e5f6",
        id: "d4e5f6",
        mode: "block"
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountAccessRule)
      end
    end
  end

  describe "#destroy" do
    it "deletes account access rule" do
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
        :delete,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/firewall/access_rules/rules/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.account_access_rules.destroy("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountAccessRule)
      end
    end
  end

  describe "#index" do
    it "lists account access rules" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "92f17202ed8bd63d69a66b86a49a8f6b",
            "notes": "On because of an event that occured on date X",
            "allowed_modes": [
              "whitelist",
              "block",
              "challenge",
              "js_challenge"
            ],
            "mode": "challenge",
            "configuration": {
              "target": "ip",
              "value": "198.51.100.4"
            },
            "created_on": "2014-01-01T05:20:00.12345Z",
            "modified_on": "2014-01-01T05:20:00.12345Z",
            "scope": {
              "id": "7c5dae5552338874e5053f2534d2767a",
              "email": "user@example.com",
              "type": "user"
            }
          }
        ]
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/firewall/access_rules/rules"
      )
        .with(query: {"per_page" => "30"})
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.account_access_rules.index("a1b2c3", per_page: "30") do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::AccountAccessRule))
      end
    end
  end

  describe "#show" do
    it "shows account access rule" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "92f17202ed8bd63d69a66b86a49a8f6b",
          "notes": "This rule is on because of an event that occured on date X",
          "allowed_modes": [
            "whitelist",
            "block",
            "challenge",
            "js_challenge"
          ],
          "mode": "challenge",
          "configuration": {
            "target": "ip",
            "value": "198.51.100.4"
          },
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "scope": {
            "id": "7c5dae5552338874e5053f2534d2767a",
            "email": "user@example.com",
            "type": "user"
          }
        }
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/firewall/access_rules/rules/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.account_access_rules.show("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountAccessRule)
      end
    end
  end
end
