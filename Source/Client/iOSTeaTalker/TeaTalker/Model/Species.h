//
//  Species.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-5-6.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ElementsContainer;

@interface Species : NSObject


@property(nonatomic,strong)NSString*speciesId;
@property(nonatomic,strong)NSString*name;
@property(nonatomic,strong)NSString*introduction;
@property(nonatomic,strong)NSMutableArray*imageInfoArray;
@property(nonatomic,strong)NSString*cookText;
@property(nonatomic,strong)NSMutableArray*cookImageInfoArray;
@property(nonatomic,strong)ElementsContainer*topicContainer;
@property(nonatomic,strong)NSString*urlString;

+(Species*)fakeSpecies:(NSInteger)speciesIndex;

@end
