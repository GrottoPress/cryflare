require "../spec_helper"

describe Cryflare::Client do
  ENV["CLOUDFLARE_TOKEN"]?.try do |token|
    it "connects to Cloudflare" do
      WebMock.allow_net_connect = true

      client = Cryflare::Client.new(token: token)

      client.zones.index do |response|
        response.success?.should be_true
        response.result.try &.should(be_a Array(Cryflare::Zone))
      end
    end
  end
end
