require "../spec_helper"

describe Cryflare::Response do
  it "does not require `message` in error responses" do
    body = <<-JSON
      {
        "success": false,
        "errors": [
          {
            "code": 10000,
            "message": "Authentication error"
          }
        ]
      }
      JSON

    WebMock.stub(:post, "https://api.cloudflare.com/client/v4/zones")
      .with(body: %({"name":"example.tld"}))
      .to_return(body: body)

    client = Cryflare.new(token: "abcdef")

    client.zones.create(name: "example.tld") do |response|
      response.success?.should be_false
      response.result.should be_nil
      response.errors.should be_a(Array(Cryflare::Error))
      response.errors.size.should eq(1)
    end
  end
end
