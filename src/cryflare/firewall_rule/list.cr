struct Cryflare::FirewallRule::List
  include Response

  struct Resource
    getter result : Array(FirewallRule)?
  end
end
