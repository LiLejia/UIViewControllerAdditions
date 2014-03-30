//
//  HLConst.h
//  UIViewControllerAdditions
//
//  Created by Henry on 14-3-22.
//  Copyright (c) 2014年 Henry. All rights reserved.
//

#ifndef UIViewControllerAdditions_HLConst_h
#define UIViewControllerAdditions_HLConst_h

#define SYSTEM_VERSION  [[UIDevice currentDevice].systemVersion floatValue]
#define IPHONE_5        ([[UIScreen mainScreen] bounds].size.height == 568)
#define iOS5_ABOVE      ([[UIDevice currentDevice].systemVersion floatValue]>=5.0)
#define iOS6_ABOVE      ([[UIDevice currentDevice].systemVersion floatValue]>=6.0)
#define iOS7_ABOVE      ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
#define iPad            ([[UIScreen mainScreen] bounds])

#define kRGBCOLOR(r,g,b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kRGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define DELEGATE_AVAILABLE(delegate,function) (delegate && [delegate respondsToSelector:@selector(function)])

#define ADD_DYNAMIC_PROPERTY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME) \
@dynamic PROPERTY_NAME ; \
static char kProperty##PROPERTY_NAME; \
- ( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
return ( PROPERTY_TYPE ) objc_getAssociatedObject(self, &(kProperty##PROPERTY_NAME ) ); \
} \
\
- (void) SETTER_NAME :( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
objc_setAssociatedObject(self, &kProperty##PROPERTY_NAME , PROPERTY_NAME , OBJC_ASSOCIATION_RETAIN); \
} \

typedef enum
{
	UIDeviceUnknown,
	
    UIDeviceiPod1G,
	UIDeviceiPod2G,
	UIDeviceiPod3G,
    UIDeviceiPod4G,
    UIDeviceiPod5G,
    UIDeviceiPod5GLite, //Without Camera
    
    UIDeviceiPad1G,
    UIDeviceiPad2G,
    UIDeviceiPad3G,
    UIDeviceiPad4G,
    UIDeviceiPadAir,
    UIDeviceiPadMini,
    UIDeviceiPadMini2,
    
	UIDeviceiPhone1G,
	UIDeviceiPhone3G,
	UIDeviceiPhone3GS,
	UIDeviceiPhone4,
    UIDeviceiPhone4S,
	UIDeviceiPhone5,
    UIDeviceiPhone5s,
    
} UIDevicePlatform;

#endif
