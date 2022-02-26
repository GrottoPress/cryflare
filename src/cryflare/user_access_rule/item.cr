struct Cryflare::UserAccessRule::Item
  include Response

  struct Resource
    getter result : UserAccessRule?
  end
end
