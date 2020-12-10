struct Cryflare::Error
  include JSON::Serializable

  getter code : Int32
  getter message : String
end
