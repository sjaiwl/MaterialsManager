//
//  TTSheetView.h
//  Tick Tick
//
//  Created by zikong on 9/24/13.
//  Copyright (c) 2013 Appest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMABlocks.h"

extern NSTimeInterval const TTSheetViewShowDuration;
extern NSTimeInterval const TTSheetViewDismissDuration;

typedef NS_ENUM(NSInteger, TTSheetViewType) {
    TTSheetViewTypeTop,
    TTSheetViewTypeLeftTop,
    TTSheetViewTypeRightTop,
    TTSheetViewTypeBottom,
    TTSheetViewTypeLeftBottom,
    TTSheetViewTypeRightBottom,
    TTSheetViewTypeLeft,
    TTSheetViewTypeRight
};

typedef NS_ENUM(NSInteger, TTSheetViewShowAnimationType) {
    TTSheetViewShowAnimationTypeNone,
    TTSheetViewShowAnimationTypeMove,
    TTSheetViewShowAnimationTypeFadeIn,
    TTSheetViewShowAnimationTypeZoomIn,

    TTSheetViewShowAnimationTypeDefault = TTSheetViewShowAnimationTypeMove,
};

typedef NS_ENUM(NSInteger, TTSheetViewDismissAnimationType) {
    TTSheetViewDismissAnimationTypeNone,
    TTSheetViewDismissAnimationTypeMove,
    TTSheetViewDismissAnimationTypeFadeOut,
    TTSheetViewDismissAnimationTypeZoomOut,

    TTSheetViewDismissAnimationTypeDefault = TTSheetViewDismissAnimationTypeMove,
};

@class MMASheetView;
@protocol TTSheetViewDelegate <NSObject>

@optional
- (void)sheetViewWillDismiss:(MMASheetView *)sheetView;

@end

@interface MMASheetView : UIView

@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGSize contentSize;

- (instancetype)initWithContentView:(UIView *)view;
- (instancetype)initWithContentView:(UIView *)view sheetType:(TTSheetViewType)type;
- (instancetype)initWithContentView:(UIView *)view
                        contentSize:(CGSize)size
                          sheetType:(TTSheetViewType)type;

- (instancetype)initWithContentView:(UIView *)view
                        contentSize:(CGSize)size
                          sheetType:(TTSheetViewType)type
                           delegate:(id<TTSheetViewDelegate>)delegate;

- (void)show;
- (void)dismiss;
- (void)dismissWithCompletion:(TTGeneralBlock)completion;
- (void)dismissAnimated:(BOOL)animated;

- (BOOL)isVisible;

@end
