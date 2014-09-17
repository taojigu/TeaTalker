//
//  ImageInfo.m
//  HeartTrace
//
//  Created by user on 14-1-3.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ImageInfo.h"

@implementation ImageInfo


@synthesize imageId;
@synthesize imageName;
@synthesize width;
@synthesize height;
@synthesize imageUrlString;
@synthesize introduction;
@synthesize image;


+(ImageInfo*)fakeImageInfo:(NSInteger)imageIndex{
    ImageInfo*result=[[ImageInfo alloc]init];
    result.imageId=[NSString stringWithFormat:@"ImageId %i",imageIndex];
    result.imageName=[NSString stringWithFormat:@"ImageName %i",imageIndex];
    result.width=80;
    result.height=120;
    result.image=[UIImage imageNamed:DragonWellImageName];
    result.introduction=[NSString stringWithFormat:@"The image introduction for the image %i",imageIndex];

    NSArray*imageUrlStringArray=[ImageInfo sampleImageUrlArray];
    NSInteger index=MIN(imageIndex, [imageUrlStringArray count]-1);
    result.imageUrlString=[imageUrlStringArray objectAtIndex:index];
    return result;
}
+(ImageInfo*)imageInfoFromImage:(UIImage*)image{
    ImageInfo*info=[[ImageInfo alloc]init];
    info.image=image;
    return info;
}
+(NSArray*)sampleImageUrlArray{
    
    NSArray*result= @[@"http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg", @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg", @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg", @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg", @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg", @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg"];
    return result;
}

@end
