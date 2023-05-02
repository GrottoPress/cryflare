struct Cryflare::Account::Settings
  include Cryflare::Resource

  getter? enforce_twofactor : Bool
end
