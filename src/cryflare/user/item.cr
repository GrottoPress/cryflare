struct Cryflare::User::Item
  include Response

  struct Resource
    getter result : User?
  end
end
