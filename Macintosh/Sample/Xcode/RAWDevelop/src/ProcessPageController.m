/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : ProcessPageController.m                                         *
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
#import "EDSDKController.h"
#import "ProcessPageController.h"

// s_tblWhiteBalance
static STR_ID_TABLE s_tblWhiteBalance[] = {
	{ @"Auto",			kEdsWhiteBalance_Auto }, 
	{ @"Daylight",		kEdsWhiteBalance_Daylight }, 
	{ @"Cloudy",		kEdsWhiteBalance_Cloudy }, 
	{ @"Tangsten",		kEdsWhiteBalance_Tangsten }, 
	{ @"Fluorescent",	kEdsWhiteBalance_Fluorescent }, 
	{ @"Strobe",		kEdsWhiteBalance_Strobe }, 
	{ @"Shade",			kEdsWhiteBalance_Shade }, 
	{ @"ColorTemp",		kEdsWhiteBalance_ColorTemp }, 
};

// s_tblPictureStyle
static STR_ID_TABLE s_tblPictureStyle[] = {
	{ @"Auto",			kEdsPictureStyle_Auto }, 
	{ @"Standard",		kEdsPictureStyle_Standard }, 
	{ @"Portrait",		kEdsPictureStyle_Portrait }, 
	{ @"Landscape",		kEdsPictureStyle_Landscape }, 
	{ @"Neutral",		kEdsPictureStyle_Neutral }, 
	{ @"Faithful",		kEdsPictureStyle_Faithful }, 
	{ @"Monochrome",	kEdsPictureStyle_Monochrome }, 
};

// s_tblFilterEffect
static STR_ID_TABLE s_tblFilterEffect[] = {
	{ @"None",		kEdsFilterEffect_None }, 
	{ @"Yellow",	kEdsFilterEffect_Yellow }, 
	{ @"Orange",	kEdsFilterEffect_Orange }, 
	{ @"Red",		kEdsFilterEffect_Red }, 
	{ @"Green",		kEdsFilterEffect_Green }
};

// s_tblToningEffect
static STR_ID_TABLE s_tblToningEffect[] = {
	{ @"None",		kEdsTonigEffect_None }, 
	{ @"Sepia",		kEdsTonigEffect_Sepia }, 
	{ @"Blue",		kEdsTonigEffect_Blue }, 
	{ @"Purple",	kEdsTonigEffect_Purple }, 
	{ @"Green",		kEdsTonigEffect_Green }
};

// s_tblColorSpace
static STR_ID_TABLE s_tblColorSpace[] = {
	{ @"sRGB",		kEdsColorSpace_sRGB }, 
	{ @"AdobeRGB",	kEdsColorSpace_AdobeRGB }
};


@interface ProcessPageController (PrivateUtilities)

// initializeComboBoxItems
- (void)initializeComboBoxItems;
// setAllProcessControls
- (void)setAllProcessControls:(BOOL)inAtCapture;
// setDigitalExposureControl
- (void)setDigitalExposureControl:(BOOL)inAtCapture;
// setWhiteBalanceControl
- (void)setWhiteBalanceControl:(BOOL)inAtCapture;
// setPictureStyleControl
- (void)setPictureStyleControl:(BOOL)inAtCapture;
// setColorSpaceControl
- (void)setColorSpaceControl:(BOOL)inAtCapture;
// setControlStatus
- (EdsError)setControlStatus:(EdsUInt32)inPropertyID:(id)inControlObject;
// getControlData
- (EdsError)getControlData:(EdsUInt32)inPropertyID:(BOOL)inAtCapture:(EdsUInt32)inDataSize:(void*)outData;
// getComboIdx
- (int)getComboIdx:(STR_ID_TABLE*)inTable:(int)inNumElement:(EdsUInt32)inSearchValue;
- (void)updateImageview;

@end

/******************************************************************************
*******************************************************************************
//
//	Public Utilities
//
*******************************************************************************
******************************************************************************/
@implementation ProcessPageController

