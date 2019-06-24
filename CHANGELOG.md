<!--
This file is part of the doubledog-kerberos Puppet module.
Copyright 2018-2019 John Florian
SPDX-License-Identifier: GPL-3.0-or-later

Template

## [VERSION] DATE/WIP
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

-->

# Change log

All notable changes to this project (since v2.0.0) will be documented in this file.  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [2.2.0] WIP
### Added
### Changed
- dependency on `puppetlabs/firewall` now allows version 2
### Deprecated
### Removed
### Fixed
### Security

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
