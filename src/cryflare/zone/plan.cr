struct Cryflare::Zone::Plan
  include Hapi::Resource

  enum Frequency
    None
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

  @frequency : String

  getter? can_subscribe : Bool
  getter currency : String
  getter id : String
  getter? is_subscribed : Bool
  getter legacy_id : LegacyId
  getter name : String
  getter price : Int32

  def frequency : Frequency
    return Frequency::None if @frequency.empty?
    Frequency.parse(@frequency)
  end
end
