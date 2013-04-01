/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : EDSDKController.m                                               *
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

@interface EDSDKController (PrivateUtilities)

static EdsError EDSCALLBACK progressCallBack(
					EdsUInt32	inPercent,
					EdsVoid *	inContext,
					EdsBool *   outCancel
);

@end

/******************************************************************************
*******************************************************************************
//
//	Public Utilities
//
*******************************************************************************
******************************************************************************/
@implementation EDSDKController
/*-----------------------------------------------------------------------------
//  Function:   awakeFromNib
-----------------------------------------------------------------------------*/
- (void)awakeFromNib
{
	m_isClickWBMode=NO;
	m_useCache=YES;
	m_imageRef=NULL;	
	m_imageSource = kEdsImageSrc_RAWThumbnail;
	// Initialize EDSDK
	EdsInitializeSDK();
}

/*-----------------------------------------------------------------------------
//  Function:   dealloc
-----------------------------------------------------------------------------*/
- (void)dealloc {	
	// Release
	if(m_imageRef) EdsRelease(m_imageRef);	
	// Terminate EDSDK
	EdsTerminateSDK();
	[super dealloc];		
}

/*-----------------------------------------------------------------------------
//  Function:   openNewFile
-----------------------------------------------------------------------------*/
- (EdsError)openNewFile:(NSString*)inFilename
{
	EdsError err=EDS_ERR_OK;
	// Release Previous ImageRef
	if(m_imageRef) EdsRelease(m_imageRef);
	m_imageRef=NULL;
	// Create FileStream
	EdsStreamRef inStream=NULL;			
	err = EdsCreateFileStreamEx(
		(const CFURLRef)[NSURL fileURLWithPath:inFilename],
		kEdsFileCreateDisposition_OpenExisting,
		kEdsAccess_ReadWrite,
		&inStream
	);
	// Create ImageRef
	if(!err)
	err = EdsCreateImageRef( inStream, &m_imageRef );
	// Release Stream
	if(inStream) EdsRelease(inStream);
	
	return err;
}

/*-----------------------------------------------------------------------------
//  Function:   currentImageInfo
-----------------------------------------------------------------------------*/
- (EdsImageInfo)currentImageInfo
{
	EdsError err;
	EdsImageInfo imageInfo={0};
	if(m_imageRef)
		err = EdsGetImageInfo( m_imageRef, m_imageSource, &imageInfo );	
	return imageInfo;
}

/*-----------------------------------------------------------------------------
//  Function:   thumbnailRAWImageInfo
-----------------------------------------------------------------------------*/
- (EdsImageInfo)thumbnailRAWImageInfo
{
	EdsError err;
	EdsImageInfo imageInfo={0};
	if(m_imageRef)
		err = EdsGetImageInfo( m_imageRef, kEdsImageSrc_RAWThumbnail, &imageInfo );	
	return imageInfo;
}

/*-----------------------------------------------------------------------------
//  Function:   fullviewRAWImageInfo
-----------------------------------------------------------------------------*/
- (EdsImageInfo)fullviewRAWImageInfo
{
	EdsError err;
	EdsImageInfo imageInfo={0};
	if(m_imageRef)
		err = EdsGetImageInfo( m_imageRef, kEdsImageSrc_RAWFullView, &imageInfo );	
	return imageInfo;
}

/*-----------------------------------------------------------------------------
//  Function:   imageSource
-----------------------------------------------------------------------------*/
- (EdsImageSource)imageSource { return m_imageSource; }

/*-----------------------------------------------------------------------------
//  Function:   setImageSource
-----------------------------------------------------------------------------*/
- (void)setImageSource:(EdsImageSource)inImageSource { m_imageSource = inImageSource; }

/*-----------------------------------------------------------------------------
//  Function:   getPropertySize
-----------------------------------------------------------------------------*/
- (EdsError)getPropertySize:(EdsPropertyID)inPropertyID:
                                    (EdsInt32)inParam:
                                    (EdsDataType*)outDataType:
                                    (EdsUInt32*)outSize
{
	if(m_imageRef)
		return EdsGetPropertySize( m_imageRef, inPropertyID, inParam, outDataType, outSize );
	else
		return EDS_ERR_FILE_NOT_FOUND;
}	

/*-----------------------------------------------------------------------------
//  Function:   getPropertyData
-----------------------------------------------------------------------------*/
- (EdsError)getPropertyData:(EdsPropertyID)inPropertyID:
                                    (EdsInt32)inParam:
                                    (EdsUInt32)inPropertySize:
                                    (EdsVoid*)outPropertyData
{
	if(m_imageRef)
		return EdsGetPropertyData( m_imageRef, inPropertyID, inParam, inPropertySize, outPropertyData );
	else
		return EDS_ERR_FILE_NOT_FOUND;
}									
/*-----------------------------------------------------------------------------
//  Function:   setPropertyData
-----------------------------------------------------------------------------*/
- (EdsError)setPropertyData:(EdsPropertyID)inPropertyID:
                                    (EdsInt32)inParam:
                                    (EdsUInt32)inPropertySize:
                                    (const EdsVoid*)inPropertyData
{

	if(m_imageRef)
		return EdsSetPropertyData( m_imageRef, inPropertyID, inParam, inPropertySize, inPropertyData );
	else
		return EDS_ERR_FILE_NOT_FOUND;
}									

