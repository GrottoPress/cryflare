require "../spec_helper"

describe Cryflare::AccountMember::Endpoint do
  describe "#create" do
    it "adds account member" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "4536bcfad5faccb111b47003c79917fa",
          "code": "05dd05cce12bbed97c0d87cd78e89bc2fd41a6cee72f27f6fc84af2e45c0fac0",
          "user": {
            "id": "7c5dae5552338874e5053f2534d2767a",
            "first_name": "John",
            "last_name": "Appleseed",
            "email": "user@example.com",
            "two_factor_authentication_enabled": false
          },
          "status": "accepted",
          "roles": [
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
      }
      JSON

      WebMock.stub(
        :post,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/members"
      )
        .with(body: %({"email":"a@b.c","roles":["d4e5f6"]}))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.account_members.create(
        "a1b2c3",
        email: "a@b.c",
        roles: ["d4e5f6"]
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountMember)
      end
    end
  end

  describe "#replace" do
    it "updates account member" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "4536bcfad5faccb111b47003c79917fa",
          "code": "05dd05cce12bbed97c0d87cd78e89bc2fd41a6cee72f27f6fc84af2e45c0fac0",
          "user": {
            "id": "7c5dae5552338874e5053f2534d2767a",
            "first_name": "John",
            "last_name": "Appleseed",
            "email": "user@example.com",
            "two_factor_authentication_enabled": false
          },
          "status": "accepted",
          "roles": [
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
      }
      JSON

      WebMock.stub(
        :put,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/members/d4e5f6"
      )
        .with(body: %({"id":"4536bc","code":"05dd05"}))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.account_members.replace(
        "a1b2c3",
        "d4e5f6",
        id: "4536bc",
        code: "05dd05"
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountMember)
      end
    end
  end

  describe "#destroy" do
    it "removes account member" do
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
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/members/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.account_members.destroy("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountMember)
      end
    end
  end

  describe "#index" do
    it "lists account members" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "4536bcfad5faccb111b47003c79917fa",
            "code": "05dd05cce12bbed97c0d87cd78e89bc2fd41a6cee72f27f6fc84af2e45c0fac0",
            "user": {
              "id": "7c5dae5552338874e5053f2534d2767a",
              "first_name": "John",
              "last_name": "Appleseed",
              "email": "user@example.com",
              "two_factor_authentication_enabled": false
            },
            "status": "accepted",
            "roles": [
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
        ]
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/members"
      )
        .with(query: {"per_page" => "20", "direction" => "desc"})
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.account_members.index(
        "a1b2c3",
        per_page: "20",
        direction: "desc"
      ) do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Array(Cryflare::AccountMember))
      end
    end
  end

  describe "#show" do
    it "shows account member" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "4536bcfad5faccb111b47003c79917fa",
          "code": "05dd05cce12bbed97c0d87cd78e89bc2fd41a6cee72f27f6fc84af2e45c0fac0",
          "user": {
            "id": "7c5dae5552338874e5053f2534d2767a",
            "first_name": "John",
            "last_name": "Appleseed",
            "email": "user@example.com",
            "two_factor_authentication_enabled": false
          },
          "status": "accepted",
          "roles": [
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
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/accounts/a1b2c3/members/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.account_members.show("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::AccountMember)
      end
    end
  end
end
