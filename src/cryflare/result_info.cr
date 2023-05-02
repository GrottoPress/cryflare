struct Cryflare::ResultInfo
  include Cryflare::Resource

  getter page : Int32
  getter per_page : Int32
  getter count : Int32
  getter total_count : Int32
end
