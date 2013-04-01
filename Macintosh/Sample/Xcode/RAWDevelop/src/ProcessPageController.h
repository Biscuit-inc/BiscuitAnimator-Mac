/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : ProcessPageController.h                                         *
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

@interface ProcessPageController : NSObject
{
	// Controller
    IBOutlet id m_EDSDKController;
	// UI
    IBOutlet id m_sldDigitalExposure;	
    IBOutlet id m_txtDigitalExposure;
    IBOutlet id m_cmbWhiteBalance;
    IBOutlet id m_txtKelvin;
    IBOutlet id m_btnClickWB;	
    IBOutlet id m_sldWBShiftAB;
    IBOutlet id m_txtWBShiftAB;
    IBOutlet id m_sldWBShiftMG;
    IBOutlet id m_txtWBShiftMG;
    IBOutlet id m_cmbPictureStyle;
    IBOutlet id m_sldContrast;
    IBOutlet id m_txtContrast;
    IBOutlet id m_sldSharpness;
    IBOutlet id m_txtSharpness;				
    IBOutlet id m_sldColorTone;
    IBOutlet id m_txtColorTone;
    IBOutlet id m_sldSaturation;
    IBOutlet id m_txtSaturation;
    IBOutlet id m_cmbFilterEffect;
    IBOutlet id m_cmbToningEffect;
    IBOutlet id m_cmbColorSpace;		
}

- (void)initializeProcessPage;
// DigitalExposure
- (IBAction)onBtnAtCapDigitalExposure:(id)sender;
- (IBAction)onSldDigitalExposure:(id)sender;
// WhiteBalance
- (IBAction)onBtnAtCapWhiteBalance:(id)sender;
- (IBAction)onCmbWhiteBalance:(id)sender;
- (IBAction)onBtnClickWB:(id)sender;
- (IBAction)onTxtKelvin:(id)sender;
- (IBAction)onSldWBShiftAB:(id)sender;
- (IBAction)onSldWBShiftMG:(id)sender;
// PictureStyle
- (IBAction)onBtnAtCapPictureStyle:(id)sender;
- (IBAction)onCmbPictureStyle:(id)sender;
- (IBAction)onSldContrast:(id)sender;
- (IBAction)onSldSharpness:(id)sender;
- (IBAction)onSldColorTone:(id)sender;
- (IBAction)onSldSaturation:(id)sender;
- (IBAction)onCmbFilterEffect:(id)sender;
- (IBAction)onCmbToningEffect:(id)sender;
// ColorSpace
- (IBAction)onBtnAtCapColorSpace:(id)sender;
- (IBAction)onCmbColorSpace:(id)sender;
// Cache
- (IBAction)onChkUseCache:(id)sender;

@end

