//
//  TeaCategoryArrayParser.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TeaCategoryArrayParser.h"
#import "ElementsContainer.h"
#import "TeaCategory.h"

@implementation TeaCategoryArrayParser


-(NSMutableArray*)parse:(NSData*)data{
    NSMutableArray*array=[[NSMutableArray alloc]init];
    for(NSInteger teaIndex=0;teaIndex<6;teaIndex++){
        TeaCategory*teacatgr=[TeaCategory fakeTeaCategory:teaIndex];
        [array addObject:teacatgr];
    }
    return array;
}

@end
