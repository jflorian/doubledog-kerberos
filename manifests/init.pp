# modules/kerberos/manifests/init.pp
#
# Synopsis:
#       Configures a host for participation in a Kerberos realm.
#
# Parameters:
#       Name__________  Default_______  Description___________________________
#
#       NONE
#
# Requires:
#       NONE
#
# Example usage:
#
#       include kerberos

class kerberos {

    package { 'krb5-libs':
        ensure  => installed,
    }

    package { 'krb5-workstation':
        ensure  => installed,
    }

    package { 'pam_krb5':
        ensure  => installed,
    }

    file { '/etc/krb5.conf':
        group   => 'root',
        mode    => '0644',
        owner   => 'root',
        require => Package['krb5-libs'],
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'krb5_conf_t',
        source  => [
            'puppet:///private-host/kerberos/krb5.conf',
            'puppet:///private-domain/kerberos/krb5.conf',
            'puppet:///modules/kerberos/krb5.conf',
        ],
    }

}
