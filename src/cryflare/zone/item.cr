struct Cryflare::Zone::Item
  include Response

  struct Resource
    getter result : Zone?
  end
end
