struct Cryflare::AccountMember::List
  include Response

  struct Resource
    getter result : Array(AccountMember)?
  end
end
