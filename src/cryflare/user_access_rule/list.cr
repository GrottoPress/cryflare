struct Cryflare::UserAccessRule::List
  include Response

  struct Resource
    getter result : Array(UserAccessRule)?
  end
end
