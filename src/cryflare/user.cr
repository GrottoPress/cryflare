struct Cryflare::User
  include JSON::Serializable

  getter betas : Array(String)?
  getter created_on : Time
  getter country : String
  getter email : String
  getter first_name : String?
  getter id : String
  getter last_name : String?
  getter modified_on : Time
  getter organizations : Array(UserOrganization)
  getter? suspended : Bool
  getter telephone : String?
  getter? two_factor_authentication_enabled : Bool
  getter username : String
  getter zipcode : String
end
