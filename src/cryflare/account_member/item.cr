struct Cryflare::AccountMember::Item
  include Response

  struct Resource
    getter result : AccountMember?
  end
end
