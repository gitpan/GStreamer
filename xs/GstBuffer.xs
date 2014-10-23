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
 * $Id: GstBuffer.xs,v 1.2 2005/03/28 22:52:07 kaffeetisch Exp $
 */

#include "gst2perl.h"

MODULE = GStreamer::Buffer	PACKAGE = GStreamer::Buffer	PREFIX = gst_buffer_

BOOT:
        gperl_set_isa("GStreamer::Buffer", "GStreamer::Data");

# --------------------------------------------------------------------------- #

guchar *
data (buffer)
	GstBuffer *buffer
    CODE:
	RETVAL = GST_BUFFER_DATA (buffer);
    OUTPUT:
	RETVAL

guint
size (buffer)
	GstBuffer *buffer
    CODE:
	RETVAL = GST_BUFFER_SIZE (buffer);
    OUTPUT:
	RETVAL

gint
maxsize (buffer)
	GstBuffer *buffer
    CODE:
	RETVAL = GST_BUFFER_MAXSIZE (buffer);
    OUTPUT:
	RETVAL

GstClockTime
timestamp (buffer)
	GstBuffer *buffer
    CODE:
	RETVAL = GST_BUFFER_TIMESTAMP (buffer);
    OUTPUT:
	RETVAL

GstClockTime
duration (buffer)
	GstBuffer *buffer
    CODE:
	RETVAL = GST_BUFFER_DURATION (buffer);
    OUTPUT:
	RETVAL

guint64
offset (buffer)
	GstBuffer *buffer
    CODE:
	RETVAL = GST_BUFFER_OFFSET (buffer);
    OUTPUT:
	RETVAL

guint64
offset_end (buffer)
	GstBuffer *buffer
    CODE:
	RETVAL = GST_BUFFER_OFFSET_END (buffer);
    OUTPUT:
	RETVAL

# --------------------------------------------------------------------------- #

# GstBuffer* gst_buffer_new (void);
# GstBuffer* gst_buffer_new_and_alloc (guint size);
GstBuffer_own *
gst_buffer_new (class)
    C_ARGS:
	/* void */

# #define gst_buffer_set_data(buf, data, size)
void
gst_buffer_set_data (buf, data)
	GstBuffer *buf
	SV *data
    PREINIT:
	int length = sv_len (data);
    CODE:
	gst_buffer_set_data (buf,
	                     strndup (SvPV_nolen (data), length),
	                     length);

void gst_buffer_stamp (GstBuffer *dest, const GstBuffer *src);

GstBuffer_own * gst_buffer_create_sub (GstBuffer *parent, guint offset, guint size);

#if GST_CHECK_VERSION (0, 8, 1)

# GstBuffer* gst_buffer_join (GstBuffer *buf1, GstBuffer *buf2);
GstBuffer_own *
gst_buffer_join (buf1, buf2)
	GstBuffer *buf1
	GstBuffer *buf2
    C_ARGS:
	/* gst_buffer_join unrefs the old buffers, but our SVs still point to
	   them, so we need to keep them alive. */
	gst_buffer_ref (buf1), gst_buffer_ref (buf2)

#endif

GstBuffer_own * gst_buffer_merge (GstBuffer *buf1, GstBuffer *buf2);

gboolean gst_buffer_is_span_fast (GstBuffer *buf1, GstBuffer *buf2);

GstBuffer_own * gst_buffer_span (GstBuffer *buf1, guint32 offset, GstBuffer *buf2, guint32 len);
