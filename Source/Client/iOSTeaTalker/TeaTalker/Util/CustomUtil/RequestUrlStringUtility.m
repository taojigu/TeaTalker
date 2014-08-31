//
//  RequestUrlStringUtility.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "RequestUrlStringUtility.h"

@implementation RequestUrlStringUtility

+(NSString*)teaCategoryURLString{
    return @"http://www.163.com";
}

+(NSString*)topicUrlString:(NSString*)speciesId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    return  @"http://www.baidu.com";
}

+(NSString*)recommandTopicReqeustUrl:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    return @"http://www.163.com";
}
@end
