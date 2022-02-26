struct Cryflare::UserOrganization::List
  include Response

  struct Resource
    getter result : Array(UserOrganization)?
  end
end
