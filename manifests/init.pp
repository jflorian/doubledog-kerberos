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
# Copyright 2012-2018 John Florian


class kerberos (
        String[1]               $admin_server,
        String[1]               $domain,
        String[1]               $kdc,
        Array[String[1], 1]     $packages,
        String[1]               $realm,
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
