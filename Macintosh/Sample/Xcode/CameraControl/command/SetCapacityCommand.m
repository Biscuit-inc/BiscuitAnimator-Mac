/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : SetCapacityCommand.m                                            *
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

#import "SetCapacityCommand.h"

@implementation SetCapacityCommand

-(id)init:(CameraModel *)model withCapacity:(EdsCapacity)capacity
{
	[super initWithCameraModel:model];
	
	_capacity = capacity;
	return self;
}

-(BOOL)execute
{
	EdsError error = EDS_ERR_OK;
	BOOL lock;
	CameraEvent * event;
	NSNumber * number;

	// For cameras earlier than the 30D , the UI must be locked before commands are reissued
	if(error = EDS_ERR_OK)
	{
		error = EdsSendStatusCommand([_model camera], kEdsCameraStatusCommand_UILock, 0);
		if(error == EDS_ERR_OK)
		{
			lock = YES;
		}
	}
	
	//Acquisition of the number of sheets that can be taken a picture
	error = EdsSetCapacity([_model camera], _capacity);
		
	//It releases it when locked
	if(lock)
	{
		EdsSendStatusCommand([_model camera], kEdsCameraStatusCommand_UIUnLock, 0);
	}
	
	//Notification of error
	if(error != EDS_ERR_OK)
	{
		number = [[NSNumber alloc] initWithInt: error];
		event = [[CameraEvent alloc] init:@"error" withArg:number];
		[_model notifyObservers:event];	
		[event release];
		[number release];
	}

	return YES;
}

@end
