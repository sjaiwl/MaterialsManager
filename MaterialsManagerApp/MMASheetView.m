//
//  TTSheetView.m
//  Tick Tick
//
//  Created by zikong on 9/24/13.
//  Copyright (c) 2013 Appest. All rights reserved.
//

#import "MMASheetView.h"
#import "AppDelegate.h"
#import "MMAColors.h"
#import "MMAConfig.h"

NSTimeInterval const TTSheetViewShowDuration = 0.3;
NSTimeInterval const TTSheetViewDismissDuration = 0.3;

#define SHEET_VIEW_CONTEN_INSET_WIDTH 5

@interface MMASheetView ()

@property (nonatomic, assign) CGFloat heightForDisplay;

@property (nonatomic, strong) UIImageView *dimMaskView;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, assign) TTSheetViewType sheetType;

@property (assign, nonatomic, getter=isVisible) BOOL visible;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

// 暂不公开,暂不支持其它的动画效果
@property (nonatomic, assign) TTSheetViewShowAnimationType showAnimationType;
@property (nonatomic, assign) TTSheetViewDismissAnimationType dismissAnimationType;

@property (nonatomic, assign) id<TTSheetViewDelegate> delegate;

@end

@implementation MMASheetView

- (instancetype)initWithContentView:(UIView *)view
{
    return [self initWithContentView:view sheetType:TTSheetViewTypeBottom];
}

- (instancetype)initWithContentView:(UIView *)view sheetType:(TTSheetViewType)type
{
    return [self initWithContentView:view contentSize:view.frame.size sheetType:type];
}

- (instancetype)initWithContentView:(UIView *)view
                        contentSize:(CGSize)size
                          sheetType:(TTSheetViewType)type
{
    return [self initWithContentView:view contentSize:size sheetType:type delegate:nil];
}

- (instancetype)initWithContentView:(UIView *)view
                        contentSize:(CGSize)size
                          sheetType:(TTSheetViewType)type
                           delegate:(id<TTSheetViewDelegate>)delegate {
    self = [super init];
    if (self) {
        self.contentView = view;
        self.sheetType = type;
        self.contentSize = size;
        self.heightForDisplay = size.height;
        self.showAnimationType = TTSheetViewShowAnimationTypeDefault;
        self.dismissAnimationType = TTSheetViewDismissAnimationTypeDefault;

        self.delegate = delegate;
    }
    return self;
}

- (void)setContentWidth:(CGFloat)contentWidth
{
    _contentWidth = contentWidth;
    _contentSize = CGSizeMake(contentWidth, _contentSize.height);
}

- (void)setContentSize:(CGSize)contentSize
{
    _contentSize = contentSize;
    _heightForDisplay = contentSize.height;
}

#pragma mark -

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(gestureRecognizerDidTap:)];
    }
    return _tapGestureRecognizer;
}

- (void)gestureRecognizerDidTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self dismiss];
}

- (UIImageView *)dimMaskView
{
    if (_dimMaskView == nil) {
        _dimMaskView = [[UIImageView alloc] init];
        _dimMaskView.userInteractionEnabled = YES;
        [_dimMaskView addGestureRecognizer:self.tapGestureRecognizer];
    }
    return _dimMaskView;
}

- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (void)setupDimMaskViewIfNeedMask:(BOOL)needMask
{
    if (needMask) {
        self.dimMaskView.backgroundColor = MMA_GRAY(0.3);
    }
    else {
        self.dimMaskView.backgroundColor = [UIColor clearColor];
    }

    if (![AppDelegate getInstance].currentWindowWidthIsCompactWidth) {
        self.layer.shadowColor = [UIColor colorWithRed:0.39 green:0.39 blue:0.38 alpha:0.3].CGColor;
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.45;
    }

    [self addSubview:self.dimMaskView];
    self.dimMaskView.frame = self.bounds;
}

