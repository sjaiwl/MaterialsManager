//
//  MMATableViewFootView.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMATableViewFootView.h"
#import "MMAColors.h"
#import "UIButton+Utils.h"

@interface MMATableViewFootView ()
@property (strong, nonatomic)UIButton *actionButton;

@end

@implementation MMATableViewFootView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.actionButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 10)];
        self.backgroundColor = [UIColor clearColor];
        self.actionButton.backgroundColor = MMA_BLACK(0.8);
        self.actionButton.cornerRadius_MMA = 5;
        [self.actionButton setTitleColor:MMA_WHITE(1) forState:UIControlStateNormal];
        [self.actionButton setTitle:@"更改维修人" forState:UIControlStateNormal];
        [self.actionButton addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.actionButton];
    }
    return self;
}

- (void)changeButtonAction:(UIButton *)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickChangeStaffButton:)]) {
        [self.delegate didClickChangeStaffButton:sender];
    }
}

@end
