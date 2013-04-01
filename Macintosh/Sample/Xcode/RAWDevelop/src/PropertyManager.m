#import "PropertyManager.h"
#import "EDSDKController.h"

@interface PropertyManager (PrivateUtility)
-(const NSString*)getPropertySetting:(STR_ID_TABLE*)inTable :(int)count :(EdsPropertyID)propID;
-(NSString*)getMakerName;
-(NSString*)getProductName;
-(NSString*)getDateTime;
-(NSString*)getTv;
-(NSString*)getAv;
-(NSString*)getISO;
-(NSString*)getFocalLength;
-(NSString*)getLensName;
-(NSString*)getBodyID;
-(NSString*)getOwnerName;
-(NSString*)getFirmwareVersion;
-(NSString*)getJPEGQuality;
-(NSString*)getOrientation;
-(NSString*)getAEMode;
-(NSString*)getDriveMode;
-(NSString*)getMeteringMode;
-(NSString*)getAFMode;
-(NSString*)getExposureCompensation;
-(NSString*)getDigitalExposure;
-(NSString*)getFlashCompensation;
-(NSString*)getBracket;
-(NSString*)getWhiteBalance;
-(NSString*)getWhiteBalanceShift;
-(NSString*)getSharpness;
-(NSString*)getColorSaturation;
-(NSString*)getColorMatrix;
-(NSString*)getColorContrast;
-(NSString*)getColorTone;
-(NSString*)getColorSpace;
-(NSString*)getPhotoEffect;
-(NSString*)getFilterEffect;
-(NSString*)getToningEffect;
-(NSString*)getToneCurve;
-(NSString*)getPictureStyle;
-(NSString*)getFlashOn;
-(NSString*)getFlashMode;
-(NSString*)getRedEye;
-(NSString*)getNoiseReduction;
-(NSString*)getGPSVersion;
-(NSString*)getGPSLatitude;
-(NSString*)getGPSLongitude;
-(NSString*)getAltitude;
-(NSString*)getGPSDateStamp;
-(NSString*)getGPSTimeStamp;
-(NSString*)getGPSMapDatum;
-(NSString*)getGPSSatellites;
@end

@implementation PropertyManager

