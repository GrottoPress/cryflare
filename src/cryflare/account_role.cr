struct Cryflare::AccountRole
  include Hapi::Resource

  getter id : String
  getter name : String
  getter description : String
  getter permissions : Permissions
end
