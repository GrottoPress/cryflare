struct Cryflare::UserOrganization::Item
  include Response

  struct Resource
    getter result : UserOrganization?
  end
end