-(NSString*)getPropertyString:(EdsPropertyID)inPropertyID
{
	NSString * string = nil;
	
	switch(inPropertyID)
	{
	case kEdsPropID_MakerName:
		string = [self getMakerName];
		break;
	case kEdsPropID_ProductName:
		string = [self getProductName];
		break;
	case kEdsPropID_DateTime:
		string = [self getDateTime];
		break;
	case kEdsPropID_Tv:
		string = [self getTv];
		break;
	case kEdsPropID_Av:
		string = [self getAv];
		break;
	case kEdsPropID_ISOSpeed:
		string = [self getISO];
		break;
	case kEdsPropID_FocalLength:
		string = [self getFocalLength];
		break;
	case kEdsPropID_LensName:
		string = [self getLensName];
		break;
	case kEdsPropID_BodyIDEx:
		string = [self getBodyID];
		break;
	case kEdsPropID_OwnerName:
		string = [self getOwnerName];
		break;
	case kEdsPropID_FirmwareVersion:	
		string = [self getFirmwareVersion];
		break;
	case kEdsPropID_JpegQuality:
		string = [self getJPEGQuality];
		break;
	case kEdsPropID_Orientation:
		string = [self getOrientation];
		break;
	case kEdsPropID_AEMode:
		string = [self getAEMode];
		break;
	case kEdsPropID_DriveMode:
		string = [self getDriveMode];
		break;
	case kEdsPropID_MeteringMode:
		string = [self getMeteringMode];
		break;
	case kEdsPropID_AFMode:
		string = [self getAFMode];
		break;
	case kEdsPropID_ExposureCompensation:
		string = [self getExposureCompensation];
		break;
	case kEdsPropID_DigitalExposure:
		string = [self getDigitalExposure];
		break;
	case kEdsPropID_FlashCompensation:
		string = [self getFlashCompensation];
		break;
	case kEdsPropID_Bracket:
		string = [self getBracket];
		break;
	case kEdsPropID_WhiteBalance:
		string = [self getWhiteBalance];
		break;
	case kEdsPropID_WhiteBalanceShift:
		string = [self getWhiteBalanceShift];
		break;
	case kEdsPropID_Sharpness:
		string = [self getSharpness];
		break;
	case kEdsPropID_ColorSaturation:
		string = [self getColorSaturation];
		break;
	case kEdsPropID_ColorMatrix:
		string = [self getColorMatrix];
		break;
	case kEdsPropID_Contrast:
		string = [self getColorContrast];
		break;
	case kEdsPropID_ColorTone:
		string = [self getColorTone];
		break;
	case kEdsPropID_ColorSpace:
		string = [self getColorSpace];
		break;
	case kEdsPropID_PhotoEffect:
		string = [self getPhotoEffect];
		break;
	case kEdsPropID_FilterEffect:
		string = [self getFilterEffect];
		break;
	case kEdsPropID_ToningEffect:
		string = [self getToningEffect];
		break;
	case kEdsPropID_ToneCurve:
		string = [self getToneCurve];
		break;
	case kEdsPropID_PictureStyle:
		string = [self getPictureStyle];
		break;
	case kEdsPropID_FlashOn:
		string = [self getFlashOn];
		break;
	case kEdsPropID_FlashMode:
		string = [self getFlashMode];
		break;
	case kEdsPropID_RedEye:
		string = [self getRedEye];
		break;
	case kEdsPropID_NoiseReduction:
		string = [self getNoiseReduction];
		break;
	case kEdsPropID_GPSVersionID:
		string = [self getGPSVersion];
		break;
	case kEdsPropID_GPSLatitude:
		string = [self getGPSLatitude];
		break;
	case kEdsPropID_GPSLongitude:
		string = [self getGPSLongitude];
		break;
	case kEdsPropID_GPSAltitude:
		string = [self getAltitude];
		break;
	case kEdsPropID_GPSDateStamp:
		string = [self getGPSDateStamp];
		break;
	case kEdsPropID_GPSTimeStamp:
		string = [self getGPSTimeStamp];
		break;
	case kEdsPropID_GPSMapDatum:
		string = [self getGPSMapDatum];
		break;
	case kEdsPropID_GPSSatellites:
		string = [self getGPSSatellites];
		break;
	default:
		break;
	}
	return string;
}

-(NSString*)getImageInfoString:(EdsImageSource)inImageSource
{
	NSString *infoString = nil;
	EdsImageInfo	imgInfo = {0};
	
	switch(inImageSource)
	{
	case kEdsImageSrc_RAWThumbnail:
		imgInfo = [m_EDSDKController thumbnailRAWImageInfo];
		infoString = [[NSString alloc] initWithFormat:@"%s:%dx%d %dbit\n","Thumbnail", imgInfo.width, imgInfo.height, imgInfo.componentDepth];
		break;
	case kEdsImageSrc_RAWFullView:
		imgInfo = [m_EDSDKController fullviewRAWImageInfo];
		infoString = [[NSString alloc] initWithFormat:@"%s:%dx%d %dbit\n","FullView", imgInfo.width, imgInfo.height, imgInfo.componentDepth];
		break;
	default:
		break;
	}
	return [infoString autorelease];
}

@end

@implementation PropertyManager (PrivateUtility)
-(const NSString*)getPropertySetting:(STR_ID_TABLE*)inTable :(int)count :(EdsPropertyID)propID
{
	const NSString * retString = @"Unknown";
	int i = 0;
	
	for(i = 0; i < count; i++)
	{
		if(inTable[i].value == propID)
		{
			retString = inTable[i].string;
			break;
		}
	}
	return retString;
}

// Maker Name
-(NSString*)getMakerName
{
	NSString *propString = nil;
	EdsChar value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_MakerName:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n","MakerName",value];
	}
	return [propString autorelease];
}

// Product Name
-(NSString*)getProductName
{
	NSString *propString = nil;
	char value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ProductName:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n","ProductName", value];
	}
	return [propString autorelease];
}

// Date Time
-(NSString *)getDateTime
{
	NSString *propString = nil;
	EdsTime time;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_DateTime:0:sizeof(time):&time])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%02d/%02d/%04d %02d:%02d\n" , "Date Time", time.month,time.day,time.year,time.hour,time.minute];
	}
	return [propString autorelease];
}

