module Cryflare::Response
  macro included
    include Cryflare::Resource

    getter errors : Array(Error)
    getter messages : Array(String)
    getter result_info : ResultInfo?
    getter? success : Bool
  end
end
