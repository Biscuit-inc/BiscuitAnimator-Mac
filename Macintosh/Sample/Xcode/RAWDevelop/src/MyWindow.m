/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : MyWindow.m                                                      *
*                                                                             *
*   Description: This is the Sample code to show the usage of EDSDK.          *
*                                                                             *
*                                                                             *
*******************************************************************************
*                                                                             *
*   Written and developed by Camera Design Dept.53                            *
*   Copyright Canon Inc. 2006 All Rights Reserved                             *
*                                                                             *
*******************************************************************************
*   File Update Information:                                                  *
*     DATE      Identify    Comment                                           *
*   -----------------------------------------------------------------------   *
*   06-03-22    F-001        create first version.                            *
*                                                                             *
******************************************************************************/
#import "MyWindow.h"

@implementation MyWindow

/*-----------------------------------------------------------------------------
//  Function:   initWithContentRect
-----------------------------------------------------------------------------*/
- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    NSWindow* wnd = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
	[self setAcceptsMouseMovedEvents:YES];	
		
    return wnd;
}

/*-----------------------------------------------------------------------------
//  Function:   mouseMoved
-----------------------------------------------------------------------------*/
- (void)mouseMoved:(NSEvent*)event
{
	[[self delegate] mouseMoved:event];
}

@end
