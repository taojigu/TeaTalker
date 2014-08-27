//
//  TeaTopicManager.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-27.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TeaTopicManager.h"

@implementation TeaTopicManager

@synthesize topicElementContainer;

-(id)init{
    self=[super init];
    if (nil!=self) {
        self.topicElementContainer=[[ElementsContainer alloc]init];
    }
    return self;
}

-(NSString*)pageRequestUrlString:(NSInteger)pageIndex{
    return @"http://www.163.com";
}
-(NSString*)pageRequestUrlString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    return @"http://www.baidu.com";
}

@end
