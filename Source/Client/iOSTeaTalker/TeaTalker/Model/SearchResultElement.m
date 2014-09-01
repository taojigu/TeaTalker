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
@synthesize urlString;


+(SearchResultElement*)fakeSearchResult:(NSInteger)index{
    
    SearchResultElement*sre=[[SearchResultElement alloc]init];
    sre.title=[NSString stringWithFormat:@"SearchResultTitle%li",(long)index];
    if (2>=index) {
        sre.resultType=SearchResultTypeSpecies;
        sre.urlString=@"http://www.163.com";
    }
    else{
        sre.resultType=SearchResultTypeTopic;
        sre.urlString=@"http://mp.weixin.qq.com/s?__biz=MjM5OTUxNjEyMA==&mid=200389855&idx=1&sn=8fd781f7e35a689213a806212b9639d8&key=47e44c9144a8c833a9d37ab696ee4cef8ec983dad5b89c00b328cc029240038d33b2c03c4be692ec8df70a1b5fea7ae2&ascene=0&uin=Mjc4NjY4MDg4MA%3D%3D&pass_ticket=U%2FweRj%2FLWF%2Fm8Bs8Qnc3AFxomNl1ySv9LDeECtw3MZnctwIi2gY2yMIordjby6y7";
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