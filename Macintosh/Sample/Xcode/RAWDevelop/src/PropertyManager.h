/* PropertyManager */

#import <Cocoa/Cocoa.h>
#import "EDSDK.h"
#import "BaseDefinition.h"

@interface PropertyManager : NSObject
{
    IBOutlet id m_EDSDKController;
}

-(NSString*)getPropertyString:(EdsPropertyID)inPropertyID;
-(NSString*)getImageInfoString:(EdsImageSource)inImageSource;

@end
