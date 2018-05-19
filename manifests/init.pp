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
# Copyright 2012-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class kerberos (
        Array[String[1], 1]     $packages,
        String[1]               $default_realm,
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

}
