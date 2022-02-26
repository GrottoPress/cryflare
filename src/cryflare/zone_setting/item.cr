struct Cryflare::ZoneSetting::Item
  include Response

  struct Resource
    getter result : ZoneSetting?
  end
end
