require "../spec_helper"

describe Cryflare::DnsRecord::Endpoint do
  describe "#create" do
    it "creates new DNS record" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b59",
          "type": "A",
          "name": "example.com",
          "content": "198.51.100.4",
          "proxiable": true,
          "proxied": false,
          "ttl": 120,
          "locked": false,
          "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
          "zone_name": "example.com",
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "data": {},
          "meta": {
            "auto_added": true,
            "source": "primary"
          }
        }
      }
      JSON

      WebMock.stub(
        :post,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/dns_records"
      )
        .with(body: %({"type":"A","name":"example.com","content":"127.0.0.1","ttl":120}))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.dns_records.create(
        "a1b2c3",
        type: "A",
        name: "example.com",
        content: "127.0.0.1",
        ttl: 120
      ) do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Cryflare::DnsRecord)
      end
    end
  end

  describe "#update" do
    it "updates existing dns record" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b59",
          "type": "A",
          "name": "example.com",
          "content": "198.51.100.4",
          "proxiable": true,
          "proxied": false,
          "ttl": 120,
          "locked": false,
          "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
          "zone_name": "example.com",
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "data": {},
          "meta": {
            "auto_added": true,
            "source": "primary"
          }
        }
      }
      JSON

      WebMock.stub(
        :patch,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/dns_records/d1e2f3"
      )
        .with(body: %({"type":"A","name":"example.com"}))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.dns_records.update(
        "a1b2c3",
        "d1e2f3",
        type: "A",
        name: "example.com"
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::DnsRecord)
      end
    end
  end

  describe "#replace" do
    it "replaces existing dns record" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b59",
          "type": "A",
          "name": "example.com",
          "content": "198.51.100.4",
          "proxiable": true,
          "proxied": false,
          "ttl": 120,
          "locked": false,
          "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
          "zone_name": "example.com",
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "data": {},
          "meta": {
            "auto_added": true,
            "source": "primary"
          }
        }
      }
      JSON

      WebMock.stub(
        :put,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/dns_records/d1e2f3"
      )
        .with(body: %({"type":"A","name":"example.com"}))
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.dns_records.replace(
        "a1b2c3",
        "d1e2f3",
        type: "A",
        name: "example.com"
      ) do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::DnsRecord)
      end
    end
  end

  describe "#destroy" do
    it "deletes existing dns record" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b59"
        }
      }
      JSON

      WebMock.stub(
        :delete,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/dns_records/d1e2f3"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.dns_records.delete("a1b2c3", "d1e2f3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::DnsRecord)
      end
    end
  end

  describe "#index" do
    it "lists DNS records" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": [
          {
            "id": "372e67954025e0ba6aaa6d586b9e0b59",
            "type": "A",
            "name": "example.com",
            "content": "198.51.100.4",
            "proxiable": true,
            "proxied": false,
            "ttl": 120,
            "locked": false,
            "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
            "zone_name": "example.com",
            "created_on": "2014-01-01T05:20:00.12345Z",
            "modified_on": "2014-01-01T05:20:00.12345Z",
            "data": {},
            "meta": {
              "auto_added": true,
              "source": "primary"
            }
          }
        ]
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/dns_records"
      )
        .with(query: {"type" => "A", "name" => "example.com"})
        .to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.dns_records.list(
        "a1b2c3",
        type: "A",
        name: "example.com"
      ) do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Array(Cryflare::DnsRecord))
      end
    end
  end

  describe "#show" do
    it "shows dns record" do
      response_json = IO::Memory.new <<-JSON
      {
        "success": true,
        "errors": [],
        "messages": [],
        "result": {
          "id": "372e67954025e0ba6aaa6d586b9e0b59",
          "type": "A",
          "name": "example.com",
          "content": "198.51.100.4",
          "proxiable": true,
          "proxied": false,
          "ttl": 120,
          "locked": false,
          "zone_id": "023e105f4ecef8ad9ca31a8372d0c353",
          "zone_name": "example.com",
          "created_on": "2014-01-01T05:20:00.12345Z",
          "modified_on": "2014-01-01T05:20:00.12345Z",
          "data": {},
          "meta": {
            "auto_added": true,
            "source": "primary"
          }
        }
      }
      JSON

      WebMock.stub(
        :get,
        "https://api.cloudflare.com/client/v4/zones/a1b2c3/dns_records/d1e2f3"
      ).to_return(body_io: response_json)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.dns_records.fetch("a1b2c3", "d1e2f3") do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::DnsRecord)
      end
    end
  end
end
