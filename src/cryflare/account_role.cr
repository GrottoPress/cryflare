struct Cryflare::AccountRole
  include JSON::Serializable

  getter id : String
  getter name : String
  getter description : String
  getter permissions : Permissions
end
