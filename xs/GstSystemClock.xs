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
 * $Id: GstSystemClock.xs,v 1.1 2005/12/03 00:28:13 kaffeetisch Exp $
 */

#include "gst2perl.h"

MODULE = GStreamer::SystemClock	PACKAGE = GStreamer::SystemClock	PREFIX = gst_system_clock_

BOOT:
	gperl_object_set_no_warn_unreg_subclass (GST_TYPE_SYSTEM_CLOCK, TRUE);

# GstClock * gst_system_clock_obtain (void);
GstClock * gst_system_clock_obtain (class)
    C_ARGS:
	/* void */