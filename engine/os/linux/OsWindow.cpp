/*
Copyright (c) 2012 Daniele Bartolini, Simone Boscaratto

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

#include "OsWindow.h"
#include "Assert.h"
#include "StringUtils.h"

namespace crown
{

//-----------------------------------------------------------------------------
OsWindow::OsWindow(uint32_t , uint32_t , uint32_t )
	// m_x11_display(NULL),
	// m_x11_window(None),
	// m_x11_parent_window(None),
	// m_x(0),
	// m_y(0),
	// m_width(width),
	// m_height(height),
	// m_resizable(true),
	// m_x11_detectable_autorepeat(false),
	// m_x11_hidden_cursor(None)
{

}

//-----------------------------------------------------------------------------
OsWindow::~OsWindow()
{
}

//-----------------------------------------------------------------------------
void OsWindow::show()
{
	// XMapRaised(m_x11_display, m_x11_window);
}

//-----------------------------------------------------------------------------
void OsWindow::hide()
{
	//XUnmapWindow(m_x11_display, m_x11_window);
}

//-----------------------------------------------------------------------------
void OsWindow::get_size(uint32_t& width, uint32_t& height)
{
	width = m_width;
	height = m_height;
}

//-----------------------------------------------------------------------------
void OsWindow::get_position(uint32_t& x, uint32_t& y)
{
	x = m_x;
	y = m_y;
}

//-----------------------------------------------------------------------------
void OsWindow::resize(uint32_t , uint32_t )
{
	//XResizeWindow(m_x11_display, m_x11_window, width, height);
}

//-----------------------------------------------------------------------------
void OsWindow::move(uint32_t , uint32_t )
{
	//XMoveWindow(m_x11_display, m_x11_window, x, y);
}

//-----------------------------------------------------------------------------
void OsWindow::minimize()
{
	//XIconifyWindow(m_x11_display, m_x11_window, DefaultScreen(m_x11_display));
}

//-----------------------------------------------------------------------------
void OsWindow::restore()
{
	//XMapRaised(m_x11_display, m_x11_window);
}

//-----------------------------------------------------------------------------
bool OsWindow::is_resizable() const
{
	return m_resizable;
}

//-----------------------------------------------------------------------------
void OsWindow::set_resizable(bool )
{
	// XSizeHints hints;
	// hints.flags = PMinSize | PMaxSize;
	// hints.min_width = resizable ? 1 : m_width;
	// hints.min_height = resizable ? 1 : m_height;
	// hints.max_width = resizable ? 65535 : m_width;
	// hints.max_height = resizable ? 65535 : m_height;

	// XSetWMNormalHints(m_x11_display, m_x11_window, &hints);

	// m_resizable = resizable;
}

//-----------------------------------------------------------------------------
void OsWindow::show_cursor(bool )
{
	// if (show)
	// {
	// 	XDefineCursor(m_x11_display, m_x11_window, None);
	// }
	// else
	// {
	// 	XDefineCursor(m_x11_display, m_x11_window, m_x11_hidden_cursor);
	// }
}

//-----------------------------------------------------------------------------
void OsWindow::get_cursor_xy(int32_t& , int32_t& )
{
	// Window unused;
	// int32_t pointer_x, pointer_y, dummy;
	// uint32_t dummy2;

	// XQueryPointer(m_x11_display, m_x11_window, &unused, &unused, &dummy, &dummy, &pointer_x, &pointer_y, &dummy2);

	// x = pointer_x;
	// y = pointer_y;
}

//-----------------------------------------------------------------------------
void OsWindow::set_cursor_xy(int32_t , int32_t )
{
	// XWarpPointer(m_x11_display, None, m_x11_window, 0, 0, m_width, m_height, x, y);

	// XFlush(m_x11_display);
}

//-----------------------------------------------------------------------------
char* OsWindow::title()
{
	// static char title[1024];

	// char* tmp_title;
	// XFetchName(m_x11_display, m_x11_window, &tmp_title);

	// string::strncpy(title, tmp_title, 1024);
	// XFree(tmp_title);

	// return title;
	return NULL;
}

//-----------------------------------------------------------------------------
void OsWindow::set_title(const char* )
{
	// XStoreName(m_x11_display, m_x11_window, title);
}

} // namespace crown