//
//  TTScrollToLoadTableFooterView.m
//  PullUpToLoad
//
//  Created by 猪登登 on 15/1/13.
//  Copyright (c) 2015年 猪登登. All rights reserved.
//

#import "TTScrollToLoadTableFooterView.h"
#import "UIView+Utils.h"
#import "TTStringUtils.h"
#import "MMAColors.h"

@interface TTScrollToLoadTableFooterView ()

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loadingLabelWidthConstraint;

@property (weak, nonatomic) IBOutlet UIButton *retryButton;
@property (nonatomic, copy) TTGeneralBlock retryHandler;

@property (weak, nonatomic) IBOutlet UILabel *noMoreLabel;

@property (nonatomic, assign) TTScrollToLoadTableFooterViewState state;
@property (copy, nonatomic) NSString *unlocalizedTitle;

@end

@implementation TTScrollToLoadTableFooterView

#pragma mark - Public

+ (instancetype)loadFromNibWithState:(TTScrollToLoadTableFooterViewState)state
                    unlocalizedTitle:(NSString *)title {
    TTScrollToLoadTableFooterView *view = [TTScrollToLoadTableFooterView loadNib];
    if (view) {
        view.state = state;
        view.unlocalizedTitle = title;
    }
    return view;
}

+ (instancetype)loadFromNibWithUnlocalizedTitle:(NSString *)text
                                   retryHandler:(TTGeneralBlock)retryHandler {
    TTScrollToLoadTableFooterView *view = [TTScrollToLoadTableFooterView loadNib];
    if (view) {
        view.state = TTScrollToLoadTableFooterViewStateRetry;
        view.unlocalizedTitle = text;
        view.retryHandler = retryHandler;
    }
    return view;
}

- (void)setState:(TTScrollToLoadTableFooterViewState)state {
    _state = state;
    self.loadingView.hidden = YES;
    self.retryButton.hidden = YES;
    self.noMoreLabel.hidden = YES;
    switch (state) {
        case TTScrollToLoadTableFooterViewStateLoading:
            self.loadingView.hidden = NO;
            break;
        case TTScrollToLoadTableFooterViewStateRetry:
            self.retryButton.hidden = NO;
            break;
        case TTScrollToLoadTableFooterViewStateNoMore:
            self.noMoreLabel.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)setUnlocalizedTitle:(NSString *)unlocalizedTitle {
    _unlocalizedTitle = unlocalizedTitle;
    [self userLanguageDidChange:nil];
}

#pragma mark - Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    [self themeStyleDidChange:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - IBActions

- (IBAction)retryButtonDidTouchUpInside:(UIButton *)sender {
    if (self.retryHandler) {
        self.retryHandler();
    }
}

#pragma mark - Notifications

- (void)userLanguageDidChange:(NSNotification *)notificaiton {
    NSString *localizedTitle = NSLocalizedString(self.unlocalizedTitle, nil);
    switch (self.state) {
        case TTScrollToLoadTableFooterViewStateLoading:
            self.loadingView.hidden = NO;
            self.loadingLabel.text = localizedTitle;
            self.loadingLabelWidthConstraint.constant =
                [self.loadingLabel.text widthWithFont:self.loadingLabel.font
                                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                        lineBreakMode:self.loadingLabel.lineBreakMode];
            break;
        case TTScrollToLoadTableFooterViewStateRetry:
            [self.retryButton setTitle:localizedTitle forState:UIControlStateNormal];
            break;
        case TTScrollToLoadTableFooterViewStateNoMore:
            self.noMoreLabel.text = localizedTitle;
            break;
        default:
            break;
    }
}

- (void)themeStyleDidChange:(NSNotification *)notification {
    self.loadingLabel.textColor = MMA_BLACK(1);
    self.noMoreLabel.textColor = MMA_BLACK(1);
    [self.retryButton setTitleColor:MMA_BLACK(1) forState:UIControlStateNormal];
}

@end
