require "../spec_helper"

describe Cryflare::Account::Endpoint do
  describe "#replace" do
    it "updates account" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "01a7362d577a6c3019a474fd6f485823",
            "name": "Demo Account",
            "settings": {
              "enforce_twofactor": false
            },
            "created_on": "2014-03-01T12:21:02.0000Z"
          }
        }
        JSON

      WebMock.stub(:put, "https://api.cloudflare.com/client/v4/accounts/a1b2c3")
        .with(body: %({"id":"a1b2c3","name":"Demo Account"}))
        .to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.accounts.replace(
        "a1b2c3",
        id: "a1b2c3",
        name: "Demo Account"
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Account)
      end
    end
  end

  describe "#index" do
    it "lists accounts" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": [
            {
              "id": "01a7362d577a6c3019a474fd6f485823",
              "name": "Demo Account",
              "settings": {
                "enforce_twofactor": false
              },
              "created_on": "2014-03-01T12:21:02.0000Z"
            }
          ]
        }
        JSON

      WebMock.stub(:get, "https://api.cloudflare.com/client/v4/accounts")
        .with(query: {"page" => "1", "per_page" => "20"})
        .to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.accounts.list(page: "1", per_page: "20") do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Array(Cryflare::Account))
      end
    end
  end

  describe "#show" do
    it "shows account" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "id": "01a7362d577a6c3019a474fd6f485823",
            "name": "Demo Account",
            "settings": {
              "enforce_twofactor": false
            },
            "created_on": "2014-03-01T12:21:02.0000Z"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.cloudflare.com/client/v4/accounts/a1b2c3")
        .to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.accounts.fetch("a1b2c3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Account)
      end
    end
  end
end
