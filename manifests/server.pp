# modules/kerberos/manifests/server.pp
#
# Synopsis:
#       Configures a host as a Kerberos KDC server.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
# [*manage_firewall*]
#   If true, open the Kerberos ports on the firewall.  Otherwise the firewall
#   is left unaffected.  Defaults to true.
#
# Requires:
#       NONE
#
# Notes:
#       This class does NOT create the database.  See kdb5_util(8) for help
#       with that or consult documentation such as
#       http://docs.fedoraproject.org/en-US/Fedora/html/Security_Guide/sect-Security_Guide-Kerberos-Configuring_a_Kerberos_5_Server.html
#       for further details.
#
# Example usage:
#
#       include 'kerberos'
#       include 'kerberos::server'

class kerberos::server (
        $manage_firewall=true,
    ) {

    include 'kerberos'

    package { 'krb5-server':
        ensure  => installed,
        require => [
            Class['kerberos'],
        ],
    }

    file { '/var/kerberos/krb5kdc/kadm5.acl':
        group   => 'root',
        mode    => '0600',
        owner   => 'root',
        require => Package['krb5-server'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'krb5kdc_conf_t',
        source  => [
            'puppet:///private-host/kerberos/kadm5.acl',
            'puppet:///private-domain/kerberos/kadm5.acl',
            'puppet:///modules/kerberos/kadm5.acl',
        ],
    }

    file { '/var/kerberos/krb5kdc/kdc.conf':
        group   => 'root',
        mode    => '0600',
        owner   => 'root',
        require => Package['krb5-server'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'krb5kdc_conf_t',
        source  => [
            'puppet:///private-host/kerberos/kdc.conf',
            'puppet:///private-domain/kerberos/kdc.conf',
            'puppet:///modules/kerberos/kdc.conf',
        ],
    }

    if $manage_firewall {
        firewall { '550 accept Kerberos packets':
                dport       => ['88', '464', '749'],
                proto       => 'tcp',
                state       => 'NEW',
                action      => 'accept',
        }
    }

    service { 'kadmin':
        enable          => true,
        ensure          => running,
        hasrestart      => true,
        hasstatus       => true,
        require         => [
            Package['krb5-server'],
        ],
        subscribe       => [
            File['/var/kerberos/krb5kdc/kadm5.acl'],
        ],
    }

    service { 'krb5kdc':
        enable          => true,
        ensure          => running,
        hasrestart      => true,
        hasstatus       => true,
        require         => [
            Package['krb5-server'],
        ],
        subscribe       => [
            File['/var/kerberos/krb5kdc/kdc.conf'],
        ],
    }

}
