//
//  TopicContainerParser.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-3.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ElementsContainer;

@interface TopicContainerParser : NSObject


-(ElementsContainer*)parse:(NSData*)data;
@end
