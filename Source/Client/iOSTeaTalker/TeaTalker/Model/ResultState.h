//
//  ResultState.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-22.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString* const ResultCodeSuccess=@"ResultCodeSuccess";
static NSString* const ResultCodeFailed=@"ResultCodeFailed";

@interface ResultState : NSObject{
    
}

@property(nonatomic,strong)NSString*resultCode;
@property(nonatomic,strong)NSString*resultText;


+(ResultState*)fakeFailedState;
+(ResultState*)fakeSuccessState;

@end
