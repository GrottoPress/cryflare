require "../spec_helper"

describe Cryflare::Client do
  it "connects to Cloudflare" do
    WebMock.allow_net_connect = true

    client = Cryflare::Client.new(
      email: ENV["CLOUDFLARE_EMAIL"],
      key: ENV["CLOUDFLARE_KEY"]
    )

    client.zones.index do |response|
      response.success?.should be_true
      response.result.try &.should(be_a Array(Cryflare::Zone))
    end
  end
end
