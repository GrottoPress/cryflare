require "../spec_helper"

describe Cryflare::UserOrganization::Endpoint do
  describe "#destroy" do
    it "removes user from organization" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "01a7362d577a6c3019a474fd6f485823"
        }
      }
      JSON

      WebMock.stub(
        :delete,
        "https://api.cloudflare.com/client/v4/user/organizations/a1b2c3"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.user_organizations.delete("a1b2c3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::UserOrganization)
      end
    end
  end

  describe "#index" do
    it "lists user organizations" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "01a7362d577a6c3019a474fd6f485823",
            "name": "Cloudflare, Inc.",
            "status": "member",
            "permissions": [
              "#zones:read"
            ],
            "roles": [
              "All Privileges - Super Administrator"
            ]
          }
        ]
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/user/organizations"
      )
        .with(query: {"status" => "member", "name" => "GrottoPress"})
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.user_organizations.index(
        name: "GrottoPress",
        status: "member"
      ) do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Array(Cryflare::UserOrganization))
      end
    end
  end

  describe "#show" do
    it "shows user organization" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "01a7362d577a6c3019a474fd6f485823",
          "name": "Cloudflare, Inc.",
          "status": "member",
          "permissions": [
            "#zones:read"
          ],
          "roles": [
            "All Privileges - Super Administrator"
          ]
        }
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/user/organizations/a1b2c3"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.user_organizations.show("a1b2c3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::UserOrganization)
      end
    end
  end
end
