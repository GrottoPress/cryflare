require "../spec_helper"

describe Cryflare::Filter::Endpoint do
  describe "#create" do
    it "creates new filter" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "372e67954025e0ba6aaa6d586b9e0b61",
            "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
            "paused": false,
            "description": "Restrict access from these browsers",
            "ref": "FIL-100"
          }
        ]
      }
      JSON

      WebMock.stub(
        :post,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/filters"
      )
        .with(body: %([{"expression":"ip.addr eq 1.2.3.4"}]))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.filters.create(
        "a1b2c3",
        [{expression: "ip.addr eq 1.2.3.4"}]
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::Filter))
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
            "id": "372e67954025e0ba6aaa6d586b9e0b61",
            "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
            "paused": false,
            "description": "Restrict access from these browsers.",
            "ref": "FIL-100"
          }
        ]
      }
      JSON

      WebMock.stub(
        :put,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/filters"
      )
        .with(body: %([{"id":"d4e5f6"}]))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.filters.replace("a1b2c3", [{id: "d4e5f6"}]) do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::Filter))
      end
    end

    it "updates single filter" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b61",
          "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
          "paused": false,
          "description": "Restrict access from these browsers.",
          "ref": "FIL-100"
        }
      }
      JSON

      WebMock.stub(
        :put,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/filters/d4e5f6"
      )
        .with(body: %({"id":"d4e5f6"}))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.filters.replace("a1b2c3", "d4e5f6", id: "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Filter)
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
          "id": "372e67954025e0ba6aaa6d586b9e0b61",
          "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
          "paused": false,
          "description": "Restrict access from these browsers.",
          "ref": "FIL-100"
        }
      }
      JSON

      WebMock.stub(
        :delete,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/filters/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.filters.destroy("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Filter)
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
            "id": "372e67954025e0ba6aaa6d586b9e0b61",
            "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
            "paused": false,
            "description": "Restrict access from these browsers",
            "ref": "FIL-100"
          }
        ]
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/filters"
      )
        .with(query: {"paused" => "true"})
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.filters.index("a1b2c3", paused: "true") do |response|
        response.success?.should be_true
        response.result.should be_a(Array(Cryflare::Filter))
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
          "id": "372e67954025e0ba6aaa6d586b9e0b61",
          "expression": "http.request.uri.path ~ \\".*wp-login.php\\"",
          "paused": false,
          "description": "Restrict access from these browsers",
          "ref": "FIL-100"
        }
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/filters/d4e5f6"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.filters.show("a1b2c3", "d4e5f6") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::Filter)
      end
    end
  end
end
