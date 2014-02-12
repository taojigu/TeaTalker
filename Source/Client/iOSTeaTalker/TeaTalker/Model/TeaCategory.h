//
//  TeaCategory.h
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ElementsContainer;

@interface TeaCategory : NSObject{
    
}

@property(nonatomic,strong)NSString*categoryName;
@property(nonatomic,strong)NSString*categoryId;
@property(nonatomic,strong)ElementsContainer*species;


+(TeaCategory*)fakeTeaCategory:(NSInteger)teaIndex;


@end
