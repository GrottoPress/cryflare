module Cryflare::Response
  macro included
    include Cryflare::Resource

    @errors : Array(Error)?
    @messages : Array(String)?

    getter result_info : ResultInfo?
    getter? success : Bool

    def errors : Array(Error)
      @errors || Array(Error).new
    end

    def messages : Array(String)
      @messages || Array(String).new
    end
  end
end
