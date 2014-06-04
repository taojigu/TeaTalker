//
//  ContentObject.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-4.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ContentObject.h"
#import "ImageInfo.h"

@implementation ContentObject

@synthesize contentId;
@synthesize type;
@synthesize title;
@synthesize text;
@synthesize imageInfo;

-(id)init{
    self=[super init];
    self.type=ContentObjectTypeImageInfo;
    return self;
}


@end
