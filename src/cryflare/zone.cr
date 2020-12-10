struct Cryflare::Zone
  include JSON::Serializable

  enum Status
    Active
    Pending
    Initializing
    Moved
    Deleted
    Deactivated
  end

  enum Type
    Full
    Partial
  end

  getter account : Account?
  getter activated_on : Time?
  getter created_on : Time?
  getter development_mode : Int32?
  getter id : String
  getter modified_on : Time?
  getter name : String?
  getter name_servers : Array(String)?
  getter original_dnshost : String?
  getter original_name_servers : Array(String)?
  getter original_registrar : String?
  getter owner : Owner?
  getter? paused : Bool?
  getter permissions : Array(String)?
  getter plan : Plan?
  getter plan_pending : Plan?
  getter status : Status?
  getter type : Type?
end
