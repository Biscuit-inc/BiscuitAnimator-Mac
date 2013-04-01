/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : BaseDefinition.h                                                *
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
#import <Cocoa/Cocoa.h>
#import "EDSDK.h"

#define APP_NAME @"RAWDevelop"

#define ALERT_NOT_CORRECT_FILE	@"Input file is not correct!"
#define ALERT_PROPERTY_SET		@"Error occured while setting the property!"
#define ALERT_IMAGE_GET			@"Error occured while getting the image!"


#define SHOW_ALERT(message) (NSRunAlertPanel( APP_NAME, message, @"OK", @"", nil ))
#define EdsDouble_STR(fValue) ((fValue>0)?[NSString stringWithFormat:@"+%2.1f",fValue]:[NSString stringWithFormat:@"%2.1f",fValue])

typedef struct tagSTR_ID_TABLE {
	NSString*	string;
	EdsUInt32	value;
} STR_ID_TABLE;

#define NOTIFY_PROGRESS_CALLBACK @"NotifyProgressCallback"
#define NOTIFY_UPDATE_IMAGEVIEW @"NotifyUpdateImageview"
#define NOTIFY_UPDATE_AFFRAMEVIEW	@"NotifyUpdateAFFrameView"



