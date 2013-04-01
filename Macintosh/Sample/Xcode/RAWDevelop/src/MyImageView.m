/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : MyImageView.m                                                   *
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
#import "AppController.h"
#import "MyImageView.h"

@implementation MyImageView

/*-----------------------------------------------------------------------------
//  Function:   initWithFrame
-----------------------------------------------------------------------------*/
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        m_nsImage=nil;
    }
    return self;
}

/*-----------------------------------------------------------------------------
//  Function:   dealloc
-----------------------------------------------------------------------------*/
- (void)dealloc
{
    [m_nsImage release];
    [super dealloc];
}

/*-----------------------------------------------------------------------------
//  Function:   setImage
-----------------------------------------------------------------------------*/
- (void)setImage:(NSImage *)inNewImage
{
    [m_nsImage release];
	m_nsImage = inNewImage;
    [m_nsImage retain];
	[self display];
}

/*-----------------------------------------------------------------------------
//  Function:   drawRect
-----------------------------------------------------------------------------*/
- (void)drawRect:(NSRect)rect
{
	// draw BackGround
	[[NSColor darkGrayColor] set];
	NSRectFill([self bounds]);
	// draw Image
    [m_nsImage compositeToPoint:NSZeroPoint operation:NSCompositeSourceOver];
}

/*-----------------------------------------------------------------------------
//  Function:   mouseDown
-----------------------------------------------------------------------------*/
- (void)mouseDown:(NSEvent*)event
{
	[m_appController onClickImage:self];
}


@end
