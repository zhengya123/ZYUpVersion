//
//  UpVersionView.h
//  baseapp
//
//  Created by 郑亚 on 2018/7/4.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpVersionView : UIView


@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIView   * describeView;
@property (nonatomic, strong) UIButton * cancelBtn;
@property (nonatomic, strong) UILabel  * VersionName;
@property (nonatomic, strong) UILabel  * releaseNote;
@property (nonatomic, strong) UIButton * updateBtn;
@property (nonatomic, strong) UIView   * baseView;

+ (UpVersionView *)shareView;
- (void) showWithupInfo:(NSDictionary *)dic AppId:(NSString *)appID;
- (void) hidens;
@end
