module Cryflare::Endpoint
  macro included
    def initialize(@client : Cryflare)
    end
  end
end
