//
//  SearchResultParser.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-31.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SearchResultParser.h"
#import "ElementsContainer.h"
#import "SearchResultElement.h"
#import "ElementsContainer.h"
@implementation SearchResultParser{
    
}

-(ElementsContainer*)parse:(NSData*)data{
    ElementsContainer*result=[[ElementsContainer alloc]init];
    for (NSInteger srIndex=0; srIndex<12; srIndex++) {
        SearchResultElement*sre=[SearchResultElement fakeSearchResult:srIndex];
        [result.elementArray addObject:sre];
        
    }
    
    result.count=12;
    result.pageSize=12;
    return result;
}

@end
