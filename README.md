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


### Classes

#### kerberos class

This class manages the system Kerberos configuration and ensures workstation libraries, PAM modules, etc. are installed.

##### `admin_server` (required)
A string specifying the DNS name of your Kerberos administration server.  E.g., `'kerberos.example.com'`.

##### `kdc` (required)
A string specifying the DNS name of your KDC.  E.g., `'kerberos.example.com'`.

##### `realm` (required)
A string specifying the name of the Kerberos realm.  This is commonly given as all uppercase and otherwise often matches *domain* but that's not strictly necessary.  E.g., `'EXAMPLE.COM'`.

##### `domain`
A string specifying the DNS domain name.  E.g., `'example.com'`.  The default is the value of `$domain` from Facter which should be acceptable in most cases.

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


### Defined types


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

This should be compatible with Puppet 3.x and is being used with Puppet 4.x as well.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.
