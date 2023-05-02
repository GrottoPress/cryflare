struct Cryflare::AccountMember
  include Cryflare::Resource

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
