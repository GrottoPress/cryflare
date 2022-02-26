struct Cryflare::Account::List
  include Response

  struct Resource
    getter result : Array(Account)?
  end
end
