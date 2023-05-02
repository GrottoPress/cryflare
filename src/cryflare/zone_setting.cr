struct Cryflare::ZoneSetting
  include Cryflare::Resource

  getter? editable : Bool
  getter id : String
  getter modified_on : Time
  getter value : JSON::Any
end
