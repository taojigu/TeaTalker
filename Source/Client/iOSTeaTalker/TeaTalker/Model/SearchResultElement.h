//
//  SearchResultElement.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-29.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SearchResultTypeTopic=1,
    SearchResultTypeSpecies=2
} SearchResultType;

@interface SearchResultElement : NSObject{
    
}

@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*introduction;
@property(nonatomic,strong)NSString*resultID;
@property(nonatomic,strong)NSString*imageUrl;
@property(nonatomic,assign)SearchResultType resultType;
@property(nonatomic,assign)NSString*urlString;


+(SearchResultElement*)fakeSearchResult:(NSInteger)index;

@end

NSString* NSStringFromSearchType(SearchResultType searchType);
