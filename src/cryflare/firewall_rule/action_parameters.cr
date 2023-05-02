struct Cryflare::FirewallRule::ActionParameters
  include Cryflare::Resource

  struct Uri
    include Cryflare::Resource

    struct Values
      include Cryflare::Resource

      getter value : String
    end

    getter path : Values
    getter query : Values
  end

  getter uri : Uri
end
