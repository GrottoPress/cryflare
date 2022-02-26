struct Cryflare::Filter::List
  include Response

  struct Resource
    getter result : Array(Filter)?
  end
end
