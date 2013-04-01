/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : AppController.m                                                 *
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
#import "ProcessPageController.h"
#import "AFFramePanelController.h"
#import "PropertyManager.h"
#import "AppController.h"

@interface AppController (PrivateUtilities)

- (void)notifiedProgressCallback:(NSNotification*)inNotification;
- (void)notifiedUpdateImageview:(NSNotification*)inNotification;
- (void)prepareNewImage;
- (void)setupImageInfo;
- (void)setupInformationBox;
- (void)setClickCursor;
- (EdsPoint)convertMousedownPointToFullimagePoint:(NSPoint)inMousedownPoint;
- (EdsSize)calculateDestinationImageSize;
- (EdsDouble)calculateDisplayRatio;
- (NSImage*)nsImage:(NSSize)inImageSize:(EdsVoid*)inBuffer;

@end

/******************************************************************************
*******************************************************************************
//
//	Public Utilities
//
*******************************************************************************
******************************************************************************/
@implementation AppController

/*-----------------------------------------------------------------------------
//  Function:   awakeFromNib
-----------------------------------------------------------------------------*/
- (void)awakeFromNib
{
	// Recieve Progress Callback
    [[NSNotificationCenter defaultCenter] addObserver:
		self selector:@selector(notifiedProgressCallback:)name:NOTIFY_PROGRESS_CALLBACK object:nil];
	// Recieve Update Imageview
    [[NSNotificationCenter defaultCenter] addObserver:
		self selector:@selector(notifiedUpdateImageview:)name:NOTIFY_UPDATE_IMAGEVIEW object:nil];	
}

/*-----------------------------------------------------------------------------
//  Function:   mouseMoved
-----------------------------------------------------------------------------*/
- (void)mouseMoved:(NSEvent *)event
{
	// Set Cursor
	if([m_EDSDKController isClickWBMode]) [self setClickCursor];
}

