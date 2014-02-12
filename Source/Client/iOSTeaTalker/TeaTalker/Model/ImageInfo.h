//
//  ImageInfo.h
//  HeartTrace
//
//  Created by user on 14-1-3.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageInfo : NSObject{
    
}

@property(nonatomic,strong)NSString*imageId;
@property(nonatomic,strong)NSString*imageName;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)NSString*imageUrlString;
@property(nonatomic,strong)NSString*introduction;
@property(nonatomic,strong)UIImage*image;


+(ImageInfo*)fakeImageInfo:(NSInteger)imageIndex;
+(ImageInfo*)imageInfoFromImage:(UIImage*)image;
@end
