//
//  GSTagedProgressView.m
//  GSTagedProgressView
//
//  Created by Aren on 15/12/3.
//  Copyright © 2015年 Aren. All rights reserved.
//

#import "GSTaggedProgressView.h"

static const CGFloat kDefaultTagWidth = 2;

#define kDefaultTagColor ([UIColor grayColor])

@implementation GSTaggedProgressView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [super drawRect:rect];
//    
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)reloadData
{
    for (UIView *subview in self.subviews) {
        if (![subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    
    [self drawTags];
}

#pragma mark - Drawing
- (void)drawTags
{
    NSInteger numberOfTags = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfTagsInProgressView:)]) {
        numberOfTags = [self.dataSource numberOfTagsInProgressView:self];
    }
    
    for (int i=0; i<numberOfTags; i++) {
        CGFloat startProgress = 0;
        
        if ([self.dataSource respondsToSelector:@selector(progressView:startProgressForTagAtIndex:)]) {
            startProgress = [self.dataSource progressView:self startProgressForTagAtIndex:i];
        }
        
        UIColor *tagColor = kDefaultTagColor;
        if ([self.dataSource respondsToSelector:@selector(progressView:colorForTagAtIndex:)]) {
            tagColor = [self.dataSource progressView:self colorForTagAtIndex:i];
        }
        
        if (self.tagWidthStyle == GSTagWidthStyleFixed) {
            CGFloat width = kDefaultTagWidth;
            if ([self.dataSource respondsToSelector:@selector(progressView:fixedWidthForTagAtIndex:)]) {
                width = [self.dataSource progressView:self fixedWidthForTagAtIndex:i];
            }
            [self drawTagWithFixedWidth:width atProgress:startProgress color:tagColor];
        } else if (self.tagWidthStyle == GSTagWidthStylePercent) {
            CGFloat endProgress = startProgress;
            if ([self.dataSource respondsToSelector:@selector(progressView:endProgressForTagAtIndex:)]) {
                endProgress = [self.dataSource progressView:self endProgressForTagAtIndex:i];
            }
            [self drawTagWithStartProgress:startProgress endProgress:endProgress color:tagColor];
        }
    }
}

- (void)drawTagWithFixedWidth:(CGFloat)aWidth atProgress:(CGFloat)aProgress color:(UIColor *)aColor
{
    UIView *tagView = [UIView new];
    [self addSubview:tagView];
    tagView.backgroundColor = aColor;
    tagView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tagView]-0-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(tagView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[tagView(width)]" options:kNilOptions metrics:@{@"width":@(aWidth)} views:NSDictionaryOfVariableBindings(tagView)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tagView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:aProgress constant:0]];
}

- (void)drawTagWithStartProgress:(CGFloat)aStartProgress
                     endProgress:(CGFloat)anEndProgress
                           color:(UIColor *)aColor
{
    UIView *tagView = [UIView new];
    [self addSubview:tagView];
    tagView.backgroundColor = aColor;
    tagView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tagView]-0-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(tagView)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tagView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:aStartProgress constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:tagView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:anEndProgress constant:0]];
}
@end
