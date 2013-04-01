#import "MyAFFrameView.h"

@implementation MyAFFrameView

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
	
	EdsUInt32	i;
	for(i = 0; i < m_focusInfo.pointNumber; i++)
	{
		if(m_focusInfo.focusPoint[i].valid==1) 
		{
			if(m_focusInfo.focusPoint[i].justFocus==1)
				[[NSColor redColor] set];
			else
				[[NSColor blackColor] set];
			
			NSRect	rect = NSMakeRect(
				(m_focusInfo.focusPoint[i].rect.point.x),
				(m_focusInfo.focusPoint[i].rect.point.y),
				(m_focusInfo.focusPoint[i].rect.size.width),
				(m_focusInfo.focusPoint[i].rect.size.height));
			NSFrameRect(rect);
		}
	}
}

/*-----------------------------------------------------------------------------
//  Function:   setFocusInfo
-----------------------------------------------------------------------------*/
-(void)setFocusInfo:(EdsFocusInfo)inFocusInfo
{
	m_focusInfo = inFocusInfo;
}

@end
