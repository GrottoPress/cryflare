struct Cryflare::ZoneAccessRule::List
  include Response

  struct Resource
    getter result : Array(ZoneAccessRule)?
  end
end
