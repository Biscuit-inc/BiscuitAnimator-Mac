/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : GetPropertyCommand.h                                            *
*                                                                             *
*   Description: This is the Sample code to show the usage of EDSDK.          *
*                                                                             *
*                                                                             *
*******************************************************************************
*                                                                             *
*   Written and developed by Camera Design Dept.53                            *
*   Copyright Canon Inc. 2007-2008 All Rights Reserved                             *
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
#import "cameraCommand.h"
#import "cameraModel.h"

@interface GetPropertyCommand : CameraCommand {
	EdsPropertyID _propertyID;
}

-(id)init:(CameraModel *)camera withProperty:(EdsPropertyID)property;

@end