/*-----------------------------------------------------------------------------
//  Function:   reflectImageProperty
-----------------------------------------------------------------------------*/
- (EdsError)reflectImageProperty
{
	if(m_imageRef)
		return EdsReflectImageProperty(m_imageRef);
	else
		return EDS_ERR_FILE_NOT_FOUND;
}
									
/*-----------------------------------------------------------------------------
//  Function:   processImage
-----------------------------------------------------------------------------*/
- (EdsError)processImage:(EdsRect)inProcessRect:(EdsSize)inDstSize:(EdsStreamRef)outStream
{
	EdsError err = EDS_ERR_OK;
	if(!m_imageRef) return EDS_ERR_FILE_NOT_FOUND;
	if(!err) err = EdsSetProgressCallback( outStream, progressCallBack, kEdsProgressOption_Periodically, NULL );
	// Cache 
//	if(!err) err = EdsCacheImage( m_imageRef, m_useCache );					   
	// Get Image
	if(!err) err = EdsGetImage( m_imageRef, m_imageSource, kEdsTargetImageType_RGB, inProcessRect, inDstSize, outStream );
	if(err) SHOW_ALERT(ALERT_IMAGE_GET);	
	return err;
}

/*-----------------------------------------------------------------------------
//  Function:   isClickWBMode
-----------------------------------------------------------------------------*/
- (EdsBool)isClickWBMode { return m_isClickWBMode; }

/*-----------------------------------------------------------------------------
//  Function:   setClickWBMode
-----------------------------------------------------------------------------*/
- (void)setClickWBMode:(EdsBool)inIsClickWBMode { m_isClickWBMode = inIsClickWBMode; }

/*-----------------------------------------------------------------------------
//  Function:   setUseCache
-----------------------------------------------------------------------------*/
- (void)setUseCache:(EdsBool)inUseCache { m_useCache = inUseCache; }

/*-----------------------------------------------------------------------------
//  Function:   saveImage
-----------------------------------------------------------------------------*/
- (EdsError)saveImage:(EdsTargetImageType)inTargetImageType:
			(NSString*)inSaveFilename:
			(EdsUInt32)inJPEGQuality:
			(NSString*)inColorProfilename
{
	EdsError err = EDS_ERR_OK;
	if(!m_imageRef) return EDS_ERR_FILE_NOT_FOUND;
	// Create Target Stream
	EdsStreamRef targetStream=NULL;
	err = EdsCreateFileStreamEx(
		(const CFURLRef)[NSURL fileURLWithPath:inSaveFilename],
		kEdsFileCreateDisposition_CreateAlways,
		kEdsAccess_Write,
		&targetStream
	);
	// Set SaveImageSetting
	EdsSaveImageSetting saveImageSetting={0};
	saveImageSetting.JPEGQuality = inJPEGQuality;
	// ColorProfile
	EdsStreamRef profileStream=NULL;
	EdsError iccErr;
	iccErr = EdsCreateFileStreamEx(
		(const CFURLRef)[NSURL fileURLWithPath:inColorProfilename],
		kEdsFileCreateDisposition_OpenExisting,
		kEdsAccess_Read,
		&profileStream
	);
	if(!iccErr) saveImageSetting.iccProfileStream = profileStream;
	// Set Callback
	if(!err) err = EdsSetProgressCallback( targetStream, progressCallBack, kEdsProgressOption_Periodically, NULL );					   
	// Save Image
	if(!err) err = EdsSaveImage( m_imageRef, inTargetImageType, saveImageSetting, targetStream );
	// Release
	if(targetStream) EdsRelease(targetStream);
	if(profileStream) EdsRelease(profileStream);
	
	return err;
}
			
@end

/******************************************************************************
*******************************************************************************
//
//	Public Utilities
//
*******************************************************************************
******************************************************************************/
@implementation EDSDKController (PrivateUtilities)
/*-----------------------------------------------------------------------------
//  Function:   progressCallBack
-----------------------------------------------------------------------------*/
static EdsError EDSCALLBACK progressCallBack(
					EdsUInt32	inPercent,
					EdsVoid *	inContext,
					EdsBool *   outCancel
)
{
	// Send Notification
	[[NSNotificationCenter defaultCenter] postNotificationName:
		[NSString stringWithString:NOTIFY_PROGRESS_CALLBACK] object:[NSNumber numberWithInt:inPercent]];	
	return EDS_ERR_OK;
}

@end
