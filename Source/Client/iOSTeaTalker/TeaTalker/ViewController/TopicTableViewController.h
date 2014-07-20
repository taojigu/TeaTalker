//
//  TopicTableViewController.h
//  TeaTalker
//
//  Created by user on 14-2-11.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDataManager.h"
#import "Topic.h"
@interface TopicTableViewController : UITableViewController{
    
}

@property(nonatomic,assign)TopicType topicType;
@property(nonatomic,assign)NSString*topicName;
@property(nonatomic,strong)id<TopicDataManager> topicDataManager;

@end
