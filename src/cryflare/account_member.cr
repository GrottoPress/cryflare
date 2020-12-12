struct Cryflare::AccountMember
  include JSON::Serializable

  enum Status
    Accepted
    Pending
    Rejected
  end

  getter code : String?
  getter id : String
  getter roles : Array(AccountRole)?
  getter status : Status?
  getter user : User?
end
