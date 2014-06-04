//
//  SpeciesDetailViewController.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-5-6.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Species;

@interface SpeciesDetailViewController : UIViewController{
    @private
    
    IBOutlet UITextView*introductionTextView;
    IBOutlet UIImageView*headerImageView;

    
}

@property(strong,nonatomic)Species*species;

@end
