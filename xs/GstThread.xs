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
 * $Id: GstThread.xs,v 1.1 2005/03/23 20:47:20 kaffeetisch Exp $
 */

#include "gst2perl.h"

MODULE = GStreamer::Thread	PACKAGE = GStreamer::Thread	PREFIX = gst_thread_

# GstElement* gst_thread_new (const gchar *name);
GstElement_noinc *
gst_thread_new (class, name)
	const gchar *name
    C_ARGS:
	name

# FIXME: Need GThreadPriority typemap.
# void gst_thread_set_priority (GstThread *thread, GThreadPriority priority);

# GstThread * gst_thread_get_current (void);
GstThread *
gst_thread_get_current (class)
    C_ARGS:
	/* void */
