# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [2.0.2] - 2025-06-27

### Fixed
- Give each `Cryflare` instance its own `HTTP::Client` instance

## [2.0.1] - 2025-06-06

### Fixed
- Fix compile error calling `.compare_versions` with `Cryflare::VERSION`

## [2.0.0] - 2025-04-18

### Changed
- Convert `Cryflare` to a `struct`

### Fixed
- Use the same `HTTP::Client` object for all `Cryflare` instances

## [1.0.3] - 2024-08-15

### Fixed
- Add missing `require "http/client"`

## [1.0.2] - 2024-02-28

### Fixed
- Fix `JSON::SerializableError` error while parsing DNS record meta

## [1.0.1] - 2023-09-23

### Fixed
- Fix JSON parse error when responses do not contain a `message` key

## [1.0.0] - 2023-05-30

### Added
- First stable release

## [0.6.0] - 2023-05-02

### Changed
- Remove `GrottoPress/hapi` dependency

## [0.5.1] - 2022-03-17

### Added
- Ensure support for *Crystal* v1.3

### Changed
- Read HTTP responses from `body` instead of `body_io` in endpoint methods

## [0.5.0] - 2022-01-03

### Added
- Add support for *Crystal* v1.2

### Changed
- Rename `#destroy` endpoint methods to `#delete`
- Rename `#index` endpoint methods to `#list`
- Rename `#show` endpoint methods to `#fetch`

## [0.4.0] - 2021-08-17

### Changed
- Replace references to `HTTP::Params` with `URI::Params`. [[Ref]](https://github.com/crystal-lang/crystal/pull/10098)
- Integrate with [*Hapi*](https://github.com/GrottoPress/hapi)
- Return enum (instead of string) for `Cryflare::Zone::Plan#frequency`

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