// Tv
-(NSString *)getTv
{
	NSString *propString = nil;
	EdsRational rational;	
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_Tv:0:sizeof(rational):&rational])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d/%d\n", "Tv", rational.numerator , rational.denominator];
	}
	return [propString autorelease];
}

// Av
-(NSString *)getAv
{
	NSString *propString = nil;
	EdsRational rational;	
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_Av:0:sizeof(rational):&rational])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:F%.1f\n"  , "Av", (double)rational.numerator/rational.denominator];
	}
	return [propString autorelease];
}

// ISO
-(NSString*)getISO
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ISOSpeed:0:sizeof(uValue):&uValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d\n", "ISO", uValue];
	}
	return [propString autorelease];
}

// FocalLength
-(NSString*)getFocalLength
{
	NSString *propString = nil;
	EdsRational rational;	
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_FocalLength:0:sizeof(rational):&rational])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%.1fmm\n" , "Focal Length", (double)rational.numerator/rational.denominator];
	}
	return [propString autorelease];
}

// Lens Name
-(NSString*)getLensName
{
	NSString *propString = nil;
	EdsChar value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_LensName:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n","Lens Name", value];
	}
	return [propString autorelease];
}

// Body ID
-(NSString*)getBodyID
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_BodyIDEx:0:sizeof(uValue):&uValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%010d\n", "Body ID", uValue];
	}
	return [propString autorelease];
}

// Owner Name
-(NSString*)getOwnerName
{
	NSString *propString = nil;
	EdsChar value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_OwnerName:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n","Owner Name", value];
	}
	return [propString autorelease];
}

// FirmwareVersion
-(NSString*)getFirmwareVersion
{
	NSString *propString = nil;
	EdsChar value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_FirmwareVersion:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n", "FirmwareVersion", value];
	}
	return [propString autorelease];
}

// Jpeg Quality
-(NSString*)getJPEGQuality
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_JpegQuality:0:sizeof(uValue):&uValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d\n","JPEG Quality", uValue];
	}
	return [propString autorelease];
}

// Orientation
-(NSString*)getOrientation
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_Orientation:0:sizeof(uValue):&uValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d\n","Orientation", uValue];
	}
	return [propString autorelease];
}

// AE Mode
-(NSString*)getAEMode
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_AEMode:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Program AE",					0, 
			@"Shutter-Speed Priority AE",	1, 
			@"Aperture Priority AE",		2, 
			@"Manual Exposure",				3, 
			@"Bulb",						4, 
			@"Auto Depth-of-Field AE AE",	5, 
			@"Depth-of-Field  AE",			6, 
			@"Auto",						9, 
			@"Night Scene Portrait",		10,
			@"Sports",						11,
			@"Portrait",					12,
			@"Landscape",					13,
			@"Close-Up",					14,
			@"Flash Off",					15,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n","AE Mode", tmpString];
	}
	return [propString autorelease];
}

// Drive Mode
-(NSString*)getDriveMode
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_DriveMode:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Single-Frame Shooting",			0x00,
			@"Continuous Shooting",				0x01,
			@"High-Speed Continuous Shooting",	0x04,
			@"Low-Speed Continuous Shooting",	0x05,
			@"Silent single shooting",			0x06,
			@"Custom Self-Timer",				0x07,
			@"10-Sec Self-Timer",				0x10,
			@"2-Sec Self-Timer",				0x11,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n","Drive Mode", tmpString];
	}
	return [propString autorelease];
}

// Metering Mode
-(NSString*)getMeteringMode
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_MeteringMode:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Spot metering",						1,
			@"Evaluative metering",					3,
			@"Partial metering",					4,
			@"Center-weighted averaging metering",	5,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n","Metering Mode", tmpString];
	}
	return [propString autorelease];
}

// AF Mode
-(NSString*)getAFMode
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_AFMode:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"One-Shot AF",		0,
			@"AI Servo AF",		1,
			@"AI Focus AF",		2,
			@"Manual Focus",	3,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n","AF Mode", tmpString];
	}
	return [propString autorelease];
}

// Exposure Compensation
-(NSString *)getExposureCompensation
{
	NSString *propString = nil;
	EdsRational rational;	
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ExposureCompensation:0:sizeof(rational):&rational])
	{
		if(rational.numerator==0)
			propString = [[NSString alloc] initWithFormat:@"%s:%d\n" , "Exposure Compensation", rational.numerator];
		else
			propString = [[NSString alloc] initWithFormat:@"%s:%d/%d\n" , "Exposure Compensation", rational.numerator, rational.denominator];
	}
	return [propString autorelease];
}

