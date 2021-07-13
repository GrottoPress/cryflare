struct Cryflare::Error
  include Hapi::Resource

  getter code : Int32
  getter message : String
end
