/******************************************************************************
*                                                                             *
*   PROJECT : EOS Digital Software Development Kit EDSDK                      *
*      NAME : ImageQualityPopUp.m                                                   *
*                                                                             *
*   Description: This is the Sample code to show the usage of EDSDK.          *
*                                                                             *
*                                                                             *
*******************************************************************************
*                                                                             *
*   Written and developed by Camera Design Dept.53                            *
*   Copyright Canon Inc. 2007-2010 All Rights Reserved                        *
*                                                                             *
*******************************************************************************
*   File Update Information:                                                  *
*     DATE      Identify    Comment                                           *
*   -----------------------------------------------------------------------   *
*   06-03-22    F-001        create first version.                            *
*                                                                             *
******************************************************************************/

#import "ImageQualityPopUp.h"
#import "cameraEvent.h"
#import "CameraModel.h"
#import "EDSDK.h"

@interface ImageQualityPopUp (Local)
-(void)initializeData;
@end

@implementation ImageQualityPopUp
- (id)initWithCoder:(NSCoder *)decoder
{
	[super initWithCoder:decoder];
	
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:VIEW_UPDATE_MESSAGE object:nil];
	[self initializeData];
	
	return self;
}

-(void)dealloc
{
	[super dealloc];
}

-(void)update:(NSNotification *)notification
{
	CameraEvent * event;
	CameraModel * model = [notification object];
	NSDictionary* dict = [notification userInfo];
	NSString * command;
	EdsPropertyDesc desc;
	NSNumber * number;
	
	event = [dict objectForKey:@"event"];
	if(event == nil)
	{
		return ;
	}

	command = [event getEvent];
	number = [event getArg];
	//Update property
	if([command isEqualToString:@"PropertyChanged"])
	{
		if([number intValue] == kEdsPropID_ImageQuality)
		{
			[self updateProperty:[model getPropertyUInt32:[number intValue]]];
		}
	}

	//Update of list that can set property
	if([command isEqualToString:@"PropertyDescChanged"])
	{
		if([number intValue] == kEdsPropID_ImageQuality)
		{
			desc = [model getPropertyDesc:[number intValue]];
			[self updatePropertyDesc:&desc];
		}
	}
}

@end

@implementation ImageQualityPopUp (Local)

