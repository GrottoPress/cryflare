struct Cryflare::Filter
  include Hapi::Resource

  getter description : String
  getter expression : String
  getter id : String
  getter? paused : Bool
  getter ref : String
end
