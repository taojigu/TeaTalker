//
//  SpeciesTopicManager.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-7-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SpeciesTopicManager.h"

@implementation SpeciesTopicManager

@synthesize topicElementContainer;

-(NSString*)pageRequestUrlString:(NSInteger)pageIndex{
    return @"www.163.com";
}
-(NSString*)pageRequestUrlString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    return @"www.baidu.com";
}



@end
