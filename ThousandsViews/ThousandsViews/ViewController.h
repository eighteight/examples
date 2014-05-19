//
//  ViewController.h
//  ThousandsViews
//
//  Created by eight on 5/18/14.
//  Copyright (c) 2014 eight_io. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>
{
@private
    UIScrollView *_scrollView;
    
    NSArray *_objects;
    
    UILabel *_detailLabel1;
    UILabel *_detailLabel2;
    UILabel *_detailLabel3;
}

@end