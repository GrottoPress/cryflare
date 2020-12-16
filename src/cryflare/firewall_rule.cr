struct Cryflare::FirewallRule
  include JSON::Serializable

  enum Action
    Block
    Challenge
    JS_Challenge
    Allow
    Log
    Bypass
    Rewrite
  end

  enum Product
    ZoneLockdown
    UaBlock
    Bic
    Hot
    SecurityLevel
    RateLimit
    Waf
  end

  getter action : Action
  getter action_parameters : ActionParameters
  getter description : String
  getter filter : Filter
  getter id : String
  getter? paused : Bool
  getter priority : Int32
  getter products : Array(Product)
  getter ref : String
end
