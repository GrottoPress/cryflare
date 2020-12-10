struct Cryflare::Account
  include JSON::Serializable

  getter id : String
  getter name : String
  getter settings : Setting?
  getter created_on : Time?
end
