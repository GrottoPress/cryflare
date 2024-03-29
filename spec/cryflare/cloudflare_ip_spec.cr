require "../spec_helper"

describe Cryflare::CloudflareIp::Endpoint do
  describe "#show" do
    it "shows cloudflare ips" do
      body = <<-JSON
        {
          "success": true,
          "errors": [],
          "messages": [],
          "result": {
            "ipv4_cidrs": [
              "199.27.128.0/21"
            ],
            "ipv6_cidrs": [
              "2400:cb00::/32"
            ],
            "etag": "a8e453d9d129a3769407127936edfdb0"
          }
        }
        JSON

      WebMock.stub(:get, "https://api.cloudflare.com/client/v4/ips")
        .to_return(body: body)

      client = Cryflare.new(email: "user@website.com", key: "abcdef")

      client.cloudflare_ips.fetch do |response|
        response.success?.should be_true
        response.result.should be_a(Cryflare::CloudflareIp)
      end
    end
  end
end