// Digital Exposure
-(NSString *)getDigitalExposure
{
	NSString *propString = nil;
	EdsRational rational;	
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_DigitalExposure:0:sizeof(rational):&rational])
	{
		if(rational.numerator==0)
			propString = [[NSString alloc] initWithFormat:@"%s:%d\n" , "Digital Exposure", rational.numerator];
		else
			propString = [[NSString alloc] initWithFormat:@"%s:%d/%d\n" , "Digital Exposure",  rational.numerator, rational.denominator];
	}
	return [propString autorelease];
}

// Flash Compensation
-(NSString*)getFlashCompensation
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_FlashCompensation:0:sizeof(uValue):&uValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d\n","Flash Compensation", uValue];
	}
	return [propString autorelease];
}

// Bracket
-(NSString*)getBracket
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_Bracket:0:sizeof(uValue):&uValue])
	{
		EdsRational rational;	
		switch(uValue)
		{
		case 1:
			{
				if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_AEBracket:0:sizeof(rational):&rational])
				{
					if(rational.numerator==0)
						propString = [[NSString alloc] initWithFormat:@"%s:%d\n" , "AE bracket", rational.numerator];
					else
						propString = [[NSString alloc] initWithFormat:@"%s:%d/%d\n" , "AE bracket", rational.numerator, rational.denominator];
				}
				break;
			}
		case 2:
			{
				if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ISOBracket:0:sizeof(rational):&rational])
				{
					if(rational.numerator==0)
						propString = [[NSString alloc] initWithFormat:@"%s:%d\n" , "ISO bracket", rational.numerator];
					else
						propString = [[NSString alloc] initWithFormat:@"%s:%d\n" , "ISO bracket", rational.numerator, rational.denominator];
				}
				break;
			}
		case 3:
			{
				EdsInt32 WbBrakcet[3];
				EdsDataType	type;
				EdsUInt32	size;	
				if(EDS_ERR_OK != [m_EDSDKController getPropertySize:kEdsPropID_WhiteBalanceBracket:0:&type:&size])	break;
				if(EDS_ERR_OK != [m_EDSDKController getPropertyData:kEdsPropID_WhiteBalanceBracket:0:size:WbBrakcet])	break;

				propString = [[NSString alloc] initWithFormat:@"%s:%d\n" , "WB bracket mode", WbBrakcet[0]];

				switch(WbBrakcet[0])
				{
				case 1:	
					propString = [[NSString alloc] initWithFormat:@"%s:%d\nAB%s:%d\n" , "WB bracket mode", WbBrakcet[0],WbBrakcet[1]];	break;
				case 2:	
					propString = [[NSString alloc] initWithFormat:@"%s:%d\nGM%s:%d\n" , "WB bracket mode", WbBrakcet[0],WbBrakcet[1]];	break;
				case 0:
					propString = [[NSString alloc] initWithFormat:@"%s:%d\n  %s:off\n" , "WB bracket mode", WbBrakcet[0]];	break;
				default:
					break;
				}
				break;
			}
		case 4:
			{
				if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ISOBracket:0:sizeof(rational):&rational])
				{
					if(rational.numerator==0)
						propString = [[NSString alloc] initWithFormat:@"%s:%d\n" , "FE bracket", rational.numerator];
					else
						propString = [[NSString alloc] initWithFormat:@"%s:%d/%d\n" , "FE bracket", rational.numerator, rational.denominator];
				}
				break;
			}
		default:
			{
				break;
			}
		}

	}
	return [propString autorelease];
}

