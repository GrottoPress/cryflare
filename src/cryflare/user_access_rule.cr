struct Cryflare::UserAccessRule
  include AccessRule::Common

  struct Scope
    include Hapi::Resource

    enum Type
      User
    end

    getter id : String
    getter email : String
    getter type : Type
  end
end
