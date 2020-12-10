require "spec"
require "webmock"
require "../src/cryflare"

Spec.before_each do
  WebMock.reset
end