/*-----------------------------------------------------------------------------
//  Function:   dealloc
-----------------------------------------------------------------------------*/
- (void)dealloc
{
	// Remove Notification
	[[NSNotificationCenter defaultCenter] removeObserver:self ];	
	[super dealloc];		
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnInputFile
-----------------------------------------------------------------------------*/
- (IBAction)onBtnInputFile:(id)sender
{
	NSArray *fileTypes = [NSArray arrayWithObjects:@"CRW",@"TIF",@"CR2",@"JPG",nil];
	int ret = [CtrlPanelSheet runOpenPanel:fileTypes:m_txtInputFile];
	if( ret != NSOKButton ) return;

	EdsError err=EDS_ERR_OK;
	// Open NewFile
	err = [m_EDSDKController openNewFile:[m_txtInputFile stringValue]];
	if(!err) {
		// setupImageInfo
		[self setupImageInfo];		
		// setupInformationBox
		[self setupInformationBox];
		// initializeProcessPage
		[m_ProcessPageController initializeProcessPage];
		// Process Image
		[self prepareNewImage];
		// Update AF Frame
		[m_AFFramePanelController updateAFFrame];
	} else {
		SHOW_ALERT(ALERT_NOT_CORRECT_FILE);
		[m_txtInputFile setStringValue:@""];
	}
	return;
}

/*-----------------------------------------------------------------------------
//  Function:   onBtnImageSource
-----------------------------------------------------------------------------*/
- (IBAction)onBtnImageSource:(id)sender
{
	if( [sender selectedCell] == [sender cellAtRow:0 column:0] ) 
	{
		[m_EDSDKController setImageSource:kEdsImageSrc_RAWThumbnail];	
	} else {
		[m_EDSDKController setImageSource:kEdsImageSrc_RAWFullView];		
	}
	// setupImageInfo
	[self setupImageInfo];
}

/*-----------------------------------------------------------------------------
//  Function:   onTxtImgX
-----------------------------------------------------------------------------*/
- (IBAction)onTxtImgX:(id)sender
{
	EdsBool needProcess=NO;
	if(m_processRect.point.x != [sender intValue]) needProcess=YES;
	m_processRect.point.x = [sender intValue];	
	if(needProcess) [self prepareNewImage];
}

/*-----------------------------------------------------------------------------
//  Function:   onTxtImgY
-----------------------------------------------------------------------------*/
- (IBAction)onTxtImgY:(id)sender
{
	EdsBool needProcess=NO;
	if(m_processRect.point.y != [sender intValue]) needProcess=YES;
	m_processRect.point.y = [sender intValue];	
	if(needProcess) [self prepareNewImage];
}

/*-----------------------------------------------------------------------------
//  Function:   onTxtImgW
-----------------------------------------------------------------------------*/
- (IBAction)onTxtImgW:(id)sender
{
	EdsBool needProcess=NO;
	if(m_processRect.size.width != [sender intValue]) needProcess=YES;
	m_processRect.size.width = [sender intValue];	
	if(needProcess) [self prepareNewImage];
}

/*-----------------------------------------------------------------------------
//  Function:   onTxtImgH
-----------------------------------------------------------------------------*/
- (IBAction)onTxtImgH:(id)sender
{
	EdsBool needProcess=NO;
	if(m_processRect.size.height != [sender intValue]) needProcess=YES;
	m_processRect.size.height = [sender intValue];	
	if(needProcess) [self prepareNewImage];
}

/*-----------------------------------------------------------------------------
//  Function:   onClickImage
-----------------------------------------------------------------------------*/
- (IBAction)onClickImage:(id)sender
{	
	if(![m_EDSDKController isClickWBMode]) return; 
	EdsError err;
	NSEvent* currentEvent = [NSApp currentEvent];
	NSPoint mouseDownPoint = [sender convertPoint: [currentEvent locationInWindow] fromView: nil];
	// convert ClickPoint to Fullimage Point
	EdsPoint fullImagePoint = [self convertMousedownPointToFullimagePoint:mouseDownPoint];
	// calculate click
	EdsWhiteBalance whiteBalance = kEdsWhiteBalance_Click;
	err = [m_EDSDKController setPropertyData:kEdsPropID_WhiteBalance:0:sizeof(whiteBalance):&whiteBalance];
	if(!err) err = [m_EDSDKController setPropertyData:kEdsPropID_ClickWBPoint:0:sizeof(fullImagePoint):&fullImagePoint];

	[m_cmbWhiteBalance setStringValue:@"Click"];
	// Process Image
	[self prepareNewImage];
}

- (IBAction)onCheckShowAFFrame:(id)sender
{
	if([sender state] == NSOnState)
		[m_AFFramePanelController setShowAFFrame:YES];
	else
		[m_AFFramePanelController setShowAFFrame:NO];
}

@end

/******************************************************************************
*******************************************************************************
//
//	Private Utilities
//
*******************************************************************************
******************************************************************************/
@implementation AppController (PrivateUtilities)

/*-----------------------------------------------------------------------------
//  Function:   notifiedProgressCallback
-----------------------------------------------------------------------------*/
- (void)notifiedProgressCallback:(NSNotification*)inNotification
{
	NSNumber* number = [inNotification object];
	EdsUInt32 percent = [number intValue];
	[m_idcProcessProgress setDoubleValue:percent];
	[m_idcProcessProgress display];
	if( percent == 100 ) {
		[m_idcProcessProgress setDoubleValue:0.0];
		[m_idcProcessProgress display];	
	}
}

/*-----------------------------------------------------------------------------
//  Function:   notifiedUpdateImageview
-----------------------------------------------------------------------------*/
- (void)notifiedUpdateImageview:(NSNotification*)inNotification
{
	[self prepareNewImage];
}

/*-----------------------------------------------------------------------------
//  Function:   runOpenPanel
-----------------------------------------------------------------------------*/
- (int)runOpenPanel:(BOOL)inSelDirectory:(NSTextField*)inTargetField
{
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setCanChooseFiles:!inSelDirectory];
	[openPanel setCanChooseDirectories:inSelDirectory];
	int ret = [openPanel runModalForDirectory:NSHomeDirectory() file:nil types:nil];
	if (ret == NSOKButton){
		[inTargetField setStringValue:[openPanel filename]];
	}
	return ret;
}

/*-----------------------------------------------------------------------------
//  Function:   setupImageInfo
-----------------------------------------------------------------------------*/
- (void)setupImageInfo
{
	if(!m_thmRatio) { 
		EdsImageInfo thumbImageInfo = [m_EDSDKController thumbnailRAWImageInfo];
		EdsImageInfo fullImageInfo = [m_EDSDKController fullviewRAWImageInfo];
		m_thmRatio = (EdsDouble)thumbImageInfo.width/fullImageInfo.width;
	}
	m_processRect = [m_EDSDKController currentImageInfo].effectiveRect;	
	// Setup TextField
	[m_txtImgX setIntValue:m_processRect.point.x];
	[m_txtImgY setIntValue:m_processRect.point.y];
	[m_txtImgW setIntValue:m_processRect.size.width];
	[m_txtImgH setIntValue:m_processRect.size.height];
}

