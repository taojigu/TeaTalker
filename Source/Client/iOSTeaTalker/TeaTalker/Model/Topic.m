//
//  Topic.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "Topic.h"
#import "ImageInfo.h"

@implementation Topic

@synthesize titleImageInfo;
@synthesize title;
@synthesize text;
@synthesize author;
@synthesize urlString;

+(Topic*)fakeTopic:(NSInteger)index{
    Topic*tp=[[Topic alloc]init];
    tp.title=[NSString stringWithFormat:@"Topic %li Title",(long)index];
    tp.text=@"水温方面，则应用约75到85℃的水。千万不要用100℃沸腾中的水，因为龙井茶是没有经过发酵的茶，所以茶叶本身十分嫩。如果用太热的水去冲泡，就会把茶叶滚坏，而且还会把苦涩的味道一并冲泡出来，影响口感。那么怎样控制水温呢？我们当然不会拿支温度计去量，所以最好的是先把沸水倒进一个「公道杯」，然后再倒进茶盅冲泡，这样就可轻易控制了水温。还有一点要记紧的，就是要高冲，低倒。因为「高冲」时可增加水柱接触空气的面积，令到冷却的效果更加有效率。茶泡好，倒出茶汤后，若然不打算立即冲泡，就该把茶盅的盖子打开，不要合上。至于在茶叶份量方面，茶叶刚好把茶盅底遮盖就够了。冲泡的时间，是要随冲泡次数而增加。中茶文化-龙井的泡法没有一定的方式，不过享受龙井茶时不仅只是品味其茶汤之美，更可以进一步在冲泡过程中欣赏龙井茶叶旗枪沉浮变化之美；在这里我向茶友们介绍三种龙井的冲泡法，或可称之为「龙井冲泡趣味」，这些方法是在「香港艺术馆茶具文物分馆」制作的「中国茶艺」vcd中习得，我将它取名为「三弄龙井」，希望能让茶友们在冲泡龙井时带来一些小乐趣。另值一提的是「中国茶艺」龙井篇的片尾提到：『无味之味，实为至味也』，这句话颇值品嚐龙井的茶友们慢慢体会";
    
    ImageInfo*titleImageInfo=[ImageInfo fakeImageInfo:index];
    tp.titleImageInfo=titleImageInfo;
    tp.author=@"TeaWriter";
    tp.urlString=@"www.163.com";
    return tp;
    
}

@end
