package GStreamer::Install::Files;

$self = {
          'inc' => '-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -pthread -I/home/torsten/opt/gnome/include/gstreamer-0.8 -I/home/torsten/opt/gnome/include/glib-2.0 -I/home/torsten/opt/gnome/lib/glib-2.0/include -I/home/torsten/opt/gnome/include/libxml2   -I./build ',
          'typemaps' => [
                          'gst.typemap',
                          'gst2perl.typemap'
                        ],
          'deps' => [
                      'Glib'
                    ],
          'libs' => '-Wl,--export-dynamic -pthread -L/home/torsten/opt/gnome/lib -lgstreamer-0.8  '
        };


# this is for backwards compatiblity
@deps = @{ $self->{deps} };
@typemaps = @{ $self->{typemaps} };
$libs = $self->{libs};
$inc = $self->{inc};

	$CORE = undef;
	foreach (@INC) {
		if ( -f $_ . "/GStreamer/Install/Files.pm") {
			$CORE = $_ . "/GStreamer/Install/";
			last;
		}
	}

1;
