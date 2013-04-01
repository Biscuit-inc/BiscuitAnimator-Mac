/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : SavePageController.h                                            *
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

@interface SavePageController : NSObject
{
	// Controller
    IBOutlet id m_EDSDKController;
	// UI
    IBOutlet id m_cmbSaveType;	
    IBOutlet id m_cmbJPEGQuality;
    IBOutlet id m_txtColorProfile;	
}

- (IBAction)onCmbSaveType:(id)sender;
- (IBAction)onBtnColorProfile:(id)sender;
- (IBAction)onBtnSave:(id)sender;

@end
