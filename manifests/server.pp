#
# == Class: kerberos::server
#
# Manages a host as a Kerberos server.
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


class kerberos::server (
        String[1]                   $kadmin_service,
        String[1]                   $kdc_service,
        Boolean                     $manage_firewall,
        Array[String[1], 1]         $packages,
        Optional[Array[String[1]]]  $supported_enctypes,
    ) {

    include 'kerberos'

    package { $packages:
        ensure  => installed,
        require => Class['kerberos'],
    }

    file {
        default:
            owner     => 'root',
            group     => 'root',
            mode      => '0600',
            require   => Package['krb5-server'],
            seluser   => 'system_u',
            selrole   => 'object_r',
            seltype   => 'krb5kdc_conf_t',
            subscribe => Package[$packages],
            ;
        '/var/kerberos/krb5kdc/kadm5.acl':
            content => template('kerberos/kadm5.acl.erb'),
            ;
        '/var/kerberos/krb5kdc/kdc.conf':
            content => template('kerberos/kdc.conf.erb'),
            ;
    }

    if $manage_firewall {
        firewall {
            '550 accept Kerberos packets':
                dport  => ['88', '464', '749'],
                proto  => 'tcp',
                state  => 'NEW',
                action => 'accept';
            '551 accept Kerberos packets':
                dport  => ['88', '750'],
                proto  => 'udp',
                state  => 'NEW',
                action => 'accept';
        }
    }

    service {
        default:
            ensure     => running,
            enable     => true,
            hasrestart => true,
            hasstatus  => true,
            ;
        $kadmin_service:
            subscribe  => [
                File['/var/kerberos/krb5kdc/kadm5.acl'],
                Package[$packages],
            ],
            ;
        $kdc_service:
            subscribe  => [
                File['/var/kerberos/krb5kdc/kdc.conf'],
                Package[$packages],
            ],
            ;
    }

}
