//
//  MMATableViewHeaderFooterView.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMATableViewHeaderFooterView.h"
#import "MMAColors.h"

NSString *const kMMATableViewHeaderFooterViewReuseIdentifier = @"kMMATableViewHeaderFooterViewReuseIdentifier";
NSInteger const kMMATableViewHeaderFooterViewHeight = 25;

@implementation MMATableViewHeaderFooterView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.viewForBackgroundColor = [[UIView alloc] init];
        self.viewForBackgroundColor.backgroundColor = MMA_WHITE(1);
        self.viewForBackgroundColor.hidden = YES;
        self.viewForBackgroundColor.frame = CGRectMake(0.f, 0.f,
                                                       CGRectGetWidth(self.bounds),
                                                       CGRectGetHeight(self.bounds));
        [self.contentView addSubview:self.viewForBackgroundColor];

        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = MMA_BLACK(1);
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.clipsToBounds = YES;
        self.titleLabel.frame = CGRectMake(0.f, 0.f,
                                           CGRectGetWidth(self.bounds),
                                           CGRectGetHeight(self.bounds));
        [self.contentView addSubview:self.titleLabel];

        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.viewForBackgroundColor.frame = CGRectMake(0.f, 0.f,
                                                   CGRectGetWidth(self.bounds),
                                                   CGRectGetHeight(self.bounds));
    self.titleLabel.font = self.titleFont;
    self.titleLabel.frame = CGRectMake(17.f, 0.f,
                                       CGRectGetWidth(self.bounds) - 34.f,
                                       CGRectGetHeight(self.bounds));
}

#pragma mark - Public

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
