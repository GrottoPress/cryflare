require "../spec_helper"

describe Cryflare::User::Endpoint do
  describe "#update" do
    it "updates user" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "7c5dae5552338874e5053f2534d2767a",
          "email": "user@example.com",
          "first_name": "John",
          "last_name": "Appleseed",
          "username": "cfuser12345",
          "telephone": "+1 123-123-1234",
          "country": "US",
          "zipcode": "12345",
          "created_on": "2014-01-01T05:20:00Z",
          "modified_on": "2014-01-01T05:20:00Z",
          "two_factor_authentication_enabled": false,
          "suspended": false,
          "organizations": []
        }
      }
      JSON

      WebMock.stub(:patch, "https://api.cloudflare.com/client/v4/user")
        .with(body: %({"first_name":"John"}))
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.user.update(first_name: "John") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::User)
      end
    end
  end

  describe "#show" do
    it "shows user" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "7c5dae5552338874e5053f2534d2767a",
          "email": "user@example.com",
          "first_name": "John",
          "last_name": "Appleseed",
          "username": "cfuser12345",
          "telephone": "+1 123-123-1234",
          "country": "US",
          "zipcode": "12345",
          "created_on": "2014-01-01T05:20:00Z",
          "modified_on": "2014-01-01T05:20:00Z",
          "two_factor_authentication_enabled": false,
          "suspended": false,
          "organizations": []
        }
      }
      JSON

      WebMock.stub(:get, "https://api.cloudflare.com/client/v4/user")
        .to_return(body_io: response_json)

      client = Cryflare::Client.new(email: "user@website.com", key: "abcdef")

      client.user.show do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::User)
      end
    end
  end
end
