#
# == Class: kerberos
#
# Manages Kerberos on a host.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-kerberos Puppet module.
# Copyright 2012-2021 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class kerberos (
        Hash[String[1], Hash]   $client_realms,
        String[1]               $default_realm,
        Array[String[1], 1]     $packages,
    ) {

    package { $packages:
        ensure => installed,
    }

    file { '/etc/krb5.conf':
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'krb5_conf_t',
        subscribe => Package[$packages],
        content   => template('kerberos/krb5.conf.erb'),
    }

    create_resources(kerberos::client_realm, $client_realms)

}