/*-----------------------------------------------------------------------------
//  Function:   awakeFromNib
-----------------------------------------------------------------------------*/
- (void)awakeFromNib
{

	// initializeComboBoxItems		
	[self initializeComboBoxItems];
}

/*-----------------------------------------------------------------------------
//  Function:   dealloc
-----------------------------------------------------------------------------*/
- (void)dealloc {

	[super dealloc];		
}

/*-----------------------------------------------------------------------------
//  Function:   initializeProcessPage
-----------------------------------------------------------------------------*/
- (void)initializeProcessPage
{
	[self setAllProcessControls:NO];
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnAtCapDigitalExposure
-----------------------------------------------------------------------------*/
- (IBAction)onBtnAtCapDigitalExposure:(id)sender
{
	// Set DigitalExposure Controll to AtCapture
	[self setDigitalExposureControl:YES];
	// Set to EDSDK
	[self onSldDigitalExposure:nil];
	// Process Image
	[self updateImageview];
}

/*-----------------------------------------------------------------------------
//  Function:   onSldDigitalExposure
-----------------------------------------------------------------------------*/
- (IBAction)onSldDigitalExposure:(id)sender
{
	// Set Control
	EdsDouble fDigitalExp = [m_sldDigitalExposure floatValue];
	[m_txtDigitalExposure setStringValue:EdsDouble_STR(fDigitalExp)];	
	// Set to EDSDK
	EdsRational rational = { (EdsInt32)(fDigitalExp*10), 10 };
	EdsError err = [m_EDSDKController setPropertyData:kEdsPropID_DigitalExposure:0:sizeof(rational):&rational];
	if(err&&sender) SHOW_ALERT(ALERT_PROPERTY_SET);
	// Do Process
	if(!err&&sender) [self updateImageview];	
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnAtCapWhiteBalance
-----------------------------------------------------------------------------*/
- (IBAction)onBtnAtCapWhiteBalance:(id)sender
{
	// Set WhiteBalance Controll to AtCapture
	[self setWhiteBalanceControl:YES];
	// Set to EDSDK
	[self onCmbWhiteBalance:nil];
	[self onTxtKelvin:nil];	
	[self onSldWBShiftAB:nil];	
	[self onSldWBShiftMG:nil];		
	// Process Image
	[self updateImageview];
}

/*-----------------------------------------------------------------------------
//  Function:   onCmbWhiteBalance
-----------------------------------------------------------------------------*/
- (IBAction)onCmbWhiteBalance:(id)sender
{
	// Set Control
	int idx = [m_cmbWhiteBalance indexOfSelectedItem];
	EdsInt32 value = s_tblWhiteBalance[idx].value;	
	if( value == kEdsWhiteBalance_ColorTemp ) {
		[m_txtKelvin setEnabled:YES];
	} else {
		[m_txtKelvin setEnabled:NO];	
	}
	// Set to EDSDK
	EdsError err = [m_EDSDKController setPropertyData:kEdsPropID_WhiteBalance:0:sizeof(value):&value];
	if(err&&sender) SHOW_ALERT(ALERT_PROPERTY_SET);
	// Do Process
	if(!err&&sender) [self updateImageview];	
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnClickWB
-----------------------------------------------------------------------------*/
- (IBAction)onBtnClickWB:(id)sender
{
	// on->off
	if([m_EDSDKController isClickWBMode]) {
		[m_EDSDKController setClickWBMode:NO];
		[m_btnClickWB setImage:[NSImage imageNamed:@"click_off"]];
		// Set Arrow Cursor
		[[NSCursor arrowCursor] set];
	// off->on
	} else {
		[m_EDSDKController setClickWBMode:YES];
		[m_btnClickWB setImage:[NSImage imageNamed:@"click_on"]];
	}
}

/*-----------------------------------------------------------------------------
//  Function:   onTxtKelvin
-----------------------------------------------------------------------------*/
- (IBAction)onTxtKelvin:(id)sender
{
	// Set to EDSDK
	NSString* string = [m_txtKelvin stringValue];
	EdsInt32 value = [string intValue];
	EdsError err = [m_EDSDKController setPropertyData:kEdsPropID_ColorTemperature:0:sizeof(value):&value];
	if(err&&sender) SHOW_ALERT(ALERT_PROPERTY_SET);
	// Do Process
	if(!err&&sender) [self updateImageview];
}

/*-----------------------------------------------------------------------------
//  Function:   onSldWBShiftAB
-----------------------------------------------------------------------------*/
- (IBAction)onSldWBShiftAB:(id)sender
{
	// Set Control
	EdsDouble fWBShiftAB = [m_sldWBShiftAB floatValue];
	EdsDouble fWBShiftMG = [m_sldWBShiftMG floatValue];	
	[m_txtWBShiftAB setStringValue:EdsDouble_STR(fWBShiftAB)];
	[m_txtWBShiftMG setStringValue:EdsDouble_STR(fWBShiftMG)];		
	// Set to EDSDK
	EdsInt32 WBShift[2] = { (EdsInt32)fWBShiftAB, (EdsInt32)fWBShiftMG };
	EdsError err = [m_EDSDKController setPropertyData:kEdsPropID_WhiteBalanceShift:0:sizeof(WBShift):&WBShift];
	if(err&&sender) SHOW_ALERT(ALERT_PROPERTY_SET);
	// Do Process
	if(!err&&sender) [self updateImageview];
}

/*-----------------------------------------------------------------------------
//  Function:   onSldWBShiftMG
-----------------------------------------------------------------------------*/
- (IBAction)onSldWBShiftMG:(id)sender
{
	[self onSldWBShiftAB:sender];
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnAtCapPictureStyle
-----------------------------------------------------------------------------*/
- (IBAction)onBtnAtCapPictureStyle:(id)sender
{
	// Set PictureStyle Controll to AtCapture
	[self setPictureStyleControl:YES];
	// Set to EDSDK
	[self onCmbPictureStyle:nil];
	[self onSldContrast:nil];
	[self onSldSharpness:nil];
	[self onSldColorTone:nil];
	[self onSldSaturation:nil];
	[self onCmbFilterEffect:nil];
	[self onCmbToningEffect:nil];
	// Process Image
	[self updateImageview];
}

/*-----------------------------------------------------------------------------
//  Function:   onCmbPictureStyle
-----------------------------------------------------------------------------*/
- (IBAction)onCmbPictureStyle:(id)sender
{
	// Set Control
	int idx = [m_cmbPictureStyle indexOfSelectedItem];
	EdsInt32 value = s_tblPictureStyle[idx].value;	
	if( value == kEdsPictureStyle_Monochrome ) {
		[m_sldColorTone setEnabled:NO];
		[m_sldSaturation setEnabled:NO];		
		[m_cmbFilterEffect setEnabled:YES];		
		[m_cmbToningEffect setEnabled:YES];			
	} else {
		[m_sldColorTone setEnabled:YES];
		[m_sldSaturation setEnabled:YES];		
		[m_cmbFilterEffect setEnabled:NO];		
		[m_cmbToningEffect setEnabled:NO];		
	}
	// Set to EDSDK
	EdsError err = [m_EDSDKController setPropertyData:kEdsPropID_PictureStyle:0:sizeof(value):&value];
	if(err&&sender) SHOW_ALERT(ALERT_PROPERTY_SET);
	// Do Process
	if(!err&&sender) [self updateImageview];	
}

/*-----------------------------------------------------------------------------
//  Function:   onSldContrast
-----------------------------------------------------------------------------*/
- (IBAction)onSldContrast:(id)sender
{
	EdsPictureStyleDesc pictureStyleDesc;
	pictureStyleDesc.contrast = [m_sldContrast intValue];
	pictureStyleDesc.sharpness = [m_sldSharpness intValue];
	pictureStyleDesc.colorTone = [m_sldColorTone intValue];
	pictureStyleDesc.saturation = [m_sldSaturation intValue];			
	pictureStyleDesc.filterEffect = s_tblFilterEffect[[m_cmbFilterEffect indexOfSelectedItem]].value;		
	pictureStyleDesc.toningEffect = s_tblToningEffect[[m_cmbToningEffect indexOfSelectedItem]].value;		
	// Set Control	
	[m_txtContrast setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.contrast]];
	[m_txtSharpness setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.sharpness]];
	[m_txtColorTone setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.colorTone]];
	[m_txtSaturation setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.saturation]];			
	// Set to EDSDK
	EdsError err = [m_EDSDKController setPropertyData:kEdsPropID_PictureStyleDesc:0:sizeof(pictureStyleDesc):&pictureStyleDesc];
	if(err&&sender) SHOW_ALERT(ALERT_PROPERTY_SET);
	// Do Process
	if(!err&&sender) [self updateImageview];

}

