struct Cryflare::Filter
  include JSON::Serializable

  getter description : String
  getter expression : String
  getter id : String
  getter? paused : Bool
  getter ref : String
end
