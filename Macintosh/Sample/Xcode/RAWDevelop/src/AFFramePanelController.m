#import "EDSDKController.h"
#import "MyAFFrameView.h"
#import "AFFramePanelController.h"

@interface AFFramePanelController (PrivateUtilities)
-(EdsError)calcurateFocusInfo:(EdsFocusInfo*)outFocusInfo targetSize:(EdsSize)size;
@end

@implementation AFFramePanelController
/*-----------------------------------------------------------------------------
//  Function:   awakeFromNib
-----------------------------------------------------------------------------*/
- (void)awakeFromNib
{
	// Recieve Update Image
    [[NSNotificationCenter defaultCenter] addObserver:self 
		selector:@selector(notifiedUpdateAFFrameView:)name:NOTIFY_UPDATE_AFFRAMEVIEW object:nil];	
}

-(void)setShowAFFrame:(bool)bShow
{
	m_bShow = bShow;
	if(m_bShow == YES)
		[m_AFFramePanel orderFront:nil];
	else
		[m_AFFramePanel orderOut:nil];
}

-(void)updateAFFrame
{
	// Send Notification
	[[NSNotificationCenter defaultCenter] postNotificationName:
		[NSString stringWithString:NOTIFY_UPDATE_AFFRAMEVIEW] object:nil];
}

/*-----------------------------------------------------------------------------
//  Function:   notifiedUpdateAFFrameView
-----------------------------------------------------------------------------*/
- (void)notifiedUpdateAFFrameView:(NSNotification*)inNotification
{
	EdsError err;
	EdsImageSource	currentSource = [m_EDSDKController imageSource];
	NSSize dstSize = [m_AFFrameView frame].size;
	
	[m_EDSDKController setImageSource:kEdsImageSrc_RAWThumbnail];

	EdsDouble displayRatio;
	EdsImageInfo	curInfo = [m_EDSDKController currentImageInfo];	
	if(curInfo.effectiveRect.size.width>curInfo.effectiveRect.size.height) {
		displayRatio = (EdsDouble)dstSize.width / curInfo.effectiveRect.size.width;
		if((EdsInt32)(curInfo.effectiveRect.size.height*displayRatio) > dstSize.height)
			displayRatio = (EdsDouble)dstSize.height / curInfo.effectiveRect.size.height;
	} else {
		displayRatio = (EdsDouble)dstSize.height / curInfo.effectiveRect.size.height;
		if((EdsInt32)(curInfo.effectiveRect.size.width*displayRatio) > dstSize.width)
			displayRatio = (EdsDouble)dstSize.width / curInfo.effectiveRect.size.width;	
	}

	EdsSize size;
	size.width = (EdsInt32)(curInfo.effectiveRect.size.width*displayRatio);
	size.height = (EdsInt32)(curInfo.effectiveRect.size.height*displayRatio);
	
	EdsUInt32	bufferSize = size.width * size.height * 3;
	[m_EDSDKController setImageSource:currentSource];
	EdsStreamRef imageStream=NULL;
	// Create Image Stream
	err = EdsCreateMemoryStream( bufferSize, &imageStream );	
	// Process Image
	if(!err) err = [m_EDSDKController processImage:curInfo.effectiveRect:size:imageStream];
	EdsVoid* pointer;
	if(!err) err = EdsGetPointer( imageStream, &pointer );
	// Show Image
	NSImage* nsImage=nil;
	if(!err) {
		NSSize	imgSize = NSMakeSize(size.width,size.height);
		// Create Bitmap
		NSBitmapImageRep* imageBitmap = [[NSBitmapImageRep alloc]
									initWithBitmapDataPlanes:(unsigned char**)&pointer
									pixelsWide:imgSize.width
									pixelsHigh:imgSize.height
									bitsPerSample:8
									samplesPerPixel:3
									hasAlpha:NO
									isPlanar:NO
									colorSpaceName:NSDeviceRGBColorSpace
									bytesPerRow:imgSize.width*3
									bitsPerPixel:24];
		nsImage = [[NSImage alloc] initWithSize:imgSize ];
		//Å@Add Bitmap
		[nsImage addRepresentation:imageBitmap];
		// Release Bitmap
		[imageBitmap release];	
		[nsImage autorelease];
	}
	
	EdsFocusInfo focusInfo = {0};
	[m_AFFrameView setFocusInfo:focusInfo];
	if(EDS_ERR_OK == [self calcurateFocusInfo:&focusInfo targetSize:size])
		[m_AFFrameView setFocusInfo:focusInfo];

	// Show Image
	if(nsImage) {
		// lock
		[nsImage lockFocus];
		// set
		[m_AFFrameView setImage : nsImage];	
		// unLock
		[nsImage unlockFocus];
	}
	// Release
	if(imageStream) EdsRelease(imageStream);
}

@end


@implementation AFFramePanelController (PrivateUtilities)
-(EdsError)calcurateFocusInfo:(EdsFocusInfo*)outFocusInfo targetSize:(EdsSize)size
{
	EdsError err = EDS_ERR_OK;
	EdsUInt32	i;

	if(outFocusInfo==NULL)	return EDS_ERR_INVALID_PARAMETER;
	
	EdsFocusInfo	focusInfo = {0};
	err= [m_EDSDKController getPropertyData:kEdsPropID_FocusInfo :0 :sizeof(focusInfo) :&focusInfo];
	*outFocusInfo = focusInfo;
	if(err == EDS_ERR_OK)
	{
		float xRatio = 1;
		float yRatio = 1;

		xRatio = (float)size.width/focusInfo.imageRect.size.width;
		yRatio = (float)size.height/focusInfo.imageRect.size.height;
		for(i = 0; i < focusInfo.pointNumber; i++)
		{
			outFocusInfo->focusPoint[i].rect.point.x = (EdsUInt32)(focusInfo.focusPoint[i].rect.point.x * xRatio);
			outFocusInfo->focusPoint[i].rect.point.y = (EdsUInt32)(focusInfo.focusPoint[i].rect.point.y * yRatio);
			outFocusInfo->focusPoint[i].rect.size.width = (EdsUInt32)(focusInfo.focusPoint[i].rect.size.width * xRatio);
			outFocusInfo->focusPoint[i].rect.size.height = (EdsUInt32)(focusInfo.focusPoint[i].rect.size.height * yRatio);
		}
	}
	return err;
}
@end