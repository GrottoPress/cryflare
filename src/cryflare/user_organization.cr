struct Cryflare::UserOrganization
  include Cryflare::Resource

  enum Status
    Member
    Invited
  end

  getter id : String
  getter name : String?
  getter permissions : Array(String)?
  getter roles : Array(String)?
  getter status : Status?
end
