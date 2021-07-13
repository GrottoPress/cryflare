module Cryflare::AccessRule
  module Common
    macro included
      include Hapi::Resource

      getter allowed_modes : Array(AccessRule::Mode)?
      getter configuration : AccessRule::Configuration?
      getter created_on : Time?
      getter id : String
      getter mode : AccessRule::Mode?
      getter modified_on : Time?
      getter notes : String?
      getter scope : Scope?
    end
  end

  enum Mode
    Block
    Challenge
    Whitelist
    JS_Challenge
  end

  struct Configuration
    include Hapi::Resource

    enum Target
      IP
      IP6
      IP_Range
      ASN
      Country
    end

    getter target : Target
    getter value : String
  end
end
