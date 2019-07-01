//
//  WJC_LoadingView.h
//  baseapp
//
//  Created by zkml on 2018/4/25.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WJC_LoadingView : UIView

@property (nonatomic, strong) UIView      * baseView;
@property (nonatomic, strong) UIView      * loadingImgBaseView;
@property (nonatomic, strong) UILabel     * messageLabel;

+ (WJC_LoadingView *)shareView;

- (void)showWithMessage:(NSString *)message;
- (void)setMessage:(NSString *)messageStr;
- (void)hidens;
@end