// White Balance
-(NSString*)getWhiteBalance
{
	NSString *propString = nil;
	EdsInt32 sValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_WhiteBalance|kEdsPropID_AtCapture_Flag:0:sizeof(sValue):&sValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Auto",						0,
			@"Daylight",					1,
			@"Cloudy",						2,
			@"Tungsten",					3,
			@"Fluorescent",					4,
			@"Flash",						5,
			@"Manual",						6,
			@"Shade",						8,
			@"Color temperature",			9,
			@"Custom white balance: PC-1",	10,
			@"Custom white balance: PC-2",	11,
			@"Custom white balance: PC-3",	12,
			@"Manual 2",					15,
			@"Manual 3",					16,
			@"Manual 4",					15,
			@"Manual 5",					19,
			@"Custom white balance: PC-4",	20,
			@"Custom white balance: PC-5",	21,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)sValue];
		if(sValue == 9)
		{
			EdsUInt32	uValue;
			if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ColorTemperature|kEdsPropID_AtCapture_Flag:0:sizeof(uValue):&uValue])
				propString = [[NSString alloc] initWithFormat:@"%s:%@\n %s: %d K","White Balance", tmpString, uValue];
		}
		else
		{
			propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "White Balance", tmpString];
		}
	}
	return [propString autorelease];
}

// White Balance Shift
-(NSString*)getWhiteBalanceShift
{
	NSString *propString = nil;
	EdsInt32 wbShift[2];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_WhiteBalanceShift|kEdsPropID_AtCapture_Flag:0:sizeof(wbShift):&wbShift])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:AB %d GM %d\n", "White Balance Shift", wbShift[0], wbShift[1]];
	}
	return [propString autorelease];
}

// Sharpness
-(NSString*)getSharpness
{
	NSString *propString = nil;
	char value[256] = {0};
	char productName[256] = {0};
	if(EDS_ERR_OK != [m_EDSDKController getPropertyData:kEdsPropID_ProductName:0:sizeof(productName):productName])	return;

	if(!strcmp("EOS-1D", productName) ||
		!strcmp("EOS-1Ds", productName))
	{
		EdsUInt32	sharpness[2];
		STR_ID_TABLE propCaptions[] = {
			@"Off",			0,
			@"Rough",		1,
			@"Mid. rough",	2,
			@"Standard",	3,
			@"Mid. fine",	4,
			@"Fine",		5,
		};
		if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_Sharpness|kEdsPropID_AtCapture_Flag:0:sizeof(sharpness):sharpness])
		{
			const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)sharpness[1]];
			propString = [[NSString alloc] initWithFormat:@"%s:level:%d target:%@\n", "Sharpness", sharpness[0], tmpString];
		}
	}
	else
	{
		EdsUInt32 sharpness;
		if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_Sharpness|kEdsPropID_AtCapture_Flag:0:sizeof(sharpness):&sharpness])
		{
			propString = [[NSString alloc] initWithFormat:@"%s:%d\n", "Sharpness", sharpness];
		}
	}
	return [propString autorelease];
}

// Color Saturation
-(NSString*)getColorSaturation
{
	NSString *propString = nil;
	EdsInt32 sValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ColorSaturation|kEdsPropID_AtCapture_Flag:0:sizeof(sValue):&sValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Low",			-2,
			@"Mid. low",	-1,
			@"Standard",	0,
			@"Mid. High",	1,
			@"High",		2,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)sValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Color Saturation", tmpString];
	}
	return [propString autorelease];
}

// Color Matrix
-(NSString*)getColorMatrix
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ColorMatrix|kEdsPropID_AtCapture_Flag:0:sizeof(uValue):&uValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d\n", "Color Matrix", uValue];
	}
	return [propString autorelease];
}

// Color Contrast
-(NSString*)getColorContrast
{
	NSString *propString = nil;
	EdsInt32 sValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_Contrast|kEdsPropID_AtCapture_Flag:0:sizeof(sValue):&sValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Low",			-2,
			@"Mid. low",	-1,
			@"Standard",	0,
			@"Mid. High",	1,
			@"High",		2,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)sValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Color Contrast", tmpString];
	}
	return [propString autorelease];
}

// Color Tone
-(NSString*)getColorTone
{
	NSString *propString = nil;
	EdsInt32 sValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ColorTone|kEdsPropID_AtCapture_Flag:0:sizeof(sValue):&sValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d\n", "Color Tone", sValue];
	}
	return [propString autorelease];
}

// Color Space
-(NSString*)getColorSpace
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ColorSpace|kEdsPropID_AtCapture_Flag:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"sRGB",		1,
			@"Adobe RGB",	2,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Color Space", tmpString];
	}
	return [propString autorelease];
}

