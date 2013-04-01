/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : CtrlPanelSheet.h                                                *
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
#import "BaseDefinition.h"

@interface CtrlPanelSheet : NSObject
{
}

+ (int)runSavePanel:(NSString*)inExtension:(NSTextField*)inTargetField;
+ (int)runOpenPanel:(NSArray*)inFileTypes:(NSTextField*)inTargetField;

@end
