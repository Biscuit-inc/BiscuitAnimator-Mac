/* MyAFFrameView */

#import <Cocoa/Cocoa.h>
#import "EDSDKTypes.h"

@interface MyAFFrameView : NSView
{
    IBOutlet id m_appController;
	NSImage* m_nsImage;
	
	EdsFocusInfo	m_focusInfo;
}

-(void)setFocusInfo:(EdsFocusInfo)inFocusInfo;
@end
