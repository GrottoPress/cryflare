require "../spec_helper"

describe Cryflare::UserAccessRule::Endpoint do
  describe "#create" do
    it "creates new user access rule" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "92f17202ed8bd63d69a66b86a49a8f6b",
            "notes": "This rule is on because of an event that occured",
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
        "https://api.cloudflare.com/client/v4/user/firewall/access_rules/rules"
      )
        .with(body: %({"mode":"js_challenge"}))
        .to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.user_access_rules.create(mode: "js_challenge") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::UserAccessRule)
      end
    end
  end

  describe "#update" do
    it "updates existing user access rule" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "92f17202ed8bd63d69a66b86a49a8f6b",
            "notes": "This rule is on because of an event that occured",
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
        "https://api.cloudflare.com/client/v4/user/firewall/access_rules/rules/a1b2c3"
      )
        .with(body: %({"mode":"block"}))
        .to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.user_access_rules.update("a1b2c3", mode: "block") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::UserAccessRule)
      end
    end
  end

  describe "#destroy" do
    it "deletes user access rule" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "92f17202ed8bd63d69a66b86a49a8f6b"
          }
        }
        JSON

      WebMock.stub(
        :delete,
        "https://api.cloudflare.com/client/v4/user/firewall/access_rules/rules/a1b2c3"
      ).to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.user_access_rules.delete("a1b2c3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::UserAccessRule)
      end
    end
  end

  describe "#index" do
    it "lists user access rules" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": [
            {
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
          ]
        }
        JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/user/firewall/access_rules/rules"
      )
        .with(query: {"notes" => "my note"})
        .to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.user_access_rules.list(notes: "my note") do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::UserAccessRule))
      end
    end
  end
end