// Photo Effect
-(NSString*)getPhotoEffect
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_PhotoEffect|kEdsPropID_AtCapture_Flag:0:sizeof(uValue):&uValue])
	{
		if(uValue==5)
		{
			propString = [[NSString alloc] initWithFormat:@"%s:%s\n", "Photo Effect", "Black and White"];
		}
	}
	return [propString autorelease];
}

// Filter Effect
-(NSString*)getFilterEffect
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_FilterEffect|kEdsPropID_AtCapture_Flag:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"None",	0,
			@"Yellow",	1,
			@"Orange",	2,
			@"Red",		3,
			@"Green",	4,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Filter Effect", tmpString];
	}
	return [propString autorelease];
}

// Toning Effect
-(NSString*)getToningEffect
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ToningEffect|kEdsPropID_AtCapture_Flag:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"None",	0,
			@"Speia",	1,
			@"Blue",	2,
			@"Violet",	3,
			@"Gteen",	4,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Toning Effect", tmpString];
	}
	return [propString autorelease];
}

// Tone Curve
-(NSString*)getToneCurve
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_ToneCurve:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Standard",			0x00,
			@"User setting",		0x11,
			@"Custom setting",		0x80,
			@"TCD1",				0x01,
			@"TCD2",				0x02,
			@"TCD3",				0x03,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Tone Curve", tmpString];

	}
	return [propString autorelease];
}

// PictureStyle
-(NSString*)getPictureStyle
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	NSString *value = nil;
	NSString *desc = nil;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_PictureStyle|kEdsPropID_AtCapture_Flag:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Standard",		0x81,
			@"Portrait",		0x82,
			@"Landscape",		0x83,
			@"Neutral",			0x84,
			@"Faithful",		0x85,
			@"Monochrome",		0x86,
			@"Auto",			0x87,
			@"User Setting 1",	0x21,
			@"User Setting 2",	0x22,
			@"User Setting 3",	0x23,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];

		if(uValue&0x20)
		{
			// Picture Style Caption
			EdsChar name[64] ={0};
			if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_PictureStyleCaption:0:sizeof(name):&name])
			value = [[[NSString alloc]  initWithFormat:@"%s:%@(%s)\n", "Picture Style", tmpString, name] autorelease];
		}
		else
			value = [[[NSString alloc]  initWithFormat:@"%s:%@\n", "Picture Style", tmpString] autorelease];
		// Picture Style Desc
		EdsPictureStyleDesc psDesc;
		if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_PictureStyleDesc|kEdsPropID_AtCapture_Flag:0:sizeof(psDesc):&psDesc])
		{
			if(uValue!=kEdsPictureStyle_Monochrome)
			{
				desc = [[[NSString alloc]  initWithFormat:@"%s:%d\n%s:%d\n%s:%d\n%s:%d\n",
						 "Contrast", psDesc.contrast,
						 "Sharpness", psDesc.sharpness, 
						 "Saturation", psDesc.saturation, 
						 "ColorTone", psDesc.colorTone] autorelease];	
			}
			else
			{
				STR_ID_TABLE propCaptions[] = {
					@"None",	0,
					@"Yellow",	1,
					@"Orange",	2,
					@"Red",		3,
					@"Green",	4,
				};
				const NSString * filterEffect = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int) psDesc.saturation];
				
				STR_ID_TABLE propCaptions2[] = {
					@"None",	0,
					@"Sepia",	1,
					@"Blue",	2,
					@"Violet",	3,
					@"Green",	4,
					
				};
				const NSString * toningEffect = [self getPropertySetting:propCaptions2 :sizeof(propCaptions2)/sizeof(STR_ID_TABLE) :(int)psDesc.colorTone];

				desc = [[[NSString alloc]  initWithFormat:@"%s:%d\n%s:%d\n%s:%@\n%s:%@\n",
						 "Contrast", psDesc.contrast,
						 "Sharpness", psDesc.sharpness, 
						 "Filter Effect", filterEffect, 
						 "Toning Effect", toningEffect] autorelease];	
			}
		}
		propString = [[NSString alloc] initWithFormat:@"%@%@", value, desc];
	}
	return [propString autorelease];
}

// Flash On
-(NSString*)getFlashOn
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_FlashOn:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Off",	0,
			@"On",	1,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Flash On", tmpString];
	}
	return [propString autorelease];
}

