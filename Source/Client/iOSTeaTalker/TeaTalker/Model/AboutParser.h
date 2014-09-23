//
//  AboutParser.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-23.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@class About;

@interface AboutParser : NSObject

-(About*)parse:(NSData*)data;

@end
