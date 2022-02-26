struct Cryflare::ZoneAccessRule::Item
  include Response

  struct Resource
    getter result : ZoneAccessRule?
  end
end