// Flash Mode
-(NSString*)getFlashMode
{
	NSString *propString = nil;
	EdsUInt32	flashMode[2];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_FlashMode:0:sizeof(flashMode):&flashMode])
	{
		STR_ID_TABLE propCaptions1[] = {
			@"None",				0,
			@"Internal",			1,
			@"external E-TTL",		2,
			@"external A-TTL",		3,
		};
		const NSString * flashmode = [self getPropertySetting:propCaptions1 :sizeof(propCaptions1)/sizeof(STR_ID_TABLE) :(int)flashMode[0]];
		STR_ID_TABLE propCaptions2[] = {
			@"1st Curtain Syncro",	0,
			@"2nd Curtain Syncro",	1,
		};
		const NSString * syncrotiming = [self getPropertySetting:propCaptions2 :sizeof(propCaptions2)/sizeof(STR_ID_TABLE) :(int)flashMode[1]];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n%s:%@\n", "Flash Mode", flashmode, "Syncro Timing", syncrotiming];
	}
	return [propString autorelease];
}

// Red Eye
-(NSString*)getRedEye
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_RedEye:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Off",	0,
			@"On",	1,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Red-eye Reduction", tmpString];
	}
	return [propString autorelease];
}

// Noise Reduction
-(NSString*)getNoiseReduction
{
	NSString *propString = nil;
	EdsUInt32 uValue;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_NoiseReduction:0:sizeof(uValue):&uValue])
	{
		STR_ID_TABLE propCaptions[] = {
			@"Off",		0,
			@"On1",		1,
			@"On2",		2,
			@"On",		3,
			@"Auto",	4,
		};
		const NSString * tmpString = [self getPropertySetting:propCaptions :sizeof(propCaptions)/sizeof(STR_ID_TABLE) :(int)uValue];
		propString = [[NSString alloc] initWithFormat:@"%s:%@\n", "Noise Reduction", tmpString];
	}
	return [propString autorelease];
}

// GPS Version
-(NSString*)getGPSVersion
{
	NSString *propString = nil;
	EdsUInt8 uValue[4];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSVersionID:0:sizeof(uValue):&uValue])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%d.%d.%d.%d\n", "GPS Version ID", uValue[0],uValue[1],uValue[2],uValue[3]];
	}
	return [propString autorelease];
}

// GPS Latitude
-(NSString*)getGPSLatitude
{
	NSString *propString = nil;
	EdsChar latitudeRef;
	EdsUInt8 uValue[4];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSLatitudeRef:0:sizeof(latitudeRef):&latitudeRef])
	{
		EdsRational latitude[3] = {0};
		EdsInt32 s,m,d;
		if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSLatitude:0:sizeof(latitude):&latitude])
		{		
			if( latitude[1].denominator == 1 )
			{
				if(latitude[2].numerator >= 60)
				{
					latitude[1].numerator += (latitude[2].numerator / 60);
					latitude[2].numerator %= 60;
				}
				if(latitude[1].numerator >= 60)
				{
					latitude[0].numerator += (latitude[1].numerator / 60);
					latitude[1].numerator %= 60;
				}
				if(latitude[0].numerator >= 90)
				{
					latitude[2].numerator = 0;
					latitude[1].numerator = 0;
					latitude[0].numerator = 90;
				}
				d = latitude[0].numerator;
				s = latitude[1].numerator;
				s = latitude[2].numerator;
			}
			else
			{
				if( latitude[1].denominator != 0 )
				{
					EdsDouble amari = (EdsDouble)(latitude[1].numerator - (latitude[1].numerator / latitude[1].denominator * latitude[1].denominator));
					s = (EdsInt32)(amari * 60 / latitude[1].denominator + 0.5);
					m = (EdsInt32)latitude[1].numerator / latitude[1].denominator;
					d = (EdsInt32)latitude[0].numerator / latitude[0].denominator;
				
					if(s >= 60)
					{
						m += (s / 60);
						s %= 60;
					}
					if(m >= 60)
					{
						d += (m / 60);
						m %= 60;
					}
					if(d >= 90)
					{
						s = 0;
						m = 0;
						d = 90;
					}
				}
			}
			propString = [[NSString alloc] initWithFormat:@"%s:%d %d %d %c\n", "GPS Latitude", d, m, s, latitudeRef];
		}
	}
	return [propString autorelease];
}

