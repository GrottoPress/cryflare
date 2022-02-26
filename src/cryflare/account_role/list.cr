struct Cryflare::AccountRole::List
  include Response

  struct Resource
    getter result : Array(AccountRole)?
  end
end
