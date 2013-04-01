/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : EDSDKController.h                                               *
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

@interface EDSDKController : NSObject
{
	BOOL m_isClickWBMode;
	BOOL m_useCache;
	EdsImageRef m_imageRef;
	EdsImageSource m_imageSource;
}

- (EdsError)openNewFile:(NSString*)inFilename;
- (EdsImageInfo)currentImageInfo;
- (EdsImageInfo)thumbnailRAWImageInfo;
- (EdsImageInfo)fullviewRAWImageInfo;
- (EdsError)processImage:(EdsRect)inProcessRect:(EdsSize)inDstSize:(EdsStreamRef)outStream;
- (EdsError)reflectImageProperty;
- (EdsError)getPropertySize:(EdsPropertyID)inPropertyID:
                                    (EdsInt32)inParam:
                                    (EdsDataType*)outDataType:
                                    (EdsUInt32*)outSize;
- (EdsError)getPropertyData:(EdsPropertyID)inPropertyID:
                                    (EdsInt32)inParam:
                                    (EdsUInt32)inPropertySize:
                                    (EdsVoid*)outPropertyData;																		
- (EdsError)setPropertyData:(EdsPropertyID)inPropertyID:
                                    (EdsInt32)inParam:
                                    (EdsUInt32)inPropertySize:
                                    (const EdsVoid*)inPropertyData;
- (EdsError)saveImage:(EdsTargetImageType)inTargetImageType:
			(NSString*)inSaveFilename:
			(EdsUInt32)inJPEGQuality:
			(NSString*)inColorProfilename;	
- (EdsImageSource)imageSource;
- (void)setImageSource:(EdsImageSource)inImageSource;
- (EdsBool)isClickWBMode;
- (void)setClickWBMode:(EdsBool)inIsClickWBMode;
- (void)setUseCache:(EdsBool)inUseCache;

@end
