struct Cryflare::Zone::Plan
  include Hapi::Resource

  # CF returns empty string for free plans, which results in this error:
  # `Unknown enum Cryflare::Zone::Plan::Frequency value:  (ArgumentError)`
  #
  # The empty string cannot be parsed from this enum, hence the error.
  # For now, we are using `String` type instead of this enum.
  enum Frequency
    Weekly
    Monthly
    Quarterly
    Yearly
  end

  enum LegacyId
    Free
    Pro
    Business
    Enterprise
  end

  getter? can_subscribe : Bool
  getter currency : String
  getter frequency : String
  getter id : String
  getter? is_subscribed : Bool
  getter legacy_id : LegacyId
  getter name : String
  getter price : Int32
end
