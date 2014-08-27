//
//  TeaTopicManager.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-27.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TopicDataManager.h"

@interface TeaTopicManager : NSObject<TopicDataManager>{
    
}

@property(nonatomic,strong)ElementsContainer* topicElementContainer;

-(NSString*)pageRequestUrlString:(NSInteger)pageIndex;
-(NSString*)pageRequestUrlString:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;



@end
