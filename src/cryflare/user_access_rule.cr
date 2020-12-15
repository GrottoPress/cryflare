struct Cryflare::UserAccessRule
  include AccessRule::Common

  struct Scope
    include JSON::Serializable

    enum Type
      User
    end

    getter id : String
    getter email : String
    getter type : Type
  end
end
