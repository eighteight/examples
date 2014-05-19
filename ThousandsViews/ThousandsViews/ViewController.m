//
//  ViewController.m
//  ThousandsViews
//
//  Created by eight on 5/18/14.
//  Copyright (c) 2014 eight_io. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (void)replaceHiddenLabels;
- (void)displayLabelsAroundIndex:(NSInteger)index;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _objects = [[NSArray alloc] initWithObjects:@"first", @"second", @"third",
                @"fourth", @"fifth", @"sixth", @"seventh", @"eight", @"ninth", @"tenth", nil];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    _scrollView.contentSize = CGSizeMake(320.0 * [_objects count], 460.0);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    _detailLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 460.0)];
    _detailLabel1.textAlignment = UITextAlignmentCenter;
    _detailLabel1.font = [UIFont boldSystemFontOfSize:30.0];
    _detailLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(320.0, 0.0, 320.0, 460.0)];
    _detailLabel2.textAlignment = UITextAlignmentCenter;
    _detailLabel2.font = [UIFont boldSystemFontOfSize:30.0];
    _detailLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(640.0, 0.0, 320.0, 460.0)];
    _detailLabel3.textAlignment = UITextAlignmentCenter;
    _detailLabel3.font = [UIFont boldSystemFontOfSize:30.0];
    
    // We are going to show all the contents of the _objects array
    // using only these three UILabel instances, making them jump
    // right and left, replacing them as required:
    [_scrollView addSubview:_detailLabel1];
    [_scrollView addSubview:_detailLabel2];
    [_scrollView addSubview:_detailLabel3];
    
    [self.view addSubview:_scrollView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_scrollView flashScrollIndicators];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayLabelsAroundIndex:0];
}

- (void)didReceiveMemoryWarning
{
    // Here you could release the data source, but make sure
    // you rebuild it in a lazy-loading way as soon as you need it again...
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // Do some initialization here, before the scroll view starts moving!
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self replaceHiddenLabels];
}

- (void)displayLabelsAroundIndex:(NSInteger)index
{
    NSInteger count = [_objects count];
    if (index >= 0 && index < count)
    {
        NSString *text = [_objects objectAtIndex:index];
        _detailLabel1.frame = CGRectMake(320.0 * index, 0.0, 320.0, 460.0);
        _detailLabel1.text = text;
        [_scrollView scrollRectToVisible:CGRectMake(320.0 * index, 0.0, 320.0, 460.0) animated:NO];
        
        if (index < (count - 1))
        {
            text = [_objects objectAtIndex:(index + 1)];
            _detailLabel2.frame = CGRectMake(320.0 * (index + 1), 0.0, 320.0, 460.0);
            _detailLabel2.text = text;
        }
        
        if (index > 0)
        {
            text = [_objects objectAtIndex:(index - 1)];
            _detailLabel3.frame = CGRectMake(320.0 * (index - 1), 0.0, 320.0, 460.0);
            _detailLabel3.text = text;
        }
    }
}

- (void)replaceHiddenLabels
{
    static const double pageWidth = 320.0;
    NSInteger currentIndex = ((_scrollView.contentOffset.x - pageWidth) / pageWidth) + 1;
    
    UILabel *currentLabel = nil;
    UILabel *previousLabel = nil;
    UILabel *nextLabel = nil;
    
    if (CGRectContainsPoint(_detailLabel1.frame, _scrollView.contentOffset))
    {
        currentLabel = _detailLabel1;
        previousLabel = _detailLabel2;
        nextLabel = _detailLabel3;
    }
    else if (CGRectContainsPoint(_detailLabel2.frame, _scrollView.contentOffset))
    {
        currentLabel = _detailLabel2;
        previousLabel = _detailLabel1;
        nextLabel = _detailLabel3;
    }
    else
    {
        currentLabel = _detailLabel3;
        previousLabel = _detailLabel1;
        nextLabel = _detailLabel2;
    }
    
    currentLabel.frame = CGRectMake(320.0 * currentIndex, 0.0, 320.0, 460.0);
    currentLabel.text = [_objects objectAtIndex:currentIndex];
    
    // Now move the other ones around
    // and set them ready for the next scroll
    if (currentIndex < [_objects count] - 1)
    {
        nextLabel.frame = CGRectMake(320.0 * (currentIndex + 1), 0.0, 320.0, 460.0);
        nextLabel.text = [_objects objectAtIndex:(currentIndex + 1)];
    }
    
    if (currentIndex >= 1)
    {
        previousLabel.frame = CGRectMake(320.0 * (currentIndex - 1), 0.0, 320.0, 460.0);
        previousLabel.text = [_objects objectAtIndex:(currentIndex - 1)];
    }
}

@end