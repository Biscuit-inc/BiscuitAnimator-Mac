/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : SaveSettingCommand.m                                            *
*                                                                             *
*   Description: This is the Sample code to show the usage of EDSDK.          *
*                                                                             *
*                                                                             *
*******************************************************************************
*                                                                             *
*   Written and developed by Camera Design Dept.53                            *
*   Copyright Canon Inc. 2007-2010 All Rights Reserved                        *
*                                                                             *
*******************************************************************************
*   File Update Information:                                                  *
*     DATE      Identify    Comment                                           *
*   -----------------------------------------------------------------------   *
*   06-03-22    F-001        create first version.                            *
*                                                                             *
******************************************************************************/


#import "SaveSettingCommand.h"


@implementation SaveSettingCommand

-(id)init:(CameraModel *)model saveTo:(EdsSaveTo)saveTo
{
	[super initWithCameraModel:model];
	
	_saveTo = saveTo;
	return self;
}

-(BOOL)execute
{
	EdsError error = EDS_ERR_OK;
	BOOL lock;
	CameraEvent * event;
	NSNumber * number;

	// For cameras earlier than the 30D , the UI must be locked before commands are reissued
	if([_model isLegacy])
	{
		error = EdsSendStatusCommand([_model camera], kEdsCameraStatusCommand_UILock, 0);
		if(error == EDS_ERR_OK)
		{
			lock = YES;
		}
	}

	//It sets preserving ahead
	if(error == EDS_ERR_OK)
	{
		error = EdsSetPropertyData([_model camera], kEdsPropID_SaveTo, 0, sizeof(_saveTo), &_saveTo);
	}

	//It releases it when locked
	if(lock)
	{
		EdsSendStatusCommand([_model camera], kEdsCameraStatusCommand_UIUnLock, 0);
	}
	
	//Notification of error
	if(error != EDS_ERR_OK)
	{
		// It retries it at device busy
		if(error == EDS_ERR_DEVICE_BUSY)
		{
			number = [[NSNumber alloc] initWithInt: error];
			event = [[CameraEvent alloc] init:@"DeviceBusy" withArg:number];
			[_model notifyObservers:event];	
			[event release];
			[number release];
			return NO;
		}
		
		number = [[NSNumber alloc] initWithInt: error];
		event = [[CameraEvent alloc] init:@"error" withArg:number];
		[_model notifyObservers:event];	
		[event release];
		[number release];
	}
	
	return YES;
}

@end
