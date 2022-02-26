struct Cryflare::Zone::List
  include Response

  struct Resource
    getter result : Array(Zone)?
  end
end
