struct Cryflare::AccountAccessRule::List
  include Response

  struct Resource
    getter result : Array(AccountAccessRule)?
  end
end
