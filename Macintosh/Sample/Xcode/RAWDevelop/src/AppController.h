/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : AppController.h                                                 *
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

@interface AppController : NSObject
{
	// Controller Object
    IBOutlet id m_ProcessPageController;
    IBOutlet id m_EDSDKController;
	// Main Window
    IBOutlet id m_mainWindow;
	// UI
    IBOutlet id m_txtInputFile;
    IBOutlet id m_viewImage;
    IBOutlet id m_viewInformationText;
    IBOutlet id m_txtImgX;
    IBOutlet id m_txtImgY;	
    IBOutlet id m_txtImgW;
    IBOutlet id m_txtImgH;						
    IBOutlet id m_cmbWhiteBalance;
    IBOutlet id m_idcProcessProgress;
    IBOutlet id m_AFFramePanelController;
    IBOutlet id m_PropertyManager;
	// Other
	EdsImageInfo m_imageInfo;	
	EdsRect m_processRect;
	EdsDouble m_thmRatio;	
}

- (IBAction)onBtnInputFile:(id)sender;
- (IBAction)onBtnImageSource:(id)sender;
- (IBAction)onTxtImgX:(id)sender;
- (IBAction)onTxtImgY:(id)sender;
- (IBAction)onTxtImgW:(id)sender;
- (IBAction)onTxtImgH:(id)sender;
- (IBAction)onClickImage:(id)sender;
- (IBAction)onCheckShowAFFrame:(id)sender;

@end
