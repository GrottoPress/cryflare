struct Cryflare::Account
  include JSON::Serializable

  getter id : String
  getter name : String
  getter settings : Settings?
  getter created_on : Time?
end
