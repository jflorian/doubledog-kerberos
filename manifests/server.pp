#
# == Class: kerberos::server
#
# Manages a host as a Kerberos server.
#
# === Parameters
#
# [*kadmin_acl_content*]
#   Literal content for the kadmin ACL file.  One and only one of
#   "kadmin_acl_content" or "kadmin_acl_source" must be given.
#
# [*kadmin_acl_source*]
#   URI of the kadmin ACL file content.  One and only one of
#   "kadmin_acl_content" or "kadmin_acl_source" must be given.
#
# [*kdc_conf_content*]
#   Literal content for the KDC configuration file.  One and only one of
#   "kdc_conf_content" or "kdc_conf_source" must be given.
#
# [*kdc_conf_source*]
#   URI of the KDC configuration file content.  One and only one of
#   "kdc_conf_content" or "kdc_conf_source" must be given.
#
# [*manage_firewall*]
#   If true, open the Kerberos ports on the firewall.  Otherwise the firewall
#   is left unaffected.  Defaults to true.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2012-2018 John Florian


class kerberos::server (
        String[1]               $kadmin_service,
        String[1]               $kdc_service,
        Array[String[1], 1]     $packages,
        $kadmin_acl_content=undef,
        $kadmin_acl_source=undef,
        $kdc_conf_content=undef,
        $kdc_conf_source=undef,
        $manage_firewall=true,
    ) {

    include '::kerberos'

    package { $packages:
        ensure  => installed,
        require => Class['::kerberos'],
    }

    file {
        default:
            owner   => 'root',
            group   => 'root',
            mode    => '0600',
            require => Package['krb5-server'],
            seluser => 'system_u',
            selrole => 'object_r',
            seltype => 'krb5kdc_conf_t',
            subscribe   => Package[$packages],
            ;
        '/var/kerberos/krb5kdc/kadm5.acl':
            content => $kadmin_acl_content,
            source  => $kadmin_acl_source,
            ;
        '/var/kerberos/krb5kdc/kdc.conf':
            content => $kdc_conf_content,
            source  => $kdc_conf_source,
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
