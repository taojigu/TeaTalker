//
//  SearchResultParser.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-31.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ElementsContainer;

@interface SearchResultParser : NSObject{
    
}

-(ElementsContainer*)parse:(NSData*)data;

@end
