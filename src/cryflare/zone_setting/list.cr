struct Cryflare::ZoneSetting::List
  include Response

  struct Resource
    getter result : Array(ZoneSetting)?
  end
end
