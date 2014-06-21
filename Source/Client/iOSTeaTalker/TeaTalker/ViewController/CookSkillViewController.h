//
//  CookSkillViewController.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-4.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Topic;
@interface CookSkillViewController : UIViewController{

    @private
    IBOutlet UIScrollView*scrollView;
}

@property(nonatomic,strong)NSArray*cookImageInfoArray;
@property(nonatomic,strong)NSString*cookIntroduction;



@end
