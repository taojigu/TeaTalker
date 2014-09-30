//
//  FeedbackViewController.m
//  TeaTalker
//
//  Created by user on 14-2-11.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UITextView+insets.h"
#import "JTSTextView.h"

@interface FeedbackViewController (){
    @private
    IBOutlet JTSTextView*textView;
}

-(IBAction)sendFeedback:(id)sender;

@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    textView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    textView.automaticallyAdjustsContentInsetForKeyboard=YES;
    [textView becomeFirstResponder];
    textView.text=@"来自于iPhone用户的意见：";
    /*
    
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
     */
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardwillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super viewWillDisappear:animated];
    
}
-(IBAction)sendFeedback:(id)sender{
    
}
/*
-(void)keyboardWillShow:(NSNotification*)notification{
    
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake( 0.0, 0.0, keyboardRect.size.height, 0.0 );
    textView.contentInset = contentInsets;
    textView.scrollIndicatorInsets = contentInsets;
    
    
    CGRect targetRect=[textView caretRectForPosition:textView.selectedTextRange.end];
    if(CGRectContainsRect(keyboardRect, targetRect)){
        [textView scrollRectToVisible:targetRect animated:YES];
    }
    
    return;
    //return;
    
    UITextRange *range=[textView selectedTextRange];
    
    UITextPosition*position=[textView positionWithinRange:range farthestInDirection:UITextLayoutDirectionRight];
    CGRect rect=[textView caretRectForPosition:position];
    
    NSRange range1=[self selectedRangeInTextView];
    
    [textView scrollRangeToVisible:range1];
    
    //NSRange range=NSMakeRange(textView.text.length, 0);
    //[textView scrollRangeToVisible:range consideringInsets:YES];
    //[textView scrollRangeToVisible:NSMakeRange(textView.text.length+100, 0)];
}
-(void)keyboardwillHide:(NSNotification*)notification{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake( 0.0, 0.0, 0.0, 0.0 );
    textView.contentInset = contentInsets;
    textView.scrollIndicatorInsets = contentInsets;
    
}


- (NSRange) selectedRangeInTextView
{
    
    
    UITextPosition* beginning = textView.beginningOfDocument;
    
    UITextRange* selectedRange = textView.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [textView offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [textView offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}*/

@end
