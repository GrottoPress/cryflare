struct Cryflare::ZoneAccessRule
  include AccessRule::Common

  struct Scope
    include Cryflare::Resource

    enum Type
      User
      Organization
      Zone
    end

    getter id : String
    getter email : String?
    getter name : String?
    getter type : Type
  end
end
