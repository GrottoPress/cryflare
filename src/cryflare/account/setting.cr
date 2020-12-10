struct Cryflare::Account::Setting
  include JSON::Serializable

  getter? enforce_twofactor : Bool
end
