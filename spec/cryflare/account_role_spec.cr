require "../spec_helper"

describe Cryflare::AccountRole::Endpoint do
  describe "#index" do
    it "lists account roles" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": [
            {
              "id": "3536bcfad5faccb999b47003c79917fb",
              "name": "Account Administrator",
              "description": "Administrative access to the entire Account",
              "permissions": {
                "analytics": {
                  "read": true,
                  "write": true
                },
                "billing": {
                  "read": true,
                  "write": true
                },
                "cache_purge": {
                  "read": true,
                  "write": true
                },
                "dns": {
                  "read": true,
                  "write": true
                },
                "dns_records": {
                  "read": true,
                  "write": true
                },
                "lb": {
                  "read": true,
                  "write": true
                },
                "logs": {
                  "read": true,
                  "write": true
                },
                "organization": {
                  "read": true,
                  "write": true
                },
                "ssl": {
                  "read": true,
                  "write": true
                },
                "waf": {
                  "read": true,
                  "write": true
                },
                "zones": {
                  "read": true,
                  "write": true
                },
                "zone_settings": {
                  "read": true,
                  "write": true
                }
              }
            }
          ]
        }
        JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/roles"
      ).to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.account_roles.list("a1b2c3") do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Array(Cryflare::AccountRole))
      end
    end
  end

  describe "#show" do
    it "shows account role" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "3536bcfad5faccb999b47003c79917fb",
            "name": "Account Administrator",
            "description": "Administrative access to the entire Account",
            "permissions": {
              "analytics": {
                "read": true,
                "write": true
              },
              "billing": {
                "read": true,
                "write": true
              },
              "cache_purge": {
                "read": true,
                "write": true
              },
              "dns": {
                "read": true,
                "write": true
              },
              "dns_records": {
                "read": true,
                "write": true
              },
              "lb": {
                "read": true,
                "write": true
              },
              "logs": {
                "read": true,
                "write": true
              },
              "organization": {
                "read": true,
                "write": true
              },
              "ssl": {
                "read": true,
                "write": true
              },
              "waf": {
                "read": true,
                "write": true
              },
              "zones": {
                "read": true,
                "write": true
              },
              "zone_settings": {
                "read": true,
                "write": true
              }
            }
          }
        }
        JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/roles/d4e5f6"
      ).to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.account_roles.fetch("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountRole)
        response.result.try(&.permissions.billing.read?).should be_true
      end
    end
  end
end
