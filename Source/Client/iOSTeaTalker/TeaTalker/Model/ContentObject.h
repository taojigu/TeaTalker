//
//  ContentObject.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-4.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString* const ContentObjectTypeImageInfo=@"ContentObjectTypeImageInfo";
static NSString* const ContentObjectTypeText=@"ContentObjectTypeText";


@class ImageInfo;

@interface ContentObject : NSObject{
    
}

@property(nonatomic,strong)NSString*contentId;
@property(nonatomic,strong)NSString*type;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*text;
@property(nonatomic,strong)ImageInfo*imageInfo;

@end
