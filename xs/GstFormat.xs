/*
 * Copyright (C) 2005 by the gtk2-perl team
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * $Id: GstFormat.xs,v 1.3 2005/12/03 00:28:13 kaffeetisch Exp $
 */

#include "gst2perl.h"

/* ------------------------------------------------------------------------- */

SV *
newSVGstFormat (GstFormat format)
{
	SV *sv = gperl_convert_back_enum_pass_unknown (GST_TYPE_FORMAT, format);

	if (looks_like_number (sv)) {
		const GstFormatDefinition *details;
		details = gst_format_get_details (format);
		if (details)
			sv_setpv (sv, details->nick);
	}
	return sv;
}

GstFormat
SvGstFormat (SV *sv)
{
	GstFormat format;

	if (gperl_try_convert_enum (GST_TYPE_FORMAT, sv, (gint *) &format))
		return format;

	return gst_format_get_by_nick (SvPV_nolen (sv));
}

/* ------------------------------------------------------------------------- */

MODULE = GStreamer::Format	PACKAGE = GStreamer::Format	PREFIX = gst_format_

=for apidoc __function__
=cut
# GstFormat gst_format_register (const gchar *nick, const gchar *description);
GstFormat
gst_format_register (nick, description)
	const gchar *nick
	const gchar *description

=for apidoc __function__
=cut
# GstFormat gst_format_get_by_nick (const gchar *nick);
GstFormat
gst_format_get_by_nick (nick)
	const gchar *nick

# FIXME?
# gboolean gst_formats_contains (const GstFormat *formats, GstFormat format);

=for apidoc __function__
=cut
# G_CONST_RETURN GstFormatDefinition* gst_format_get_details (GstFormat format);
void
gst_format_get_details (format)
	GstFormat format
    PREINIT:
	const GstFormatDefinition *details;
    PPCODE:
	details = gst_format_get_details (format);
	if (details) {
		EXTEND (sp, 3);
		PUSHs (sv_2mortal (newSVGstFormat (details->value)));
		PUSHs (sv_2mortal (newSVGChar (details->nick)));
		PUSHs (sv_2mortal (newSVGChar (details->description)));
	}

# FIXME
# GstIterator * gst_format_iterate_definitions (void);