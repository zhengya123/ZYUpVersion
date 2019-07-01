//
//  MessageView.h
//  baseapp
//
//  Created by zkml on 2018/4/23.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView

//本类使用单例模式
+ (MessageView *)sharedMessage;

//在屏幕下方弹出一条提示消息，一段时间后自动消失。消息内容为message
- (void)showFlashMessage:(NSString *)message;
@end