// GPS Longitude
-(NSString*)getGPSLongitude
{
	NSString *propString = nil;
	EdsChar longitudeRef;
	EdsUInt8 uValue[4];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSLongitudeRef:0:sizeof(longitudeRef):&longitudeRef])
	{
		EdsRational longitude[3] = {0};
		EdsInt32 s,m,d;
		if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSLongitude:0:sizeof(longitude):&longitude])
		{		
			if( longitude[1].denominator == 1 )
			{
				if(longitude[2].numerator >= 60)
				{
					longitude[1].numerator += (longitude[2].numerator / 60);
					longitude[2].numerator %= 60;
				}
				if(longitude[1].numerator >= 60)
				{
					longitude[0].numerator += (longitude[1].numerator / 60);
					longitude[1].numerator %= 60;
				}
				if(longitude[0].numerator >= 180)
				{
					longitude[2].numerator = 0;
					longitude[1].numerator = 0;
					longitude[0].numerator = 180;
				}
				d = longitude[0].numerator;
				s = longitude[1].numerator;
				s = longitude[2].numerator;
			}
			else
			{
				if( longitude[1].denominator != 0 )
				{
					EdsDouble amari = (EdsDouble)(longitude[1].numerator - (longitude[1].numerator / longitude[1].denominator * longitude[1].denominator));
					s = (EdsInt32)(amari * 60 / longitude[1].denominator + 0.5);
					m = (EdsInt32)longitude[1].numerator / longitude[1].denominator;
					d = (EdsInt32)longitude[0].numerator / longitude[0].denominator;
				
					if(s >= 60)
					{
						m += (s / 60);
						s %= 60;
					}
					if(m >= 60)
					{
						d += (m / 60);
						m %= 60;
					}
					if(d >= 180)
					{
						s = 0;
						m = 0;
						d = 180;
					}
				}
			}
			propString = [[NSString alloc] initWithFormat:@"%s:%d %d %d %c\n", "GPS Longitude", d, m, s, longitudeRef];
		}
	}
	return [propString autorelease];
}

// Altitude
-(NSString *)getAltitude
{
	NSString *propString = nil;
	EdsChar altitudeRef;
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSAltitudeRef:0:sizeof(altitudeRef):&altitudeRef])
	{
		EdsRational rational;	
		if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSAltitude:0:sizeof(rational):&rational])
		{
			if(rational.denominator!=0)
			{
				if(altitudeRef == 1)
					propString = [[NSString alloc] initWithFormat:@"%s:-%.2fm\n", "GPS Altitude", (EdsFloat)rational.numerator/rational.denominator];
				else
					propString = [[NSString alloc] initWithFormat:@"%s:%.2fm\n", "GPS Altitude",  (EdsFloat)rational.numerator/rational.denominator];
			}
		}
	}
	return [propString autorelease];
}

// Date Stamp
-(NSString*)getGPSDateStamp
{
	NSString *propString = nil;
	EdsChar value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSDateStamp:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n", "GSP Date Stamp", value];
	}
	return [propString autorelease];
}

// Time Stamp
-(NSString*)getGPSTimeStamp
{
	NSString *propString = nil;
	EdsRational timeStamp[3];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSTimeStamp:0:sizeof(timeStamp):timeStamp])
	{
		if(timeStamp[0].denominator != 0 && timeStamp[1].denominator != 0 && timeStamp[2].denominator != 0)
			propString = [[NSString alloc] initWithFormat:@"%s:%02d:%02d:%02d\n", "GSP Time Stamp", timeStamp[0].numerator/ timeStamp[0].denominator , timeStamp[1].numerator/ timeStamp[1].denominator , timeStamp[2].numerator/ timeStamp[2].denominator];
	}
	return [propString autorelease];
}

// GPS Map Datum
-(NSString*)getGPSMapDatum
{
	NSString *propString = nil;
	EdsChar value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSMapDatum:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n", "GSP Map Datum", value];
	}
	return [propString autorelease];
}

// GPS Satellites
-(NSString*)getGPSSatellites
{
	NSString *propString = nil;
	EdsChar value[256];
	if(EDS_ERR_OK == [m_EDSDKController getPropertyData:kEdsPropID_GPSSatellites:0:sizeof(value):value])
	{
		propString = [[NSString alloc] initWithFormat:@"%s:%s\n", "GSP Satellites", value];
	}
	return [propString autorelease];
}

@end
