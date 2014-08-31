//
//  SearchResultElement.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-29.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SearchResultElement.h"

@implementation SearchResultElement{
    
}

@synthesize title;
@synthesize introduction;
@synthesize resultID;
@synthesize resultType;
@synthesize imageUrl;


+(SearchResultElement*)fakeSearchResult:(NSInteger)index{
    
    SearchResultElement*sre=[[SearchResultElement alloc]init];
    sre.title=[NSString stringWithFormat:@"SearchResultTitle%li",(long)index];
    if (2>=index) {
        sre.resultType=SearchResultTypeSpecies;
    }
    else{
        sre.resultType=SearchResultTypeTopic;
    }
    return sre;
}

@end

NSString* NSStringFromSearchType(SearchResultType searchType){
    switch (searchType) {
        case SearchResultTypeTopic:
            return @"话题";
            //break;
        case SearchResultTypeSpecies:
            return @"种类";
        default:
            return @"Unknown";
    }
};