/*-----------------------------------------------------------------------------
//  Function:   onSldSharpness
-----------------------------------------------------------------------------*/
- (IBAction)onSldSharpness:(id)sender
{
	[self onSldContrast:sender];
}

/*-----------------------------------------------------------------------------
//  Function:   onSldColorTone
-----------------------------------------------------------------------------*/
- (IBAction)onSldColorTone:(id)sender
{
	[self onSldContrast:sender];
}

/*-----------------------------------------------------------------------------
//  Function:   onSldSaturation
-----------------------------------------------------------------------------*/
- (IBAction)onSldSaturation:(id)sender
{
	[self onSldContrast:sender];
}

/*-----------------------------------------------------------------------------
//  Function:   onCmbFilterEffect
-----------------------------------------------------------------------------*/
- (IBAction)onCmbFilterEffect:(id)sender
{
	[self onSldContrast:sender];
}

/*-----------------------------------------------------------------------------
//  Function:   onCmbToningEffect
-----------------------------------------------------------------------------*/
- (IBAction)onCmbToningEffect:(id)sender
{
	[self onSldContrast:sender];
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnAtColorSpace
-----------------------------------------------------------------------------*/
- (IBAction)onBtnAtCapColorSpace:(id)sender
{
	// Set ColorSpace Controll to AtCapture
	[self setColorSpaceControl:YES];
	// Set to EDSDK
	[self onCmbColorSpace:nil];
	// Process Image
	[self updateImageview];
}

/*-----------------------------------------------------------------------------
//  Function:   onCmbColorSpace
-----------------------------------------------------------------------------*/
- (IBAction)onCmbColorSpace:(id)sender
{
	// Set Control
	int idx = [m_cmbColorSpace indexOfSelectedItem];
	EdsInt32 value = s_tblColorSpace[idx].value;	
	// Set to EDSDK
	EdsError err = [m_EDSDKController setPropertyData:kEdsPropID_ColorSpace:0:sizeof(value):&value];
	if(err&&sender) SHOW_ALERT(ALERT_PROPERTY_SET);
	// Do Process
	if(!err&&sender) [self updateImageview];
}

/*-----------------------------------------------------------------------------
//  Function:   onChkUseCache
-----------------------------------------------------------------------------*/
- (IBAction)onChkUseCache:(id)sender
{
	if( [sender state] == NSOnState )
		[m_EDSDKController setUseCache:YES];
	else
		[m_EDSDKController setUseCache:NO];
}

@end 

/******************************************************************************
*******************************************************************************
//
//	Pricate Utilities
//
*******************************************************************************
******************************************************************************/
@implementation ProcessPageController (PrivateUtilities)
/*-----------------------------------------------------------------------------
//  Function:   initializeComboBoxItems
-----------------------------------------------------------------------------*/
- (void)initializeComboBoxItems
{
	EdsUInt32 i;
	// WhiteBalance
	[m_cmbWhiteBalance removeAllItems];
	for( i=0; i<sizeof(s_tblWhiteBalance)/sizeof(STR_ID_TABLE); i++ ) {
		[m_cmbWhiteBalance addItemWithObjectValue:s_tblWhiteBalance[i].string];
	}	
	[m_cmbWhiteBalance selectItemAtIndex:0];
	// PictureStyle
	[m_cmbPictureStyle removeAllItems];
	for( i=0; i<sizeof(s_tblPictureStyle)/sizeof(STR_ID_TABLE); i++ ) {
		[m_cmbPictureStyle addItemWithObjectValue:s_tblPictureStyle[i].string];
	}	
	[m_cmbPictureStyle selectItemAtIndex:0];	
	// FilterEffect
	[m_cmbFilterEffect removeAllItems];
	for( i=0; i<sizeof(s_tblFilterEffect)/sizeof(STR_ID_TABLE); i++ ) {
		[m_cmbFilterEffect addItemWithObjectValue:s_tblFilterEffect[i].string];
	}	
	[m_cmbFilterEffect selectItemAtIndex:0];
	// ToningEffect
	[m_cmbToningEffect removeAllItems];
	for( i=0; i<sizeof(s_tblToningEffect)/sizeof(STR_ID_TABLE); i++ ) {
		[m_cmbToningEffect addItemWithObjectValue:s_tblToningEffect[i].string];
	}	
	[m_cmbToningEffect selectItemAtIndex:0];		
	// ColorSpace
	[m_cmbColorSpace removeAllItems];
	for( i=0; i<sizeof(s_tblColorSpace)/sizeof(STR_ID_TABLE); i++ ) {
		[m_cmbColorSpace addItemWithObjectValue:s_tblColorSpace[i].string];
	}	
	[m_cmbColorSpace selectItemAtIndex:0];				
}

/*-----------------------------------------------------------------------------
//  Function:   setAllProcessControls
-----------------------------------------------------------------------------*/
- (void)setAllProcessControls:(BOOL)inAtCapture
{
	[self setDigitalExposureControl:inAtCapture];
	[self setWhiteBalanceControl:inAtCapture];
	[self setPictureStyleControl:inAtCapture];	
	[self setColorSpaceControl:inAtCapture];	
}

/*-----------------------------------------------------------------------------
//  Function:   setDigitalExposureControl
-----------------------------------------------------------------------------*/
- (void)setDigitalExposureControl:(BOOL)inAtCapture
{
	EdsError err;
	// setControlStatus
	err = [self setControlStatus:kEdsPropID_DigitalExposure:m_sldDigitalExposure];
	if(!err) {
		// getControlData
		EdsRational digitalExp;	
		err = [self getControlData:kEdsPropID_DigitalExposure:inAtCapture:sizeof(digitalExp):&digitalExp];	
		// Set Data
		EdsDouble fDigitalExp;
		if(!err) {
			fDigitalExp = (EdsDouble)digitalExp.numerator / digitalExp.denominator;
			[m_sldDigitalExposure setFloatValue:fDigitalExp];
			[m_txtDigitalExposure setStringValue:EdsDouble_STR(fDigitalExp)];		
		}
	}
}

/*-----------------------------------------------------------------------------
//  Function:   setWhiteBalanceControl
-----------------------------------------------------------------------------*/
- (void)setWhiteBalanceControl:(BOOL)inAtCapture
{
	EdsError err;
	/*=================================
	WhiteBalance
	=================================*/
	EdsWhiteBalance whiteBalance;	
	// setControlStatus
	err = [self setControlStatus:kEdsPropID_WhiteBalance:m_cmbWhiteBalance];
	if(!err) {
		// getControlData	
		err = [self getControlData:kEdsPropID_WhiteBalance:inAtCapture:sizeof(whiteBalance):&whiteBalance];	
		// Set Data
		if(!err) {
			int numElement=sizeof(s_tblWhiteBalance)/sizeof(STR_ID_TABLE);
			int idx = [self getComboIdx:s_tblWhiteBalance:numElement:whiteBalance];
			if( idx < numElement ) [m_cmbWhiteBalance selectItemAtIndex:idx];			
		}
	}
	/*=================================
	ColorTemp
	=================================*/	
	// setControlStatus
	err = [self setControlStatus:kEdsPropID_WhiteBalance:m_txtKelvin];
	if(err) {
		[m_txtKelvin setStringValue:@""];
	} else {	
		EdsUInt32 colorTemp;
		// getControlData	
		err = [self getControlData:kEdsPropID_WhiteBalance:inAtCapture:sizeof(colorTemp):&colorTemp];	
		// Set Data
		if(!err) [m_txtKelvin setStringValue:[NSString stringWithFormat:@"%d",colorTemp]];
		//
		[self onCmbWhiteBalance:nil];				
	}
	/*=================================
	WBShiftAB / WBShiftMG
	=================================*/	
	// setControlStatus
	err = [self setControlStatus:kEdsPropID_WhiteBalanceShift:m_sldWBShiftAB];
	[self setControlStatus:kEdsPropID_WhiteBalanceShift:m_sldWBShiftMG];	
	if(!err) {
		// getControlData
		EdsInt32 wbShift[2];	
		err = [self getControlData:kEdsPropID_WhiteBalanceShift:inAtCapture:sizeof(wbShift):&wbShift];	
		// Set Data
		if(!err) {
			[m_sldWBShiftAB setFloatValue:(EdsDouble)wbShift[0]];
			[m_txtWBShiftAB setStringValue:EdsDouble_STR((EdsDouble)wbShift[0])];		
			[m_sldWBShiftMG setFloatValue:(EdsDouble)wbShift[1]];
			[m_txtWBShiftMG setStringValue:EdsDouble_STR((EdsDouble)wbShift[1])];				
		}
	}	
}

/*-----------------------------------------------------------------------------
//  Function:   setPictureStyleControl
-----------------------------------------------------------------------------*/
- (void)setPictureStyleControl:(BOOL)inAtCapture
{
	EdsError err;
	// setControlStatus
	err  = [self setControlStatus:kEdsPropID_PictureStyle:m_cmbPictureStyle];
	[self setControlStatus:kEdsPropID_PictureStyleDesc:m_sldContrast];	
	[self setControlStatus:kEdsPropID_PictureStyleDesc:m_sldSharpness];
	[self setControlStatus:kEdsPropID_PictureStyleDesc:m_sldColorTone];	
	[self setControlStatus:kEdsPropID_PictureStyleDesc:m_sldSaturation];
	[self setControlStatus:kEdsPropID_PictureStyleDesc:m_cmbFilterEffect];	
	[self setControlStatus:kEdsPropID_PictureStyleDesc:m_cmbToningEffect];
	if(!err) {
		int numElement;
		int idx;
		/*=================================
		PictureStyle
		=================================*/		
		EdsUInt32 pictureStyle;
		// getControlData	
		err = [self getControlData:kEdsPropID_PictureStyle:inAtCapture:sizeof(pictureStyle):&pictureStyle];		
		// Set Data
		if(!err) {
			numElement=sizeof(s_tblPictureStyle)/sizeof(STR_ID_TABLE);
			idx = [self getComboIdx:s_tblPictureStyle:numElement:pictureStyle];
			if( idx < numElement ) [m_cmbPictureStyle selectItemAtIndex:idx];			
		}
		/*=================================
		PictureStyle Desc
		=================================*/				
		EdsPictureStyleDesc pictureStyleDesc;
		// getControlData	
		err = [self getControlData:kEdsPropID_PictureStyleDesc:inAtCapture:sizeof(pictureStyleDesc):&pictureStyleDesc];	
		// Set Data
		if(!err) {
			// Contrast
			[m_sldContrast setFloatValue:pictureStyleDesc.contrast];
			[m_txtContrast setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.contrast]];	
			// Sharpness
			[m_sldSharpness setFloatValue:pictureStyleDesc.sharpness];
			[m_txtSharpness setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.sharpness]];	
			// Saturation
			[m_sldSaturation setFloatValue:pictureStyleDesc.saturation];
			[m_txtSaturation setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.saturation]];	
			// ColorTone
			[m_sldColorTone setFloatValue:pictureStyleDesc.colorTone];
			[m_txtColorTone setStringValue:[NSString stringWithFormat:@"%d",pictureStyleDesc.colorTone]];	
			// FilterEffect
			numElement=sizeof(s_tblFilterEffect)/sizeof(STR_ID_TABLE);
			idx = [self getComboIdx:s_tblFilterEffect:numElement:pictureStyleDesc.filterEffect];
			if( idx < numElement ) [m_cmbFilterEffect selectItemAtIndex:idx];	
			// ToningEffect
			numElement=sizeof(s_tblToningEffect)/sizeof(STR_ID_TABLE);
			idx = [self getComboIdx:s_tblToningEffect:numElement:pictureStyleDesc.toningEffect];
			if( idx < numElement ) [m_cmbToningEffect selectItemAtIndex:idx];	
			
			[self onCmbPictureStyle:nil];													
		}
	}

}

