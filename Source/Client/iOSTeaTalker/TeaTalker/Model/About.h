//
//  About.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-22.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface About : NSObject{
    
}

@property(nonatomic,strong)NSString*text;
@property(nonatomic,strong)ResultState*resultState;

+(About*)fakeAbout;

@end
