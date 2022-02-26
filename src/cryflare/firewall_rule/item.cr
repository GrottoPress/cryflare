struct Cryflare::FirewallRule::Item
  include Response

  struct Resource
    getter result : FirewallRule?
  end
end
