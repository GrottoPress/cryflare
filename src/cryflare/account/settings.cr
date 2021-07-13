struct Cryflare::Account::Settings
  include Hapi::Resource

  getter? enforce_twofactor : Bool
end
