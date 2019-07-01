//
//  MessageView.m
//  baseapp
//
//  Created by zkml on 2018/4/23.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

//使用单例模式
+ (MessageView *)sharedMessage{
    static MessageView *sharedMessageInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMessageInstance = [[self alloc] init];
    });
    return sharedMessageInstance;
}

//在屏幕下方弹出一条提示，一段时间后自动消失。提示内容为message
- (void)showFlashMessage:(NSString *)message{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    CGSize size = CGSizeMake(window.frame.size.width-40, 34);
    CGSize textRealSize = CGSizeMake(0, 0);
    if ([message respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textRealSize = [message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName] context:nil].size;
    }
    textRealSize.width += 20;
    
    UILabel *flashMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(window.frame.size.width/2 - textRealSize.width / 2, window.bounds.size.height/2, textRealSize.width, 34)];
    flashMessageLabel.numberOfLines = 0;
    flashMessageLabel.backgroundColor = [UIColor clearColor];
    flashMessageLabel.textAlignment = NSTextAlignmentCenter;
    flashMessageLabel.textColor = [UIColor whiteColor];
    flashMessageLabel.font = [UIFont systemFontOfSize:14];
    flashMessageLabel.text = [NSString stringWithFormat:@"%@",message];
    
    flashMessageLabel.layer.backgroundColor = [UIColor blackColor].CGColor;
    flashMessageLabel.layer.cornerRadius = 5;
    flashMessageLabel.layer.borderColor = [UIColor blackColor].CGColor;
    flashMessageLabel.layer.borderWidth = 1;
    flashMessageLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    flashMessageLabel.layer.shadowOffset = CGSizeMake(0, 0);
    flashMessageLabel.layer.shadowRadius = 1;
    
    [window addSubview:flashMessageLabel];
    
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [flashMessageLabel removeFromSuperview];
    });
}

@end
