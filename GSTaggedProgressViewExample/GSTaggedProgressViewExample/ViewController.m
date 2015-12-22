//
//  ViewController.m
//  GSTaggedProgressViewExample
//
//  Created by Aren on 15/12/4.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import "ViewController.h"
#import "GSTaggedProgressView.h"

@interface ViewController ()<GSTaggedProgressViewDataSource>
@property (weak, nonatomic) IBOutlet GSTaggedProgressView *firstProgressView;
@property (weak, nonatomic) IBOutlet GSTaggedProgressView *secondProgressView;
@property (strong, nonatomic) NSArray *firstDataSource, *secondDataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDataSource];
    self.firstProgressView.dataSource = self;
    self.firstProgressView.tagWidthStyle = GSTagWidthStyleFixed;
    [self.firstProgressView reloadData];
    
    self.secondProgressView.dataSource = self;
    self.secondProgressView.tagWidthStyle = GSTagWidthStylePercent;
    self.secondProgressView.progress = 0;
    [self.secondProgressView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDataSource
{
    self.firstDataSource = @[@{@"startProgress":@(0.12)},
                        @{@"startProgress":@(0.22)},
                        @{@"startProgress":@(0.43)},
                        @{@"startProgress":@(0.51)},
                        @{@"startProgress":@(0.62)},
                        @{@"startProgress":@(0.86)}
                        ];
    
    self.secondDataSource = @[@{@"startProgress":@(0.12), @"endProgress":@(0.16)},
                             @{@"startProgress":@(0.24), @"endProgress":@(0.26)},
                             @{@"startProgress":@(0.33), @"endProgress":@(0.48)},
                             @{@"startProgress":@(0.49), @"endProgress":@(0.5821)},
                             @{@"startProgress":@(0.61), @"endProgress":@(0.722)},
                             @{@"startProgress":@(0.733), @"endProgress":@(0.755)},
                             @{@"startProgress":@(0.82), @"endProgress":@(0.952)},
                             ];
}

#pragma mark - GSTaggedProgressViewDataSource
- (NSInteger)numberOfTagsInProgressView:(GSTaggedProgressView *)aProgressView
{
    if (aProgressView == self.firstProgressView) {
        return self.firstDataSource.count;
    } else if (aProgressView == self.secondProgressView) {
        return self.secondDataSource.count;
    } else {
        return 0;
    }
}

- (CGFloat)progressView:(GSTaggedProgressView *)aProgressView startProgressForTagAtIndex:(NSInteger)anIndex
{
    if (aProgressView == self.firstProgressView) {
        NSDictionary *dict = [self.firstDataSource objectAtIndex:anIndex];
        return [[dict objectForKey:@"startProgress"] floatValue];
    } else if (aProgressView == self.secondProgressView) {
        NSDictionary *dict = [self.secondDataSource objectAtIndex:anIndex];
        return [[dict objectForKey:@"startProgress"] floatValue];
    } else {
        return 0;
    }
}

- (CGFloat)progressView:(GSTaggedProgressView *)aProgressView endProgressForTagAtIndex:(NSInteger)anIndex
{
    if (aProgressView == self.secondProgressView) {
        NSDictionary *dict = [self.secondDataSource objectAtIndex:anIndex];
        return [[dict objectForKey:@"endProgress"] floatValue];
    } else {
        return 0;
    }
}

//- (CGFloat)progressView:(GSTaggedProgressView *)aProgressView fixedWidthForTagAtIndex:(NSInteger)anIndex
//{
//
//}

- (UIColor *)progressView:(GSTaggedProgressView *)aProgressView colorForTagAtIndex:(NSInteger)anIndex
{
    if (aProgressView == self.firstProgressView) {
        return [UIColor whiteColor];
    } else {
        return [self randomColor];
    }
}

#pragma mark - Util
- (UIColor*)randomColor
{
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}
@end