/*-----------------------------------------------------------------------------
//  Function:   setColorSpaceControl
-----------------------------------------------------------------------------*/
- (void)setColorSpaceControl:(BOOL)inAtCapture
{
	EdsError err;
	/*=================================
	ColorSpace
	=================================*/
	EdsUInt32 colorSpace;	
	// setControlStatus
	err = [self setControlStatus:kEdsPropID_ColorSpace:m_cmbColorSpace];
	if(!err) {
		// getControlData	
		err = [self getControlData:kEdsPropID_ColorSpace:inAtCapture:sizeof(colorSpace):&colorSpace];	
		// Set Data
		if(!err) {
			int numElement=sizeof(s_tblColorSpace)/sizeof(STR_ID_TABLE);
			int idx = [self getComboIdx:s_tblColorSpace:numElement:colorSpace];
			if( idx < numElement ) [m_cmbColorSpace selectItemAtIndex:idx];			
		}
	}
}

/*-----------------------------------------------------------------------------
//  Function:   setControlStatus
-----------------------------------------------------------------------------*/
- (EdsError)setControlStatus:(EdsUInt32)inPropertyID:(id)inControlObject
{
	EdsError err;
	EdsUInt32 size;
	EdsDataType dataType;
	err = [m_EDSDKController getPropertySize:inPropertyID:0:&dataType:&size];
	if(err) {
		[inControlObject setEnabled:NO];	
	} else {
		[inControlObject setEnabled:YES];
	}
	return err;
}

/*-----------------------------------------------------------------------------
//  Function:   getControlData
-----------------------------------------------------------------------------*/
- (EdsError)getControlData:(EdsUInt32)inPropertyID:(BOOL)inAtCapture:(EdsUInt32)inDataSize:(void*)outData
{
	EdsError err;
	if(inAtCapture) {
		err = [m_EDSDKController getPropertyData:kEdsPropID_AtCapture_Flag | inPropertyID:0:inDataSize:outData];
	} else {
		err = [m_EDSDKController getPropertyData:inPropertyID:0:inDataSize:outData];
	}
	return err;	
}

/*-----------------------------------------------------------------------------
//  Function:   getComboIdx
-----------------------------------------------------------------------------*/
- (int)getComboIdx:(STR_ID_TABLE*)inTable:(int)inNumElement:(EdsUInt32)inSearchValue
{
	EdsUInt32 i;
	for( i=0; i<inNumElement; i++ ) {
		if((inTable+i)->value == inSearchValue) break;
	}
	return i;	
}

- (void)updateImageview
{
	// Send Notification
	[[NSNotificationCenter defaultCenter] postNotificationName:
		[NSString stringWithString:NOTIFY_UPDATE_IMAGEVIEW] object:nil];
}

@end
