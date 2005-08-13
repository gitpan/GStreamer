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
 * $Id: GstError.xs,v 1.1 2005/03/23 20:47:16 kaffeetisch Exp $
 */

#include "gst2perl.h"

MODULE = GStreamer::Error	PACKAGE = GStreamer::Error	PREFIX = gst_error_

gchar *
message (error)
	GError *error
    CODE:
	RETVAL = error->message;
    OUTPUT:
	RETVAL