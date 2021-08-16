<!--
This file is part of the doubledog-kerberos Puppet module.
Copyright 2018-2021 John Florian
SPDX-License-Identifier: GPL-3.0-or-later
-->

# kerberos

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with kerberos](#setup)
    * [What kerberos affects](#what-kerberos-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with kerberos](#beginning-with-kerberos)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module lets you manage Kerberos.

## Setup

### What kerberos Affects

### Setup Requirements

### Beginning with kerberos

## Usage

## Reference

**Classes:**

* [kerberos](#kerberos-class)
* [kerberos::server](#kerberosserver-class)

**Defined types:**

* [kerberos::client\_realm](#kerberosclientrealm-defined-type)


### Classes

#### kerberos class

This class manages the system Kerberos configuration and ensures workstation libraries, PAM modules, etc. are installed.

##### `default_realm` (required)
A string specifying the name of the default Kerberos realm, which should be of those defined by [kerberos::client\_realm](#kerberosclientrealm-defined-type).

##### `client_realms`
A hash whose keys are configuration resource names and whose values are hashes comprising the same parameters you would otherwise pass to the [kerberos::client\_realm](#kerberosclientrealm-defined-type) defined type.  The default is none.

##### `packages`
An array of package names needed for the Kerberos installation.  The default should be correct for supported platforms.


#### kerberos::server class

This class manages a host as Kerberos server.  This class does not create the database.  See `kdb5_util(8)` for help with that or consult documentation such as the [Fedora Security Guide](http://docs.fedoraproject.org/en-US/Fedora/html/Security_Guide/sect-Security_Guide-Kerberos-Configuring_a_Kerberos_5_Server.html) for further details.

##### `packages`
An array of package names needed for the Kerberos server installation.  The default should be correct for supported platforms.

##### `kadmin_service`
The service name of the kadmin daemon.  The default should be correct for supported platforms.

##### `kdc_service`
The service name of the KDC daemon.  The default should be correct for supported platforms.

##### `manage_firewall`
If `true`, open the Kerberos ports on the firewall.  Otherwise the firewall is left unaffected.  Defaults to `true`.

##### `supported_enctypes`
An array of [encryption types](https://web.mit.edu/kerberos/www/krb5-latest/doc/admin/conf_files/kdc_conf.html#encryption-types) to be supported.  The default is to use those compiled into the krb5-server package.


### Defined types

#### kerberos::client\_realm defined type

This defined type manages the configuration of a realm on a Kerberos client host.

##### `namevar` (required)
A string specifying the name of the Kerberos realm.  This is commonly given as all uppercase and otherwise often matches *domain* but that's not strictly necessary.  E.g., `'EXAMPLE.COM'`.

##### `admin_server` (required)
A string specifying the DNS name of your Kerberos administration server.  E.g., `'kerberos.example.com'`.

##### `kdc` (required)
A string specifying the DNS name of your KDC.  E.g., `'kerberos.example.com'`.

##### `dns_lookup_kdc`
A boolean specifying whether DNS SRV records should be used to locate the KDCs and other servers for a realm, if they are not listed in the `krb5.conf` information for the realm..  Defaults to `false`.

##### `dns_lookup_realm`
A boolean specifying whether the library looks for DNS records for fallback host-to-realm mappings and the default realm.  Defaults to `false`.

##### `domain`
A string specifying the DNS domain name.  E.g., `'example.com'`.  Defaults to the host's DNS domain.

##### `ensure`
Instance is to be `'present'` (default) or `'absent'`.

##### `filename`
Name to be given to the realm configuration file, without any path details.  The default is derived from *namevar* which is best in most cases.

##### `forwardable`
A boolean specifying whether initial tickets will be forwardable by default, if allowed by the KDC.  Defaults to `true`.

##### `rdns`
A boolean specifying whether reverse name lookup will be used in addition to forward name lookup to canonicalizing hostnames for use in service principal names..  Defaults to `false`.

##### `renew_lifetime`
A string specifying the default renewable lifetime for initial ticket requests.  Defaults to `7d`.

##### `ticket_lifetime`
A string specifying the default lifetime for initial ticket requests.  Defaults to `24h`.

## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

This should be compatible with Puppet 3.x and is being used with Puppet 4.x as well.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.
