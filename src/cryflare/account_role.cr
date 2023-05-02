struct Cryflare::AccountRole
  include Cryflare::Resource

  getter id : String
  getter name : String
  getter description : String
  getter permissions : Permissions
end
