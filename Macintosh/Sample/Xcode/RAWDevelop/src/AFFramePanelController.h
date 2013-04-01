/* AFFramePanelController */

#import <Cocoa/Cocoa.h>
#import "BaseDefinition.h"

@interface AFFramePanelController : NSObject
{
    IBOutlet id m_AFFramePanel;
    IBOutlet id m_AFFrameView;
    IBOutlet id m_EDSDKController;

	bool	m_bShow;
}

-(void)setShowAFFrame:(bool)bShow;
-(void)updateAFFrame;
- (void)notifiedUpdateAFFrameView:(NSNotification*)inNotification;

@end
