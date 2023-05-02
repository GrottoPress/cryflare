struct Cryflare::DnsRecord
  include Cryflare::Resource

  enum Type
    A
    AAAA
    CERT
    CNAME
    DNSKEY
    DS
    LOC
    MX
    NAPTR
    NS
    SMIMEA
    SPF
    SRV
    SSHFP
    TLSA
    TXT
    URI
  end

  getter content : String?
  getter created_on : Time?
  getter data : JSON::Any?
  getter id : String
  getter? locked : Bool?
  getter meta : Meta?
  getter modified_on : Time?
  getter name : String?
  getter priority : Int32?
  getter? proxiable : Bool?
  getter? proxied : Bool?
  getter ttl : Int32?
  getter type : Type?
  getter zone_id : String?
  getter zone_name : String?
end
