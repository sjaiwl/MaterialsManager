//
//  TTScrollToLoadTableFooterView.h
//  PullUpToLoad
//
//  Created by 猪登登 on 15/1/13.
//  Copyright (c) 2015年 猪登登. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMABlocks.h"

typedef NS_ENUM(NSUInteger, TTScrollToLoadTableFooterViewState) {
    TTScrollToLoadTableFooterViewStateLoading,
    TTScrollToLoadTableFooterViewStateRetry,
    TTScrollToLoadTableFooterViewStateNoMore
};

@interface TTScrollToLoadTableFooterView : UIView

+ (instancetype)loadFromNibWithState:(TTScrollToLoadTableFooterViewState)state
                    unlocalizedTitle:(NSString *)title;
+ (instancetype)loadFromNibWithUnlocalizedTitle:(NSString *)text
                                   retryHandler:(TTGeneralBlock)retryHandler;

@end
