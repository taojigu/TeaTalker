//
//  RequestUrlStringUtility.h
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestUrlStringUtility : NSObject{
    
}

+(NSString*)teaCategoryURLString;
+(NSString*)topicUrlString:(NSString*)speciesId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;
@end
