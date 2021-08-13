<!--
This file is part of the doubledog-kerberos Puppet module.
Copyright 2018-2021 John Florian
SPDX-License-Identifier: GPL-3.0-or-later

Template

## [VERSION] WIP
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

-->

# Change log

All notable changes to this project (since v2.0.0) will be documented in this file.  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [2.4.0] WIP
### Added
- many new parameters for client realms
    - defaults are from `krb5-libs-1.18.2-13.el8.x86_64`
- `kerberos::client_realms` parameter to allow all values to be set via Hiera
### Changed
- `krb5.conf` now sets `pkinit_anchors` and `spake_preauth_groups`
    - per defaults from `krb5-libs-1.18.2-13.el8.x86_64`
### Deprecated
### Removed
### Fixed
### Security

## [2.3.0] 2021-08-12
### Added
- Fedora 33-34 support
### Changed
- supported encryption types to match defaults of CentOS 8 Stream
### Removed
- Fedora 30-31 support

## [2.2.1] 2020-07-28
### Added
- Fedora 32 support
### Removed
- deployment/management of `pam_krb5`
- Fedora 29 support
### Fixed
- `pam_krb5` not available in Fedora 32

## [2.2.0] 2020-01-02
### Added
- Fedora 31 support
- CentOS 8 support
### Changed
- dependency on `puppetlabs/firewall` now allows version 2
### Removed
- Fedora 28 support

## [2.1.0] 2019-06-06
### Added
- dependency on `doubledog-ddolib` module
- Fedora 29-30 support
### Changed
- refactored to no longer use absolute namespace references
- refactored to use structured Puppet facts instead of legacy ones
### Removed
- Fedora 26-27 support
### Fixed
- `kerberos::client_realm::ensure` parameter:
    - not honored
    - must not accept Boolean values

## [2.0.0 and prior] 2018-12-15

This and prior releases predate this project's keeping of a formal CHANGELOG.  If you are truly curious, see the Git history.
