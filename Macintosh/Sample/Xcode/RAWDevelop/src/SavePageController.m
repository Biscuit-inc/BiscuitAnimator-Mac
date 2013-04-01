/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : SavePageController.m                                            *
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
#import "CtrlPanelSheet.h"
#import "SavePageController.h"

// s_tblSaveType
static STR_ID_TABLE s_tblSaveType[] = {
	{ @"Jpeg",		kEdsTargetImageType_Jpeg }, 
	{ @"TIFF",		kEdsTargetImageType_TIFF }, 
	{ @"TIFF16",	kEdsTargetImageType_TIFF16 }
};

// s_tblQuality
static STR_ID_TABLE s_tblQuality[] = {
	{ @"1 (low)",		1 }, 
	{ @"2",				2 }, 
	{ @"3",				3 }, 
	{ @"4",				4 }, 
	{ @"5",				5 }, 
	{ @"6",				6 }, 
	{ @"7",				7 }, 
	{ @"8",				8 }, 
	{ @"9",				9 }, 
	{ @"10 (high)",		10}, 								
};

@interface SavePageController (PrivateUtilities)

- (void)initializeComboBoxItems;

@end

/******************************************************************************
*******************************************************************************
//
//	Public Utilities
//
*******************************************************************************
******************************************************************************/
@implementation SavePageController

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
//  Function:   onCmbSaveType
-----------------------------------------------------------------------------*/
- (IBAction)onCmbSaveType:(id)sender
{
	int idx = [m_cmbSaveType indexOfSelectedItem];
	EdsInt32 value = s_tblSaveType[idx].value;	
	switch(value) {
	case kEdsTargetImageType_Jpeg:
		[m_cmbJPEGQuality setEnabled:YES];
		break;	
	case kEdsTargetImageType_TIFF:
		[m_cmbJPEGQuality setEnabled:NO];
		break;	
	case kEdsTargetImageType_TIFF16:
		[m_cmbJPEGQuality setEnabled:NO];
		break;	
	default:
		break;		
	};
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnColorProfile
-----------------------------------------------------------------------------*/
- (IBAction)onBtnColorProfile:(id)sender
{
	NSArray *fileTypes = [NSArray arrayWithObjects:@"ICC",@"ICM",nil];
	int ret = [CtrlPanelSheet runOpenPanel:fileTypes:m_txtColorProfile];
	if( ret != NSOKButton ) return;
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnSave
-----------------------------------------------------------------------------*/
- (IBAction)onBtnSave:(id)sender
{
	EdsError err;
	
	NSString* extension=nil;
	int idx = [m_cmbSaveType indexOfSelectedItem];
	EdsInt32 value = s_tblSaveType[idx].value;	
	switch(value) {
	case kEdsTargetImageType_Jpeg:
		extension = [NSString stringWithFormat:@"jpg"];
		break;	
	case kEdsTargetImageType_TIFF:
	case kEdsTargetImageType_TIFF16:
		extension = [NSString stringWithFormat:@"tiff"];
		break;	
	default:
		break;		
	};
	
	NSTextField* saveFile = [[[NSTextField alloc] init] autorelease];
	int ret = [CtrlPanelSheet runSavePanel:extension:saveFile];
	if( ret != NSOKButton ) return;
	
	EdsTargetImageType targetImageType = s_tblSaveType[[m_cmbSaveType indexOfSelectedItem]].value;
	NSString* saveFilename = [saveFile stringValue];
	EdsUInt32 JPEGQuality = s_tblQuality[[m_cmbJPEGQuality indexOfSelectedItem]].value;
	NSString* colorProfilename = [m_txtColorProfile stringValue];	
	err = [m_EDSDKController saveImage:targetImageType:saveFilename:JPEGQuality:colorProfilename];
}

@end

/******************************************************************************
*******************************************************************************
//
//	Private Utilities
//
*******************************************************************************
******************************************************************************/
@implementation SavePageController (PrivateUtilities)
/*-----------------------------------------------------------------------------
//  Function:   initializeComboBoxItems
-----------------------------------------------------------------------------*/
- (void)initializeComboBoxItems
{
	EdsUInt32 i;
	// SaveType
	[m_cmbSaveType removeAllItems];
	for( i=0; i<sizeof(s_tblSaveType)/sizeof(STR_ID_TABLE); i++ ) {
		[m_cmbSaveType addItemWithObjectValue:s_tblSaveType[i].string];
	}	
	[m_cmbSaveType selectItemAtIndex:0];	
	// JPEGQuality
	[m_cmbJPEGQuality removeAllItems];
	for( i=0; i<sizeof(s_tblQuality)/sizeof(STR_ID_TABLE); i++ ) {
		[m_cmbJPEGQuality addItemWithObjectValue:s_tblQuality[i].string];
	}	
	[m_cmbJPEGQuality selectItemAtIndex:7];		
}

@end

