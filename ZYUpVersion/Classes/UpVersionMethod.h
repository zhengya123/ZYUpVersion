//
//  UpVersionMethod.h
//  baseapp
//
//  Created by 郑亚 on 2018/7/5.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpVersionMethod : UIView


+ (UpVersionMethod *)shareView;
- (void)upVersionisMessage:(BOOL)message WithAPPID:(NSString *)appId;
@end