-(void)initializeData
{
	[self removeAllItems];
	
	// PTP Camera
	_propertyList = [[ NSDictionary alloc] initWithObjectsAndKeys : 
			@"RAW" ,		[NSNumber numberWithInt:EdsImageQuality_LR] , 
			@"RAW + Large Fine Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRLJF] , 
			@"RAW + Large Normal Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_LRLJN] , 
			@"RAW + Middle Fine Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRMJF] , 
			@"RAW + Middle Normal Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_LRMJN] , 
			@"RAW + Small Fine Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRSJF] , 
			@"RAW + Small Normal Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_LRSJN] , 
			@"RAW + Small1 Fine Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRS1JF] , 
			@"RAW + Small1 Normal Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_LRS1JN] , 
			@"RAW + Small2 Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_LRS2JF] , 
			@"RAW + Small3 Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_LRS3JF] , 
					 
			@"RAW + Large Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRLJ] , 
			@"RAW + Middle1 Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRM1J] , 
			@"RAW + Middle2 Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRM2J] , 
			@"RAW + Small Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_LRSJ] , 
					 
			@"Middle RAW(Small RAW1)" ,	[NSNumber numberWithInt:EdsImageQuality_MR] ,
			@"Middle RAW(Small RAW1) + Large Fine Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_MRLJF] , 
			@"Middle RAW(Small RAW1) + Middle Fine Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_MRMJF] , 
			@"Middle RAW(Small RAW1) + Small Fine Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_MRSJF] , 
			@"Middle RAW(Small RAW1) + Large Normal Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_MRLJN] , 
			@"Middle RAW(Small RAW1) + Middle Normal Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_MRMJN] , 
			@"Middle RAW(Small RAW1) + Small Normal Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_MRSJN] , 
			@"Middle RAW + Small1 Fine Jpeg" ,					[NSNumber numberWithInt:EdsImageQuality_MRS1JF] , 
			@"Middle RAW + Small1 Normal Jpeg" ,				[NSNumber numberWithInt:EdsImageQuality_MRS1JN] , 
			@"Middle RAW + Small2 Jpeg" ,						[NSNumber numberWithInt:EdsImageQuality_MRS2JF] , 
			@"Middle RAW + Small3 Jpeg" ,						[NSNumber numberWithInt:EdsImageQuality_MRS3JF] , 
					 
			@"Middle RAW + Large Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_MRLJ] , 
			@"Middle RAW + Middle Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_MRM1J] , 
			@"Middle RAW + Middle Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_MRM2J] , 
			@"Middle RAW + Small Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_MRSJ] , 					 
					 
		    @"Small RAW(Small RAW2)" ,	[NSNumber numberWithInt:EdsImageQuality_SR] ,
			@"Small RAW(Small RAW2) + Large Fine Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_SRLJF] , 
			@"Small RAW(Small RAW2) + Middle Fine Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_SRMJF] , 
			@"Small RAW(Small RAW2) + Small Fine Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_SRSJF] , 
			@"Small RAW(Small RAW2) + Large Normal Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_SRLJN] , 
			@"Small RAW(Small RAW2) + Middle Normal Jpeg" , [NSNumber numberWithInt:EdsImageQuality_SRMJN] , 
			@"Small RAW(Small RAW2) + Small Normal Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_SRSJN] , 					 
			@"Small RAW + Small1 Fine Jpeg" ,				[NSNumber numberWithInt:EdsImageQuality_SRS1JF] , 
			@"Small RAW + Small1 Normal Jpeg" ,				[NSNumber numberWithInt:EdsImageQuality_SRS1JN] , 
			@"Small RAW + Small2 Jpeg" ,					[NSNumber numberWithInt:EdsImageQuality_SRS2JF] , 
			@"Small RAW + Small3 Jpeg" ,					[NSNumber numberWithInt:EdsImageQuality_SRS3JF] , 
					 
			@"Small RAW + Large Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_SRLJ] , 
			@"Small RAW + Middle1 Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_SRM1J] , 
			@"Small RAW + Middle2 Jpeg" ,	[NSNumber numberWithInt:EdsImageQuality_SRM2J] , 
			@"Small RAW + Small Jpeg" ,		[NSNumber numberWithInt:EdsImageQuality_SRSJ] , 
					 
			@"Large Fine Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_LJF] , 
			@"Large Normal Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_LJN] , 
			@"Middle Fine Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_MJF] , 
			@"Middle Normal Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_MJN] , 
			@"Small Fine Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_SJF] , 
			@"Small Normal Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_SJN] , 
			@"Small1 Fine Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_S1JF] , 
			@"Small1 Normal Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_S1JN] , 
			@"Small2 Jpeg" ,				[NSNumber numberWithInt:EdsImageQuality_S2JF] , 
			@"Small3 Jpeg" ,				[NSNumber numberWithInt:EdsImageQuality_S3JF] , 
					 
			@"Large Jpeg" ,				[NSNumber numberWithInt:EdsImageQuality_LJ] , 
			@"Middle1 Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_M1J] , 
			@"Middle2 Jpeg" ,			[NSNumber numberWithInt:EdsImageQuality_M2J] , 
			@"Small Jpeg" ,				[NSNumber numberWithInt:EdsImageQuality_SJ] , 

			// Legacy Camera
			@"RAW" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LR] , 
			@"RAW + Large Fine Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LRLJF] , 
			@"RAW + Middle Fine Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LRMJF] , 
			@"RAW + Small Fine Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LRSJF] , 
			@"RAW + Large Normal Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LRLJN] , 
			@"RAW + Middle Normal Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LRMJN] , 
			@"RAW + Small Normal Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LRSJN] , 
			@"Large Fine Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LJF] , 
			@"Middle Fine Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_MJF] , 
			@"Small Fine Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_SJF] , 
			@"Large Normal Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LJN] , 
			@"Middle Normal Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_MJN] , 
			@"Small Normal Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_SJN] , 

			@"RAW" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LR2] , 
			@"RAW + Large Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LR2LJ] , 

			@"RAW + Middle1 Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LR2M1J] , 
			@"RAW + Middle2 Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LR2M2J] , 
			@"RAW + Small Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LR2SJ] , 
			@"Large Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_LJ] , 
			@"Middle1 Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_M1J] , 
			@"Middle2 Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_M2J] , 
			@"Small Jpeg" , [NSNumber numberWithInt:kEdsImageQualityForLegacy_SJ] , nil];
			
}


@end
