//
//  TopicContainerParser.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-3.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TopicContainerParser.h"
#import "Topic.h"

@implementation TopicContainerParser

-(ElementsContainer*)parse:(NSData*)data{
    
    ElementsContainer*result=[[ElementsContainer alloc]init];
    result.pageIndex=0;
    result.pageSize=12;
    for (NSInteger indx=0; indx<result.pageSize; indx++) {
        Topic*tp=[Topic fakeTopic:indx];
        [result.elementArray addObject:tp];
    }
    return result;
}

@end
