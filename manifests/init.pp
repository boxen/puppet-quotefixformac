# Install the QuoteFix Mail.app plugin.
#
# Usage:
#
#   include quotefixformac
class quotefixformac(
  $version = '2.5.4'
) {
  $zipurl = "https://github.com/robertklep/quotefixformac/releases/download/\
v${version}/QuoteFix-v${version}.zip"
  $bundlesdir = "/Users/${::boxen_user}/Library/Mail/Bundles"
  $zipfile = "/tmp/QuoteFix-${version}.zip"
  $zipdest = "/tmp/QuoteFix-${version}"

  boxen::osx_defaults { 'Enable Mail.app plugin support':
    user   => $::boxen_user,
    domain => 'com.apple.mail',
    key    => 'EnableBundles',
    type   => 'bool',
    value  => true,
  }

  boxen::osx_defaults { 'Set Mail.app Bundle Compatibility Version':
    user   => $::boxen_user,
    domain => 'com.apple.mail',
    key    => 'BundleCompatibilityVersion',
    type   => 'string',
    value  => 3,
  }

  file { $bundlesdir:
    ensure => directory,
  }

  exec {
    'quotefixformac-download':
      command => "/usr/bin/curl -L '${zipurl}' > '${zipfile}'",
      creates => $zipfile;
    'quotefixformac-extract':
      command     => "/usr/bin/unzip -d '${zipdest}' '${zipfile}'",
      cwd         => '/tmp',
      require     => Exec['quotefixformac-download'],
      creates     => $zipdest;
  }

  file { "${bundlesdir}/QuoteFix.mailbundle":
    ensure  => present,
    source  => "${zipdest}/QuoteFix.mailbundle",
    recurse => true,
    require => Exec['quotefixformac-extract'],
    backup  => false,
  }
}
