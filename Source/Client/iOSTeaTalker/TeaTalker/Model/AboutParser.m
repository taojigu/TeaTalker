//
//  AboutParser.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-23.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "AboutParser.h"
#import "About.h"



@implementation AboutParser

-(About*)parse:(NSData*)data{
    return [About fakeAbout];
}

@end
