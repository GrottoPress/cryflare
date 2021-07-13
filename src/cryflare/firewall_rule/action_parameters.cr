struct Cryflare::FirewallRule::ActionParameters
  include Hapi::Resource

  struct Uri
    include Hapi::Resource

    struct Values
      include Hapi::Resource

      getter value : String
    end

    getter path : Values
    getter query : Values
  end

  getter uri : Uri
end
