# modules/kerberos/manifests/params.pp
#
# == Class: kerberos::params
#
# Parameters for the kerberos puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class kerberos::params {

    case $::operatingsystem {

        'CentOS', 'Fedora': {

            $common_packages = [
                'krb5-libs',
                'krb5-workstation',
                'pam_krb5',
            ]

            $server_packages = [
                'krb5-server',
            ]

            $kadmin_service = 'kadmin'
            $kdc_service = 'krb5kdc'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}