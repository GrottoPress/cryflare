struct Cryflare::Account
  include Hapi::Resource

  getter id : String
  getter name : String
  getter settings : Settings?
  getter created_on : Time?
end
