#
# == Define: kerberos::client_realm
#
# Manages a Kerberos client realm configuratino on a host.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-kerberos Puppet module.
# Copyright 2018-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define kerberos::client_realm (
        String[1]                                   $admin_server,
        String[1]                                   $kdc,
        String[1]                                   $domain=$::domain,
        Variant[Boolean, Enum['present', 'absent']] $ensure='present',
        String[1]                                   $filename="${title}.conf",
    ) {

    include '::kerberos'

    file { "/etc/krb5.conf.d/${filename}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        require => Class['::kerberos'],
        content => template('kerberos/client_realm.conf.erb'),
    }

}
