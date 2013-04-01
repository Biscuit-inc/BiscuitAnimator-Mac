/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : CameraController.h                                              *
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
#import "cameraModel.h"
#import "ActionEvent.h"
#import "ActionListener.h"
#import "Processor.h"

@interface CameraController : NSObject <ActionListener>{
	// Camera model
	CameraModel * _model;
	
	// Command processing
	Processor * _processor;
}

-(void)actionPerformed:(ActionEvent *)event;
-(void)setCameraModel:(CameraModel *)camera;
-(void)run;

@end
