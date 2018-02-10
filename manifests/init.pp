#
# == Class: kerberos
#
# Manages Kerberos on a host.
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
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2012-2018 John Florian


class kerberos (
        Array[String[1], 1]     $packages,
        $content=undef,
        $source=undef,
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
        content   => $content,
        source    => $source,
    }

}
