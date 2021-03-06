#
#
class vmbuilder::distro::ubuntu (
  Vmbuilder::Ubuntu_suites $default_suite,
  String                   $default_flavour,
  Array                    $default_components,
  Optional[Array]          $default_add_pkgs,
  Optional[Array]          $default_remove_pkgs,
) {
  include vmbuilder
  $conf_file = $vmbuilder::conf_file
  $ini_defaults = { 'path' => $conf_file, }
  $_default_add_pkgs = $default_add_pkgs ? {
    undef   => { 'ensure' => 'absent' },
    default => $default_add_pkgs.join(', '),
  }
  $_default_remove_pkgs = $default_remove_pkgs ? {
    undef   => { 'ensure' => 'absent' },
    default => $default_remove_pkgs.join(', '),
  }
  $ini_settings = {
    'ubuntu' => {
      'suite'      => $default_suite,
      'flavour'    => $default_flavour,
      'components' => $default_components.join(', '),
      'addpkg'     => $_default_add_pkgs,
      'removepkg'  => $_default_remove_pkgs,
    },
  }
  create_ini_settings($ini_settings, $ini_defaults)
}
