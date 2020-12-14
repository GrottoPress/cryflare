struct Cryflare::Account::Settings
  include JSON::Serializable

  getter? enforce_twofactor : Bool
end
