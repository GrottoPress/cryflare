struct Cryflare::Zone::Owner
  include Cryflare::Resource

  enum Type
    User
    Organization
  end

  getter email : String | Hash(String, String) | Nil
  getter id : String | Hash(String, String) | Nil
  getter name : String?
  getter type : Type
end
