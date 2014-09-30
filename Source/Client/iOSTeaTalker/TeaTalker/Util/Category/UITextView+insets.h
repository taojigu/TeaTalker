//
//  UITextView+insets.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-23.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (insets)

// Scrolls to visible range, eventually considering insets
- (void)scrollRangeToVisible:(NSRange)range consideringInsets:(BOOL)considerInsets;

// Scrolls to visible rect, eventually considering insets
- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated consideringInsets:(BOOL)considerInsets;

// Returns visible rect, eventually considering insets
- (CGRect)visibleRectConsideringInsets:(BOOL)considerInsets;

@end