- (void)setupContentViewWithNeedBackView:(BOOL)needBackView
                         backViewOriginY:(CGFloat)backViewOriginY {
    if (needBackView) {
        self.backView.frame
            = CGRectMake(0,
                         backViewOriginY,
                         CGRectGetWidth(self.bounds),
                         CGRectGetHeight(self.bounds) - backViewOriginY);
        [self addSubview:self.backView];
    }
    CGRect frame = self.contentView.frame;
    frame.size = self.contentSize;
    self.contentView.frame = frame;
    float x = 0;
    float y = 0;
    float contentWidth = self.contentSize.width;
    float contentHeight = self.contentSize.height;
    switch (self.sheetType) {
        case TTSheetViewTypeTop:
            x = (CGRectGetWidth(self.bounds) - contentWidth) / 2;
            break;
        case TTSheetViewTypeLeftTop:
            x = SHEET_VIEW_CONTEN_INSET_WIDTH;
            break;
        case TTSheetViewTypeRightTop:
            x = CGRectGetWidth(self.bounds) - contentWidth - SHEET_VIEW_CONTEN_INSET_WIDTH;
            break;
        case TTSheetViewTypeBottom:
            x = (CGRectGetWidth(self.bounds) - contentWidth) / 2;
            y = CGRectGetHeight(self.bounds) - self.heightForDisplay;
            break;
        case TTSheetViewTypeLeftBottom:
            x = SHEET_VIEW_CONTEN_INSET_WIDTH;
            y = CGRectGetHeight(self.bounds) - self.heightForDisplay;
            break;
        case TTSheetViewTypeRightBottom:
            x = CGRectGetWidth(self.bounds) - contentWidth - SHEET_VIEW_CONTEN_INSET_WIDTH;
            y = CGRectGetHeight(self.bounds) - self.heightForDisplay;
            break;
        case TTSheetViewTypeLeft:
            y = (CGRectGetHeight(self.bounds) - self.heightForDisplay) / 2;
            break;
        case TTSheetViewTypeRight:
            x = CGRectGetWidth(self.bounds) - contentWidth;
            y = (CGRectGetHeight(self.bounds) - self.heightForDisplay) / 2;
            break;
        default:
            break;
    }
    self.contentView.frame = CGRectMake(x, y, contentWidth, contentHeight);
    [self addSubview:self.contentView];
}

#pragma mark - Show

- (void)show {
    [self showInView:CURRENT_WINDOW needMask:YES];
}

- (void)showInView:(UIView *)view needMask:(BOOL)needMask {
    [self showInView:view needMask:needMask completion:nil];
}

- (void)showInView:(UIView *)view needMask:(BOOL)needMask completion:(TTGeneralBlock)completion {
    [self showInView:view
               needMask:needMask
           needBackView:NO
        backViewOriginY:0
             completion:completion];
}

- (void)showInView:(UIView *)view
           needMask:(BOOL)needMask
       needBackView:(BOOL)needBackView
    backViewOriginY:(CGFloat)backViewOriginY
         completion:(TTGeneralBlock)completion
{
    @synchronized(self)
    {
        if (view == nil) {
            view = CURRENT_WINDOW;
            self.containerView = view;
        }
        self.containerView = view;

        self.frame = view.bounds;

        [self setupDimMaskViewIfNeedMask:needMask];
        [self setupContentViewWithNeedBackView:needBackView backViewOriginY:backViewOriginY];

        switch (self.showAnimationType) {
            case TTSheetViewShowAnimationTypeNone:
                [self addToContainerView];
                break;
            case TTSheetViewShowAnimationTypeMove:
                [self showWithMoveAnimateCompletion:completion];
                break;
            case TTSheetViewShowAnimationTypeFadeIn:
                [self showWithFadeInAnimateCompletion:completion];
                break;
            case TTSheetViewShowAnimationTypeZoomIn:
                [self showWithZoomAnimateCompletion:completion];
                break;
            default:
                break;
        }
    }
}

