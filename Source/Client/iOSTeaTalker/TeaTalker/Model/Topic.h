//
//  Topic.h
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TopicTypeSpecies=0,
    TopicTypeTeaCategory=1,
    TopicTypeTea=2
} TopicType;

@class ImageInfo;
@interface Topic : NSObject{
    
}

@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*text;
@property(nonatomic,strong)ImageInfo*titleImageInfo;
@property(nonatomic,strong)NSString*author;
@property(nonatomic,strong)NSString*urlString;
@property(nonatomic,strong)NSString*introduction;

+(Topic*)fakeTopic:(NSInteger)index;

@end
