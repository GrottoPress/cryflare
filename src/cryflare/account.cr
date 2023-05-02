struct Cryflare::Account
  include Cryflare::Resource

  getter id : String
  getter name : String
  getter settings : Settings?
  getter created_on : Time?
end