/*-----------------------------------------------------------------------------
//  Function:   setupInformationBox
-----------------------------------------------------------------------------*/
- (void)setupInformationBox
{
	// reset text
	[m_viewInformationText selectAll:nil];
	[m_viewInformationText delete:nil];
	// set Color
	[m_viewInformationText setBackgroundColor:[NSColor blackColor]];
	[m_viewInformationText setTextColor:[NSColor whiteColor]];
	// Editable YES
	[m_viewInformationText setEditable:YES];

	EdsError err;
	EdsDataType dataType;
	EdsUInt32 size;
	EdsChar szTmp[32];
	EdsVoid* data;
	
	EdsImageSource	srcList[] ={
			kEdsImageSrc_RAWThumbnail,
			kEdsImageSrc_RAWFullView,
	};
	EdsPropertyID	propList[] = {
			kEdsPropID_MakerName,
			kEdsPropID_ProductName,
			kEdsPropID_DateTime,
			kEdsPropID_Tv,
			kEdsPropID_Av,
			kEdsPropID_ISOSpeed,
			kEdsPropID_FocalLength,
			kEdsPropID_LensName,
			kEdsPropID_BodyIDEx,
			kEdsPropID_OwnerName,
			kEdsPropID_FirmwareVersion,
			kEdsPropID_JpegQuality,
			kEdsPropID_Orientation,
			kEdsPropID_AEMode,
			kEdsPropID_DriveMode,
			kEdsPropID_MeteringMode,
			kEdsPropID_AFMode,
			kEdsPropID_ExposureCompensation,
			kEdsPropID_DigitalExposure,
			kEdsPropID_FlashCompensation,
			kEdsPropID_Bracket,
			kEdsPropID_WhiteBalance,
			kEdsPropID_WhiteBalanceShift,
			kEdsPropID_Sharpness,
			kEdsPropID_ColorSaturation,
			kEdsPropID_ColorMatrix,
			kEdsPropID_Contrast,
			kEdsPropID_ColorTone,
			kEdsPropID_ColorSpace,
			kEdsPropID_PhotoEffect,
			kEdsPropID_FilterEffect,
			kEdsPropID_ToningEffect,
			kEdsPropID_ToneCurve,
			kEdsPropID_PictureStyle,
			kEdsPropID_FlashOn,
			kEdsPropID_FlashMode,
			kEdsPropID_RedEye,
			kEdsPropID_NoiseReduction,
			kEdsPropID_GPSVersionID,
			kEdsPropID_GPSLatitude,
			kEdsPropID_GPSLongitude,
			kEdsPropID_GPSAltitude,
			kEdsPropID_GPSDateStamp,
			kEdsPropID_GPSTimeStamp,
			kEdsPropID_GPSMapDatum,
			kEdsPropID_GPSSatellites,

			kEdsPropID_GPSStatus,
	};

	EdsInt32 i = 0;
	NSString *propString = nil;
	for(i = 0; i < sizeof(srcList)/sizeof(EdsImageSource); i++)
	{
		propString = [m_PropertyManager getImageInfoString:srcList[i]];
		if(propString!=nil)		[m_viewInformationText insertText:propString];			
	}
	for(i = 0; i < sizeof(propList)/sizeof(EdsPropertyID); i++)
	{
		propString = [m_PropertyManager getPropertyString:propList[i]];
		if(propString!=nil)		[m_viewInformationText insertText:propString];			
	}
	// Editable NO
	[m_viewInformationText setEditable:NO];
}
                         
/*-----------------------------------------------------------------------------
//  Function:   prepareNewImage
-----------------------------------------------------------------------------*/
- (void)prepareNewImage
{
	EdsError err;

	EdsSize dstSize = [self calculateDestinationImageSize];
	// Create Out Stream
	EdsUInt32 bufferSize = dstSize.width*dstSize.height*3;	/* 8bit 3components */
	EdsStreamRef imageStream=NULL;
	// Create Image Stream
	err = EdsCreateMemoryStream( bufferSize, &imageStream );	
	// Process Image
	if(!err) err = [m_EDSDKController processImage:m_processRect:dstSize:imageStream];
	EdsVoid* pointer;
	if(!err) err = EdsGetPointer( imageStream, &pointer );
	// Show Image
	NSImage* nsImage=nil;
	if(!err) {
		nsImage = [self nsImage:NSMakeSize(dstSize.width,dstSize.height):pointer];
	}
	// Show Image
	if(nsImage) {
		// lock
		[nsImage lockFocus];
		// set
		[m_viewImage setImage : nsImage];	
		// unLock
		[nsImage unlockFocus];
	}
	// Release
	if(imageStream) EdsRelease(imageStream);
}

