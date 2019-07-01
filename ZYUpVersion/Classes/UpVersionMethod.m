//
//  UpVersionMethod.m
//  baseapp
//
//  Created by 郑亚 on 2018/7/5.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import "UpVersionMethod.h"
#import "UpVersionView.h"
#import "HSUpdateApp.h"
#import "WJC_LoadingView.h"
#import "MessageView.h"
@implementation UpVersionMethod
{
    BOOL _isMessage;
}
+ (UpVersionMethod *)shareView{
    static UpVersionMethod * versionView = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        versionView = [[UpVersionMethod alloc]init];
    });
    return versionView;
}
- (void)upVersionisMessage:(BOOL)message WithAPPID:(NSString *)appId{
    _isMessage = message;
    if (message) {
        [[WJC_LoadingView shareView] showWithMessage:@"检查更新中"];
    }
   
    [HSUpdateApp hs_updateWithAPPID:appId withBundleId:nil block:^(NSString *currentVersion, NSString *storeVersion, NSString *releaseNote,NSString *openUrl, BOOL isUpdate) {
        if (isUpdate) {
            [[WJC_LoadingView shareView] hidens];
//            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:storeVersion forKey:@"WJC_Version"];
//            [defaults synchronize];
            NSDictionary * dic = @{
                                   @"version":storeVersion,
                                   @"releaseNotes":releaseNote
                                   };
            [[UpVersionView shareView] showWithupInfo:dic AppId:appId];
        }else{
            [[WJC_LoadingView shareView] hidens];
            if (self->_isMessage) {
                [[MessageView sharedMessage] showFlashMessage:@"已是最新版本，无需更新"];
            }
        }
    }];

}

@end
