/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : CtrlPanelSheet.m                                                *
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
#import "CtrlPanelSheet.h"

/******************************************************************************
*******************************************************************************
//
//	Public Utilities
//
*******************************************************************************
******************************************************************************/
@implementation CtrlPanelSheet

/*-----------------------------------------------------------------------------
//  Function:   runSavePanel
-----------------------------------------------------------------------------*/
+ (int)runSavePanel:(NSString*)inExtension:(NSTextField*)inTargetField
{
	NSSavePanel *savePanel = [NSSavePanel savePanel];

	[savePanel setRequiredFileType:inExtension];	
	int ret = [savePanel runModal];
	if (ret == NSOKButton){
		[inTargetField setStringValue:[savePanel filename]];
	}
	return ret;
}

/*-----------------------------------------------------------------------------
//  Function:   runOpenPanel
-----------------------------------------------------------------------------*/
+ (int)runOpenPanel:(NSArray*)inFileTypes:(NSTextField*)inTargetField
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	int ret = [openPanel runModalForTypes:inFileTypes];	
	if (ret == NSOKButton){
		[inTargetField setStringValue:[openPanel filename]];
	}
	return ret;
}

@end
