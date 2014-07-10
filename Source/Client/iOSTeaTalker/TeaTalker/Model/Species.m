//
//  Species.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-5-6.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "Species.h"
#import "ImageInfo.h"
#import "Topic.h"

@implementation Species

@synthesize speciesId;
@synthesize name;
@synthesize introduction;
@synthesize imageInfoArray;
@synthesize cookText;
@synthesize cookImageInfoArray;
@synthesize topicContainer;



-(id)init{
    self=[super init];
    self.imageInfoArray=[[NSMutableArray alloc]init];
    self.cookImageInfoArray=[[NSMutableArray alloc]init];
    self.topicContainer=[[ElementsContainer alloc]init];
    return self;
}

+(Species*)fakeSpecies:(NSInteger)speciesIndex{
    Species*spc=[[Species alloc]init];
    spc.speciesId=[NSString stringWithFormat:@"%li",(long)speciesIndex];
    spc.name=[NSString stringWithFormat:@"Name%li",(long)speciesIndex];
    spc.introduction=@"龙井茶是中国著名绿茶。产于浙江杭州西湖一带，已有一千二百余年历史。龙井茶色泽翠绿，香气浓郁，甘醇爽口，形如雀舌，即有“色绿、香郁、味甘、形美”四绝的特点。龙井茶得名于龙井。龙井位于西湖之西翁家山的西北麓的龙井茶村。龙井茶因其产地不同，分为西湖龙井、钱塘龙井、越州龙井三种，除了西湖产区168平方公里的茶叶叫作西湖龙井外，其它两地产的俗称为浙江龙井茶。";
    spc.cookText=@"水温方面，则应用约75到85℃的水。千万不要用100℃沸腾中的水，因为龙井茶是没有经过发酵的茶，所以茶叶本身十分嫩。如果用太热的水去冲泡，就会把茶叶滚坏，而且还会把苦涩的味道一并冲泡出来，影响口感。。\r\n至于在茶叶份量方面，茶叶刚好把茶盅底遮盖就够了。冲泡的时间，是要随冲泡次数而增加。\r\n更可以进一步在冲泡过程中欣赏龙井茶叶旗枪沉浮变化之美；在这里我向茶友们介绍三种龙井的冲泡法，或可称之为「龙井冲泡趣味」，";
    
    NSInteger count= arc4random()%(speciesIndex+1)+1;
    for (NSInteger imageIndex=0; imageIndex<count; imageIndex++) {
        ImageInfo*im=[ImageInfo fakeImageInfo:imageIndex];
        [spc.imageInfoArray addObject:im];
        ImageInfo* cmg=[ImageInfo fakeImageInfo:imageIndex];
        [spc.cookImageInfoArray addObject:cmg];
        
    }
    NSInteger topicCount=arc4random()%(speciesIndex+1)+1;
    for (NSInteger tIndex=0; tIndex<topicCount; tIndex++) {
        Topic*tp=[Topic fakeTopic:tIndex];
        [spc.topicContainer.elementArray addObject:tp];
    }
    spc.topicContainer.count=topicCount;
    
    return spc;
    
}
@end
