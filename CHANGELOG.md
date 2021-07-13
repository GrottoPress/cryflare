# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased] - 

### Changed
- Forward missing `Cryflare` methods to *Crystal*'s `HTTP::Client`
- Replace references to `HTTP::Params` with `URI::Params`. [[Ref]](https://github.com/crystal-lang/crystal/pull/10098)
- Integrate with [*Hapi*](https://github.com/GrottoPress/hapi)

## [0.3.0] - 2021-06-12

### Changed
- Convert endpoint `class`es to `struct`s

## [0.2.0] - 2021-04-07

### Changed
- Bump minimum required *Crystal* version to v1.0
- Rename `Cryflare::Client` to just `Cryflare`

## [0.1.0] - 2020-12-16

### Added
- Add `Cryflare::Client`
- Add *Accounts* endpoint
- Add *Account Roles* endpoint
- Add *Account Members* endpoint
- Add *User* endpoint
- Add *User Organizations* endpoint
- Add *Zones* endpoint
- Add *Zone Settings* endpoint
- Add *DNS Records* endpoint
- Add *Cloudflare IPs* endpoint
- Add *User-level Firewall Access Rule* endpoint
- Add *Account-level Firewall Access Rule* endpoint
- Add *Firewall Access Rule for a Zone* endpoint
- Add *Filters* endpoint
- Add *Firewall Rules* endpoint
