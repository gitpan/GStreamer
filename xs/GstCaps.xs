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
 * $Id: GstCaps.xs,v 1.3 2005/03/28 22:52:07 kaffeetisch Exp $
 */

#include "gst2perl.h"

MODULE = GStreamer::Caps	PACKAGE = GStreamer::Caps	PREFIX = gst_caps_

# GstCaps * gst_caps_new_empty (void);
GstCaps_own *
gst_caps_new_empty (class)
    C_ARGS:
	/* void */

# GstCaps * gst_caps_new_any (void);
GstCaps_own *
gst_caps_new_any (class)
    C_ARGS:
	/* void */

# GstCaps * gst_caps_new_simple (const char *media_type, const char *fieldname, ...);
GstCaps_own *
gst_caps_new_simple (class, media_type, field, type, value, ...)
	const char *media_type
	const char *field
	const char *type
	SV *value
    PREINIT:
	GstStructure *structure;
	int i;
    CODE:
	PERL_UNUSED_VAR (field);
	PERL_UNUSED_VAR (type);
	PERL_UNUSED_VAR (value);

	RETVAL = gst_caps_new_empty ();
	structure = gst_structure_empty_new (media_type);

	for (i = 2; i < items; i += 3) {
		const gchar *field = SvPV_nolen (ST (i));
		GType type = gperl_type_from_package (SvPV_nolen (ST (i + 1)));
		GValue value = { 0, };

		g_value_init (&value, type);
		gperl_value_from_sv (&value, ST (i + 2));
		gst_structure_set_value (structure, field, &value);
		g_value_unset (&value);
	}

	/* RETVAL owns structure. */
	gst_caps_append_structure (RETVAL, structure);
    OUTPUT:
	RETVAL

# GstCaps * gst_caps_new_full (GstStructure  *struct1, ...);
# GstCaps * gst_caps_new_full_valist (GstStructure  *structure, va_list var_args);
GstCaps_own *
gst_caps_new_full (class, structure, ...)
	GstStructure *structure
    PREINIT:
	int i;
    CODE:
	PERL_UNUSED_VAR (structure);
	RETVAL = gst_caps_new_empty ();
	for (i = 1; i < items; i++) {
		/* RETVAL owns the structure. */
		gst_caps_append_structure (RETVAL, SvGstStructure (ST (i)));
	}
    OUTPUT:
	RETVAL

# FIXME
# G_CONST_RETURN GstCaps * gst_static_caps_get (GstStaticCaps *static_caps);

# void gst_caps_append (GstCaps *caps1, GstCaps *caps2);
void
gst_caps_append (caps1, caps2)
	GstCaps *caps1
	GstCaps *caps2
    C_ARGS:
	/* gst_caps_append frees the second caps.  caps1 owns the structures
	   in caps2. */
	caps1, gst_caps_copy (caps2)

# caps owns structure.
# void gst_caps_append_structure (GstCaps *caps, GstStructure  *structure);
void
gst_caps_append_structure (caps, structure);
	GstCaps *caps
	GstStructure *structure

int gst_caps_get_size (const GstCaps *caps);

GstStructure * gst_caps_get_structure (const GstCaps *caps, int index);

# void gst_caps_set_simple (GstCaps *caps, char *field, ...);
# void gst_caps_set_simple_valist (GstCaps *caps, char *field, va_list varargs);
void
gst_caps_set_simple (caps, field, type, value, ...)
	GstCaps *caps
	const char *field
	const char *type
	SV *value
    PREINIT:
	GstStructure *structure;
	int i;
    CODE:
	PERL_UNUSED_VAR (field);
	PERL_UNUSED_VAR (type);
	PERL_UNUSED_VAR (value);

	structure = gst_caps_get_structure (caps, 0);

	for (i = 1; i < items; i += 3) {
		const gchar *field = SvPV_nolen (ST (i));
		GType type = gperl_type_from_package (SvPV_nolen (ST (i + 1)));
		GValue value = { 0, };

		g_value_init (&value, type);
		gperl_value_from_sv (&value, ST (i + 2));
		gst_structure_set_value (structure, field, &value);
		g_value_unset (&value);
	}

gboolean gst_caps_is_any (const GstCaps *caps);

gboolean gst_caps_is_empty (const GstCaps *caps);

gboolean gst_caps_is_fixed (const GstCaps *caps);

gboolean gst_caps_is_always_compatible (const GstCaps *caps1, const GstCaps *caps2);

#if GST_CHECK_VERSION (0, 8, 2)

gboolean gst_caps_is_subset (const GstCaps *subset, const GstCaps *superset);

gboolean gst_caps_is_equal (const GstCaps *caps1, const GstCaps *caps2);

GstCaps_own * gst_caps_subtract (const GstCaps *minuend, const GstCaps *subtrahend);

gboolean gst_caps_do_simplify (GstCaps *caps);

#endif

GstCaps_own * gst_caps_intersect (const GstCaps *caps1, const GstCaps *caps2);

GstCaps_own * gst_caps_union (const GstCaps *caps1, const GstCaps *caps2);

GstCaps_own * gst_caps_normalize (const GstCaps *caps);

# FIXME
# void gst_caps_replace (GstCaps **caps, GstCaps *newcaps);

gchar_own * gst_caps_to_string (const GstCaps *caps);

# =for apidoc __function__
# =cut
# GstCaps * gst_caps_from_string (const gchar *string);
GstCaps_own *
gst_caps_from_string (class, string)
	const gchar *string
    C_ARGS:
	string

# FIXME?
# gboolean gst_caps_structure_fixate_field_nearest_int (GstStructure *structure, const char *field_name, int target);
# gboolean gst_caps_structure_fixate_field_nearest_double (GstStructure *structure, const char *field_name, double target);
