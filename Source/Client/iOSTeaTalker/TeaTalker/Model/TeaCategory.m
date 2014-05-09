//
//  TeaCategory.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TeaCategory.h"
#import "ElementsContainer.h"
#import "Species.h"
@implementation TeaCategory



@synthesize categoryId;
@synthesize categoryName;
@synthesize species;

-(id)init{
    self=[super init];
    if (self) {
        self.species=[[ElementsContainer alloc]init];
    }
    return self;
}


+(TeaCategory*)fakeTeaCategory:(NSInteger)teaIndex{
    TeaCategory*result=[[TeaCategory alloc]init];
    result.categoryId=[NSString stringWithFormat:@"CategoryId%li",(long)teaIndex];
    result.categoryName=@"绿茶";
    for (NSInteger spcIndex=0; spcIndex<7; spcIndex++) {
        Species*spc=[Species fakeSpecies:spcIndex];
        [result.species.elementArray addObject:spc];
    }
    return result;
}

@end
