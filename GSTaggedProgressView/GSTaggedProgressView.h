//
//  GSTaggedProgressView.h
//  GSTaggedProgressView
//
//  Created by Aren on 15/12/3.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger, GSTagWidthStyle) {
    GSTagWidthStylePercent,
    GSTagWidthStyleFixed
};
@class GSTaggedProgressView;

@protocol GSTaggedProgressViewDataSource <NSObject>

@required
- (NSInteger)numberOfTagsInProgressView:(GSTaggedProgressView *)aProgressView;

- (CGFloat)progressView:(GSTaggedProgressView *)aProgressView startProgressForTagAtIndex:(NSInteger)anIndex;

@optional
- (CGFloat)progressView:(GSTaggedProgressView *)aProgressView endProgressForTagAtIndex:(NSInteger)anIndex;

- (CGFloat)progressView:(GSTaggedProgressView *)aProgressView fixedWidthForTagAtIndex:(NSInteger)anIndex;

- (UIColor *)progressView:(GSTaggedProgressView *)aProgressView colorForTagAtIndex:(NSInteger)anIndex;
@end

@interface GSTaggedProgressView : UIProgressView
@property (weak, nonatomic) id<GSTaggedProgressViewDataSource> dataSource;
@property (assign, nonatomic) GSTagWidthStyle tagWidthStyle;

- (void)reloadData;
@end
