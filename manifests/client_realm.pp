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
# Copyright 2018-2021 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define kerberos::client_realm (
        String[1]                       $admin_server,
        String[1]                       $kdc,
        Boolean                         $dns_lookup_kdc=false,
        Boolean                         $dns_lookup_realm=false,
        String[1]                       $domain=$facts['domain'],
        Ddolib::File::Ensure::Limited   $ensure='present',
        String[1]                       $filename="${title}.conf",
        Boolean                         $forwardable=true,
        Boolean                         $rdns=false,
        String                          $renew_lifetime='7d',
        String                          $ticket_lifetime='24h',
    ) {

    include 'kerberos'

    file { "/etc/krb5.conf.d/${filename}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'etc_t',
        content => template('kerberos/client_realm.conf.erb'),
    }

}
