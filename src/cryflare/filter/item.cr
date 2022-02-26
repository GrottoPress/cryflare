struct Cryflare::Filter::Item
  include Response

  struct Resource
    getter result : Filter?
  end
end
