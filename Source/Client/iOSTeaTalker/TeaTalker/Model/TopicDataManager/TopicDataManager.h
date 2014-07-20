//
//  TopicDataManager.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-7-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ElementsContainer;

@protocol TopicDataManager <NSObject>

@required
@property(nonatomic,strong)ElementsContainer* topicElementContainer;

-(NSString*)pageRequestUrlString:(NSInteger)pageIndex;
-(NSString*)pageRequestUrlString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;


@end
