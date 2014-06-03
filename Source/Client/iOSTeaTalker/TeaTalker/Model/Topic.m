//
//  Topic.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "Topic.h"

@implementation Topic


+(Topic*)fakeTopic:(NSInteger)index{
    Topic*tp=[[Topic alloc]init];
    tp.title=[NSString stringWithFormat:@"Topic %li Title",(long)index];
    tp.text=@""
    return tp;
    
}

@end
