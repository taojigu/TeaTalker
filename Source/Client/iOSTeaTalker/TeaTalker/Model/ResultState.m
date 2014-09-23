//
//  ResultState.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-22.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ResultState.h"

@implementation ResultState{
    
}
@synthesize resultCode;
@synthesize resultText;


+(ResultState*)fakeFailedState{
    ResultState*st=[[ResultState alloc]init];
    st.resultCode=ResultCodeFailed;
    st.resultText=@"Result is failed";
    return st;
}
+(ResultState*)fakeSuccessState{
    
    ResultState*st=[[ResultState alloc]init];
    st.resultCode=ResultCodeSuccess;
    st.resultText=@"Successful Return the result";
    
    return st;
}

@end
