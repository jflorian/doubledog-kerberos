# modules/kerberos/manifests/init.pp
#
# == Class: kerberos
#
# Manages kerberos on a host.
#
# === Parameters
#
# [*content*]
#   Literal content for the krb5.conf file.  One and only one of "content" or
#   "source" must be given.
#
# [*source*]
#   URI of the krb5.conf file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <john.florian@dart.biz>


class kerberos (
        $content=undef,
        $source=undef,
    ) {

    include 'kerberos::params'

    package { $kerberos::params::common_packages:
        ensure => installed,
    }

    file { '/etc/krb5.conf':
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'krb5_conf_t',
        subscribe => Package[$kerberos::params::common_packages],
        content   => $content,
        source    => $source,
    }

}
