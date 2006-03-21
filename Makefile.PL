#!/usr/bin/perl
use 5.008;
use strict;
use warnings;

use ExtUtils::MakeMaker;
use Cwd qw(cwd);

# $Id: Makefile.PL,v 1.8 2006/03/21 22:34:34 kaffeetisch Exp $

our %build_reqs = (
  'perl-ExtUtils-Depends'   => '0.205',
  'perl-ExtUtils-PkgConfig' => '1.07',
  'perl-Glib'               => '1.120',
  'GStreamer'               => '0.10.0',
);

our %pre_reqs = (
  'Glib'                => $build_reqs{'perl-Glib'},
  'ExtUtils::Depends'   => $build_reqs{'perl-ExtUtils-Depends'},
  'ExtUtils::PkgConfig' => $build_reqs{'perl-ExtUtils-PkgConfig'},
);

unless (eval "use ExtUtils::Depends '$build_reqs{'perl-ExtUtils-Depends'}';"
           . "use ExtUtils::PkgConfig '$build_reqs{'perl-ExtUtils-PkgConfig'}';"
           . "use Glib '$build_reqs{'perl-Glib'}';"
           . "use Glib::MakeHelper;"
           . "use Glib::CodeGen;"
           . "1") {
  warn "$@\n";
  WriteMakefile(
    PREREQ_FATAL => 1,
    PREREQ_PM    => \%pre_reqs,
  );
  exit 1; # not reached
}

my %pkgcfg = ExtUtils::PkgConfig->find("gstreamer-0.10 >= $build_reqs{'GStreamer'}");

mkdir 'build', 0777;

our @xs_files = <xs/*.xs>;
our %pod_files = (
	'GStreamer.pm' => '$(INST_MAN3DIR)/GStreamer.$(MAN3EXT)',
	Glib::MakeHelper->do_pod_files (@xs_files),
);

# --------------------------------------------------------------------------- #

sub gen_object_stuff {
    my ($typemacro, $classname, $root, $package) = @_;

    Glib::CodeGen::add_typemap("$classname *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("const $classname *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("$classname\_ornull *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("const $classname\_ornull *", "T_GPERL_GENERIC_WRAPPER");

    Glib::CodeGen::add_register(<<"EOT");
#ifdef $typemacro
gperl_register_object ($typemacro, "$package");
#endif /* $typemacro */
EOT

    my $get_wrapper = 'gtk2perl_new_gtkobject (GTK_OBJECT (val))';

    Glib::CodeGen::add_header(<<"EOT");
#ifdef $typemacro
  typedef $classname $classname\_ornull;
# define Sv$classname(sv)		(($classname *) gperl_get_object_check (sv, $typemacro))
# define newSV$classname(val)		(gperl_new_object (G_OBJECT (val), TRUE))
# define Sv$classname\_ornull(sv)	(((sv) && SvOK (sv)) ? Sv$classname (sv) : NULL)
# define newSV$classname\_ornull(val)	(((val) == NULL) ? &PL_sv_undef : newSV$classname (val))
#endif /* $typemacro */
EOT
}

sub gen_mini_object_stuff {
    my ($typemacro, $classname, $root, $package) = @_;

    Glib::CodeGen::add_typemap("$classname *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("const $classname *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("$classname\_ornull *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("const $classname\_ornull *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("$classname\_noinc *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("const $classname\_noinc *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("$classname\_noinc_ornull *", "T_GPERL_GENERIC_WRAPPER");
    Glib::CodeGen::add_typemap("const $classname\_noinc_ornull *", "T_GPERL_GENERIC_WRAPPER");

    Glib::CodeGen::add_register(<<"EOT");
#ifdef $typemacro
gst2perl_register_mini_object ($typemacro, "$package");
#endif /* $typemacro */
EOT

    Glib::CodeGen::add_header(<<"EOT");
#ifdef $typemacro
  typedef $classname $classname\_ornull;
  typedef $classname $classname\_noinc;
  typedef $classname $classname\_noinc_ornull;
# define Sv$classname(sv)			(($classname *) gst2perl_mini_object_from_sv (sv))
# define Sv$classname\_ornull(sv)		(((sv) && SvOK (sv)) ? Sv$classname(sv) : NULL)
# define newSV$classname(val)			(gst2perl_sv_from_mini_object (GST_MINI_OBJECT (val), TRUE))
# define newSV$classname\_ornull(val)		(((val) == NULL) ? &PL_sv_undef : newSV$classname(val))
# define newSV$classname\_noinc(val)		(gst2perl_sv_from_mini_object (GST_MINI_OBJECT (val), FALSE))
# define newSV$classname\_noinc_ornull(val)	(((val) == NULL) ? &PL_sv_undef : newSV$classname\_noinc(val))
#endif /* $typemacro */
EOT
}

Glib::CodeGen->add_type_handler (GstObject => \&gen_object_stuff);
Glib::CodeGen->add_type_handler (GstMiniObject => \&gen_mini_object_stuff);

Glib::CodeGen->parse_maps('gst2perl');
Glib::CodeGen->write_boot(ignore => qr/^GStreamer$/);

# --------------------------------------------------------------------------- #

ExtUtils::PkgConfig->write_version_macros (
  "build/gst2perl-version.h",
  "gstreamer-0.10" => "GST",
);

my $gst = ExtUtils::Depends->new('GStreamer', 'Glib');
$gst->set_inc($pkgcfg{cflags} . ' -I./build ');
$gst->set_libs($pkgcfg{libs});
$gst->add_xs(@xs_files);
$gst->add_pm('GStreamer.pm' => '$(INST_LIBDIR)/GStreamer.pm');
$gst->add_typemaps(map {File::Spec->catfile(cwd(), $_)} ('gst.typemap', 'build/gst2perl.typemap'));

$gst->install(qw(gst2perl.h
                 build/gst2perl-autogen.h
                 build/gst2perl-version.h
                 doctypes));
$gst->save_config('build/IFiles.pm');

WriteMakefile(
  NAME          => 'GStreamer',
  VERSION_FROM  => 'GStreamer.pm',
  ABSTRACT_FROM => 'GStreamer.pm',
  PREREQ_PM     => \%pre_reqs,
  XSPROTOARG    => '-noprototypes',
  MAN3PODS      => \%pod_files,
  $gst->get_makefile_vars,
);

sub MY::postamble {
  return Glib::MakeHelper->postamble_clean ()
       . Glib::MakeHelper->postamble_docs_full (
           DEPENDS => $gst,
           DOCTYPES => 'doctypes',
           COPYRIGHT_FROM => 'copyright.pod');
}