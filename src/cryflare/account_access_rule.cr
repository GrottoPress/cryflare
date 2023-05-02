struct Cryflare::AccountAccessRule
  include AccessRule::Common

  struct Scope
    include Cryflare::Resource

    enum Type
      User
    end

    getter id : String
    getter email : String
    getter type : Type
  end
end
