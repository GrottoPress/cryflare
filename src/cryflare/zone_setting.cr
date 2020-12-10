struct Cryflare::ZoneSetting
  include JSON::Serializable

  getter? editable : Bool
  getter id : String
  getter modified_on : Time
  getter value : JSON::Any
end