- (void)addToContainerView
{
    [self.containerView addSubview:self];
    [self.containerView bringSubviewToFront:self];
}

- (void)showWithMoveAnimateCompletion:(TTGeneralBlock)completion
{
    self.dimMaskView.alpha = 0;
//    self.contentView.alpha = 0;
    self.backView.alpha = 0;
    switch (self.sheetType) {
        case TTSheetViewTypeTop:
        case TTSheetViewTypeLeftTop:
        case TTSheetViewTypeRightTop: {
            CGRect frameForContentView = self.contentView.frame;
            frameForContentView.origin.y -= CGRectGetHeight(frameForContentView);
            self.contentView.frame = frameForContentView;
            
            CGRect frameForBackView = self.backView.frame;
            frameForBackView.origin.y -= CGRectGetHeight(frameForBackView);
            self.backView.frame = frameForBackView;
            
            [self addToContainerView];
            [UIView animateWithDuration:TTSheetViewShowDuration animations:^{
                
                self.dimMaskView.alpha = 1;
//                    self.contentView.alpha = 1;
                self.backView.alpha = 1;

                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.y += CGRectGetHeight(frameForContentView);
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.y += CGRectGetHeight(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                self.visible = YES;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        case TTSheetViewTypeBottom:
        case TTSheetViewTypeLeftBottom:
        case TTSheetViewTypeRightBottom: {
            CGRect frameForContentView = self.contentView.frame;
            frameForContentView.origin.y = CGRectGetHeight(self.bounds);
            self.contentView.frame = frameForContentView;
            
            CGRect frameForBackView = self.backView.frame;
            frameForBackView.origin.y = CGRectGetHeight(self.bounds);
            self.backView.frame = frameForBackView;
            
            [self addToContainerView];
            [UIView animateWithDuration:TTSheetViewShowDuration animations:^{
                self.dimMaskView.alpha = 1;
//                    self.contentView.alpha = 1;
                self.backView.alpha = 1;
                
                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.y -= self.heightForDisplay;
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.y -= CGRectGetHeight(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                self.visible = YES;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        case TTSheetViewTypeLeft: {
            CGRect frameForContentView = self.contentView.frame;
            frameForContentView.origin.x = -CGRectGetWidth(self.bounds);
            self.contentView.frame = frameForContentView;
            
            CGRect frameForBackView = self.backView.frame;
            frameForBackView.origin.x = -CGRectGetWidth(self.bounds);
            self.backView.frame = frameForBackView;
            
            [self addToContainerView];
            [UIView animateWithDuration:TTSheetViewShowDuration animations:^{
                self.dimMaskView.alpha = 1;
//                    self.contentView.alpha = 1;
                self.backView.alpha = 1;

                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.x += CGRectGetWidth(frameForContentView);
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.x += CGRectGetWidth(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                self.visible = YES;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        case TTSheetViewTypeRight: {
            CGRect frameForContentView = self.contentView.frame;
            frameForContentView.origin.x = CGRectGetWidth(self.bounds);
            self.contentView.frame = frameForContentView;
            
            CGRect frameForBackView = self.backView.frame;
            frameForBackView.origin.x = CGRectGetWidth(self.bounds);
            self.backView.frame = frameForBackView;
            
            [self addToContainerView];
            [UIView animateWithDuration:TTSheetViewShowDuration animations:^{
                self.dimMaskView.alpha = 1;
//                    self.contentView.alpha = 1;
                self.backView.alpha = 1;
                
                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.x -= CGRectGetWidth(frameForContentView);
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.x -= CGRectGetWidth(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                self.visible = YES;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        default:
            break;
    }
}

- (void)showWithFadeInAnimateCompletion:(TTGeneralBlock)completion
{
    self.dimMaskView.alpha = 0;
//    self.contentView.alpha = 0;
    [self addToContainerView];

    [UIView animateWithDuration:TTSheetViewShowDuration
        animations:^{
            self.dimMaskView.alpha = 1;
//            self.contentView.alpha = 1;
        }
        completion:^(BOOL finished) {
            self.visible = YES;
            if (completion) {
                completion();
            }
        }];
}

- (void)showWithZoomAnimateCompletion:(TTGeneralBlock)completion
{
    self.dimMaskView.alpha = 0;
    CGFloat correctX = CGRectGetMinX(self.contentView.frame);
    CGFloat correctY = CGRectGetMinY(self.contentView.frame);

    CGFloat currentX = 0;
    CGFloat currentY = 0;
    switch (self.sheetType) {
        case TTSheetViewTypeTop: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds) / 2;
            break;
        }
        case TTSheetViewTypeLeftTop:
            break;
        case TTSheetViewTypeRightTop: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeBottom: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds) / 2;
            currentY = correctY + CGRectGetHeight(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeLeftBottom: {
            currentY = correctY + CGRectGetHeight(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeRightBottom: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds);
            currentY = correctY + CGRectGetHeight(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeLeft: {
            correctX = currentX;
            currentY = correctY + CGRectGetHeight(self.contentView.bounds) / 2;
            break;
        }
        case TTSheetViewTypeRight: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds);
            currentY = correctY + CGRectGetHeight(self.contentView.bounds) / 2;
            break;
        }
        default:
            break;
    }
    self.contentView.frame = CGRectMake(currentX, currentY, 0, 0);
    [self addToContainerView];
    [UIView animateWithDuration:TTSheetViewShowDuration
        animations:^{
            self.dimMaskView.alpha = 1;
            self.contentView.frame
                = CGRectMake(correctX, correctY, self.contentSize.width, self.contentSize.height);
        }
        completion:^(BOOL finished) {
            self.visible = YES;
            if (completion) {
                completion();
            }
        }];
}

#pragma mark - Dismiss

- (void)dismiss {
    [self dismissAnimated:YES];
}

- (void)dismissWithCompletion:(TTGeneralBlock)completion {
    [self dismissAnimated:YES completion:completion];
}

- (void)dismissAnimated:(BOOL)animated {
    [self dismissAnimated:animated completion:nil];
}

- (void)dismissAnimated:(BOOL)animated completion:(TTGeneralBlock)completion {
    @synchronized(self)
    {
        if (!self.superview) {
            return;
        }
        if ([self.delegate respondsToSelector:@selector(sheetViewWillDismiss:)]) {
            [self.delegate sheetViewWillDismiss:self];
        }

        if (animated == NO) {
            [self removeAllView];
            self.visible = NO;
            if (completion) {
                completion();
            }
        }
        else {
            switch (self.dismissAnimationType) {
                case TTSheetViewDismissAnimationTypeNone:
                    [self removeAllView];
                    break;
                case TTSheetViewDismissAnimationTypeMove:
                    [self dismissWithMoveAnimateCompletion:completion];
                    break;
                case TTSheetViewDismissAnimationTypeFadeOut:
                    [self dismissWithFadeOutAnimateCompletion:completion];
                    break;
                case TTSheetViewDismissAnimationTypeZoomOut:
                    [self dismissWithZoomAnimateCompletion:completion];
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)removeAllView
{
    [self removeFromSuperview];
    [self.dimMaskView removeFromSuperview];
    [self.contentView removeFromSuperview];
}

- (void)dismissWithMoveAnimateCompletion:(TTGeneralBlock)completion
{
    switch (self.sheetType) {
        case TTSheetViewTypeTop:
        case TTSheetViewTypeLeftTop:
        case TTSheetViewTypeRightTop: {
            [UIView animateWithDuration:TTSheetViewDismissDuration animations:^{
                self.dimMaskView.alpha = 0;
//                    self.contentView.alpha = 0;
                self.backView.alpha = 0;
                
                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.y -= CGRectGetHeight(frameForContentView);
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.y -= CGRectGetHeight(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                [self removeAllView];
                self.visible = NO;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        case TTSheetViewTypeBottom:
        case TTSheetViewTypeLeftBottom:
        case TTSheetViewTypeRightBottom: {
            [UIView animateWithDuration:0.3 animations:^{
                self.dimMaskView.alpha = 0;
//                    self.contentView.alpha = 0.6;
                self.backView.alpha = 0.6;
                
                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.y += CGRectGetHeight(frameForContentView);
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.y += CGRectGetHeight(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                [self removeAllView];
                self.visible = NO;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        case TTSheetViewTypeLeft: {
            [UIView animateWithDuration:TTSheetViewDismissDuration animations:^{
                self.dimMaskView.alpha = 0;
//                    self.contentView.alpha = 0.6;
                self.backView.alpha = 0.6;
                
                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.x -= CGRectGetWidth(frameForContentView);
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.x -= CGRectGetWidth(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                [self removeAllView];
                self.visible = NO;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        case TTSheetViewTypeRight: {
            [UIView animateWithDuration:TTSheetViewDismissDuration animations:^{
                self.dimMaskView.alpha = 0;
//                    self.contentView.alpha = 0.6;
                self.backView.alpha = 0.6;

                CGRect frameForContentView = self.contentView.frame;
                frameForContentView.origin.x += CGRectGetWidth(frameForContentView);
                self.contentView.frame = frameForContentView;
                
                CGRect frameForBackView = self.backView.frame;
                frameForBackView.origin.x += CGRectGetWidth(frameForBackView);
                self.backView.frame = frameForBackView;
            } completion:^(BOOL finished) {
                [self removeAllView];
                self.visible = NO;
                if (completion) {
                    completion();
                }
            }];
            break;
        }
        default:
            break;
    }
}

- (void)dismissWithFadeOutAnimateCompletion:(TTGeneralBlock)completion
{
    [UIView animateWithDuration:TTSheetViewDismissDuration
        animations:^{
            self.dimMaskView.alpha = 0;
//            self.contentView.alpha = 0;
        }
        completion:^(BOOL finished) {
            [self removeAllView];
            self.visible = NO;
            if (completion) {
                completion();
            }
        }];
}

- (void)dismissWithZoomAnimateCompletion:(TTGeneralBlock)completion
{
    CGFloat correctX = CGRectGetMinX(self.contentView.frame);
    CGFloat correctY = CGRectGetMinY(self.contentView.frame);

    CGFloat currentX = 0;
    CGFloat currentY = 0;
    switch (self.sheetType) {
        case TTSheetViewTypeTop: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds) / 2;
            break;
        }
        case TTSheetViewTypeLeftTop:
            break;
        case TTSheetViewTypeRightTop: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeBottom: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds) / 2;
            currentY = correctY + CGRectGetHeight(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeLeftBottom: {
            currentY = correctY + CGRectGetHeight(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeRightBottom: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds);
            currentY = correctY + CGRectGetHeight(self.contentView.bounds);
            break;
        }
        case TTSheetViewTypeLeft: {
            currentX = correctX;
            currentY = correctY + CGRectGetHeight(self.contentView.bounds) / 2;
            break;
        }
        case TTSheetViewTypeRight: {
            currentX = correctX + CGRectGetWidth(self.contentView.bounds);
            currentY = correctY + CGRectGetHeight(self.contentView.bounds) / 2;
            break;
        }
        default:
            break;
    }

    [UIView animateWithDuration:TTSheetViewDismissDuration
        animations:^{
            self.dimMaskView.alpha = 0;
            self.contentView.frame = CGRectMake(currentX, currentY, 0, 0);
        }
        completion:^(BOOL finished) {
            [self removeAllView];
            self.visible = NO;
            if (completion) {
                completion();
            }
        }];
}

@end
