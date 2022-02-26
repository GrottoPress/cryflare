struct Cryflare::AccountAccessRule::Item
  include Response

  struct Resource
    getter result : AccountAccessRule?
  end
end
