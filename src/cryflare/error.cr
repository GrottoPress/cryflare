struct Cryflare::Error
  include Cryflare::Resource

  getter code : Int32
  getter message : String
end