/*-----------------------------------------------------------------------------
//  Function:   nsImage
-----------------------------------------------------------------------------*/
- (NSImage*)nsImage:(NSSize)inImageSize:(EdsVoid*)inBuffer
{
	// Create Bitmap
	NSBitmapImageRep* imageBitmap = [[NSBitmapImageRep alloc]
								initWithBitmapDataPlanes:(unsigned char**)&inBuffer
								pixelsWide:inImageSize.width
								pixelsHigh:inImageSize.height
								bitsPerSample:8
								samplesPerPixel:3
								hasAlpha:NO
								isPlanar:NO
								colorSpaceName:NSDeviceRGBColorSpace
								bytesPerRow:inImageSize.width*3
								bitsPerPixel:24];
	NSImage* nsImage = [[NSImage alloc] initWithSize:inImageSize ];
	//@Add Bitmap
	[nsImage addRepresentation:imageBitmap];
	// Release Bitmap
	[imageBitmap release];	
	return [nsImage autorelease];
}

/*-----------------------------------------------------------------------------
//  Function:   setClickCursor
-----------------------------------------------------------------------------*/
- (void)setClickCursor
{
	// set HotSpot
	NSCursor* curClick = [[[NSCursor alloc] initWithImage:[NSImage imageNamed:@"cur_click"] hotSpot:NSMakePoint( 1.0, 14.0 )] autorelease];
	[curClick set];
}		

/*-----------------------------------------------------------------------------
//  Function:   calculateDestinationImageRatio
-----------------------------------------------------------------------------*/
- (EdsDouble)calculateDisplayRatio
{
	EdsDouble displayRatio;
	// calculate ratio 
	NSSize nsViewSize = [m_viewImage frame].size;	
	if(m_processRect.size.width>m_processRect.size.height) {
		displayRatio = (EdsDouble)nsViewSize.width / m_processRect.size.width;
		if((EdsInt32)(m_processRect.size.height*displayRatio) > nsViewSize.height)
			displayRatio = (EdsDouble)nsViewSize.height / m_processRect.size.height;
	} else {
		displayRatio = (EdsDouble)nsViewSize.height / m_processRect.size.height;
		if((EdsInt32)(m_processRect.size.width*displayRatio) > nsViewSize.width)
			displayRatio = (EdsDouble)nsViewSize.width / m_processRect.size.width;	
	}
	return displayRatio;
}

/*-----------------------------------------------------------------------------
//  Function:   calculateDestinationImageSize
-----------------------------------------------------------------------------*/
- (EdsSize)calculateDestinationImageSize
{
	EdsSize size;
	NSSize nsViewSize = [m_viewImage frame].size;	
	EdsDouble displayRatio = [self calculateDisplayRatio];
	size.width = (EdsInt32)(m_processRect.size.width*displayRatio);
	size.height = (EdsInt32)(m_processRect.size.height*displayRatio);	
	return size;
}

/*-----------------------------------------------------------------------------
//  Function:   convertMousedownPointToFullimagePoint
-----------------------------------------------------------------------------*/
- (EdsPoint)convertMousedownPointToFullimagePoint:(NSPoint)inmouseDownPoint
{
	EdsPoint fullimagePoint;
	EdsDouble displayRatio = [self calculateDisplayRatio];	
	// convert coordinates
	fullimagePoint.x = inmouseDownPoint.x;
	fullimagePoint.y = [m_viewImage frame].size.height - inmouseDownPoint.y;	
	// shift the point to Image point
	EdsSize dstSize = [self calculateDestinationImageSize];
	fullimagePoint.y = fullimagePoint.y - ([m_viewImage frame].size.height - dstSize.height);	
	// convert display size to process size
	if(displayRatio) {
		fullimagePoint.x /= displayRatio;	
		fullimagePoint.y /= displayRatio;
	}
	// shift the point
	fullimagePoint.x += m_processRect.point.x;
	fullimagePoint.y += m_processRect.point.y;	
	// convert thumbnailSize to fullSize
	if( [m_EDSDKController imageSource] == kEdsImageSrc_RAWThumbnail ) {
		if(m_thmRatio) {
			fullimagePoint.x /= m_thmRatio;
			fullimagePoint.y /= m_thmRatio;
		}
	}
	return fullimagePoint;
}
		
@end
