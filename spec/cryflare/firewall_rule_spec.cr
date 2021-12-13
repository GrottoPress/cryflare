require "../spec_helper"

describe Cryflare::FirewallRule::Endpoint do
  describe "#create" do
    it "creates new filter" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "372e67954025e0ba6aaa6d586b9e0b60",
            "action": "block",
            "action_parameters": {
              "uri": {
                "path": {
                  "value": "/blog"
                },
                "query": {
                  "value": "page=0"
                }
              }
            },
            "products": [
              "waf"
            ],
            "priority": 50,
            "paused": false,
            "description": "Blocks traffic",
            "ref": "MIR-31",
            "filter": {
              "id": "372e67954025e0ba6aaa6d586b9e0b61",
              "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
              "paused": false,
              "description": "Restrict access from these browsers.",
              "ref": "FIL-100"
            }
          }
        ]
      }
      JSON

      WebMock.stub(
        :post,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/firewall/rules"
      )
        .with(body: %([{"action":"log"}]))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.firewall_rules.create("a1b2c3", [{action: "log"}]) do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::FirewallRule))
      end
    end
  end

  describe "#replace" do
    it "updates multiple filters" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "372e67954025e0ba6aaa6d586b9e0b60",
            "action": "block",
            "action_parameters": {
              "uri": {
                "path": {
                  "value": "/blog"
                },
                "query": {
                  "value": "page=0"
                }
              }
            },
            "products": [
              "waf"
            ],
            "priority": 50,
            "paused": false,
            "description": "Blocks traffic",
            "ref": "MIR-31",
            "filter": {
              "id": "372e67954025e0ba6aaa6d586b9e0b61",
              "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
              "paused": false,
              "description": "Restrict access from these browsers.",
              "ref": "FIL-100"
            }
          }
        ]
      }
      JSON

      WebMock.stub(
        :put,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/firewall/rules"
      )
        .with(body: %([{"id":"d4e5f6"}]))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.firewall_rules.replace("a1b2c3", [{id: "d4e5f6"}]) do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::FirewallRule))
      end
    end

    it "updates single filter" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b60",
          "action": "block",
          "action_parameters": {
            "uri": {
              "path": {
                "value": "/blog"
              },
              "query": {
                "value": "page=0"
              }
            }
          },
          "products": [
            "waf"
          ],
          "priority": 50,
          "paused": false,
          "description": "Blocks traffic",
          "ref": "MIR-31",
          "filter": {
            "id": "372e67954025e0ba6aaa6d586b9e0b61",
            "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
            "paused": false,
            "description": "Restrict access from these browsers.",
            "ref": "FIL-100"
          }
        }
      }
      JSON

      WebMock.stub(
        :put,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/firewall/rules/d4e5f6"
      )
        .with(body: %({"id":"d4e5f6"}))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.firewall_rules.replace(
        "a1b2c3",
        "d4e5f6",
        id: "d4e5f6"
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::FirewallRule)

        response.result
          .try(&.action_parameters.uri.path.value)
          .should(eq "/blog")
      end
    end
  end

  describe "#destroy" do
    it "deletes single filter" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b60",
          "action": "block",
          "action_parameters": {
            "uri": {
              "path": {
                "value": "/blog"
              },
              "query": {
                "value": "page=0"
              }
            }
          },
          "products": [
            "waf"
          ],
          "priority": 50,
          "paused": false,
          "description": "Blocks traffic",
          "ref": "MIR-31",
          "filter": {
            "id": "372e67954025e0ba6aaa6d586b9e0b61",
            "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
            "paused": false,
            "description": "Restrict access from these browsers.",
            "ref": "FIL-100"
          }
        }
      }
      JSON

      WebMock.stub(
        :delete,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/firewall/rules/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.firewall_rules.delete("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::FirewallRule)
      end
    end
  end

  describe "#index" do
    it "lists filters" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "372e67954025e0ba6aaa6d586b9e0b60",
            "action": "block",
            "action_parameters": {
              "uri": {
                "path": {
                  "value": "/blog"
                },
                "query": {
                  "value": "page=0"
                }
              }
            },
            "products": [
              "waf"
            ],
            "priority": 50,
            "paused": false,
            "description": "Blocks traffic",
            "ref": "MIR-31",
            "filter": {
              "id": "372e67954025e0ba6aaa6d586b9e0b61",
              "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
              "paused": false,
              "description": "Restrict access from these browsers.",
              "ref": "FIL-100"
            }
          }
        ]
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/firewall/rules"
      )
        .with(query: {"paused" => "true"})
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.firewall_rules.list("a1b2c3", paused: "true") do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::FirewallRule))
      end
    end
  end

  describe "#show" do
    it "shows filter" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b60",
          "action": "block",
          "action_parameters": {
            "uri": {
              "path": {
                "value": "/blog"
              },
              "query": {
                "value": "page=0"
              }
            }
          },
          "products": [
            "waf"
          ],
          "priority": 50,
          "paused": false,
          "description": "Blocks traffic",
          "ref": "MIR-31",
          "filter": {
            "id": "372e67954025e0ba6aaa6d586b9e0b61",
            "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
            "paused": false,
            "description": "Restrict access from these browsers.",
            "ref": "FIL-100"
          }
        }
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/firewall/rules/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.firewall_rules.fetch("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::FirewallRule)
      end
    end
  end
end
