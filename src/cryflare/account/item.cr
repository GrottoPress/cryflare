struct Cryflare::Account::Item
  include Response

  struct Resource
    getter result : Account?
  end
end
