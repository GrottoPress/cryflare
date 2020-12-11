struct Cryflare::AccountRole::Permissions
  include JSON::Serializable

  struct Values
    include JSON::Serializable

    getter? read : Bool
    getter? write : Bool
  end

  getter analytics : Values
  getter billing : Values
  getter cache_purge : Values
  getter dns : Values
  getter dns_records : Values
  getter lb : Values
  getter logs : Values
  getter organization : Values
  getter ssl : Values
  getter waf : Values
  getter zones : Values
  getter zone_settings : Values
end
