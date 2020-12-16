struct Cryflare::FirewallRule::ActionParameters
  include JSON::Serializable

  struct Uri
    include JSON::Serializable

    struct Values
      include JSON::Serializable

      getter value : String
    end

    getter path : Values
    getter query : Values
  end

  getter uri : Uri
end
