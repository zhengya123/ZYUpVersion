//
//  UpVersionView.m
//  baseapp
//
//  Created by 郑亚 on 2018/7/4.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import "UpVersionView.h"
#import "UIImage+ZYBundle.h"
//屏幕的宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kSize(r) (([UIScreen mainScreen].bounds.size.width < 400)?(375.0/1080.0*(r)):(412.0/1080.0*(r)))

@implementation UpVersionView
{
    NSString * releaseNotes;
    NSString * _APPID;
}
+ (UpVersionView *)shareView{
    static UpVersionView * exitView = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        exitView = [[UpVersionView alloc]init];
    });
    return exitView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.baseView.frame = CGRectMake(40, ScreenHeight/2 - ScreenHeight/4 - 40, ScreenWidth - 80, ScreenHeight/2 + 40);
    self.imageView.frame = CGRectMake(0, 0, self.baseView.frame.size.width, self.baseView.frame.size.width* 131/278);
    self.describeView.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), ScreenWidth - 80, ScreenHeight/2 - self.imageView.frame.size.height + 40);
    self.cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.baseView.frame)- 15, self.baseView.frame.origin.y + 32, 30, 30);
    self.VersionName.frame = CGRectMake(10, 24, self.describeView.frame.size.width - 20, 30);
    self.releaseNote.frame = CGRectMake(30, CGRectGetMaxY(self.VersionName.frame) + 15, self.describeView.frame.size.width - 60, [self heightWithString:[self isEmpty:releaseNotes] font:14 Width:self.describeView.frame.size.width - 60 LineH:5]);
    self.updateBtn.frame = CGRectMake(20, self.describeView.frame.size.height - 60, self.describeView.frame.size.width - 40, 40);
    
}
- (void)showWithupInfo:(NSDictionary *)dic AppId:(NSString *)appID{
    _APPID = appID;
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:self];
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.imageView];
    [self.baseView addSubview:self.describeView];
    [self addSubview:self.cancelBtn];
    [self.describeView addSubview:self.VersionName];
    [self.describeView addSubview:self.releaseNote];
    [self.describeView addSubview:self.updateBtn];
    self.VersionName.text = [NSString stringWithFormat:@"发现新版本 V%@",[self isEmpty:[dic objectForKey:@"version"]]];
    releaseNotes = [self isEmpty:[dic objectForKey:@"releaseNotes"]];
    //releaseNotes = @"1、新增了XXX功能。\n2、对XXX进行了优化处理。";
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle};
    self.releaseNote.attributedText = [[NSAttributedString alloc] initWithString:releaseNotes attributes:attrs];
    //self.releaseNote.attributedText = releaseNotes;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    //animation.values = @[@1.0,@1.15,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.values = @[@1.0,@1.05,@0.95,@1.10,@0.95,@1.02,@1.0];
    animation.duration = 0.8;
    animation.calculationMode = kCAAnimationCubic;
    //把动画添加上去就OK了
    [self.baseView.layer addAnimation:animation forKey:nil];
    [self.cancelBtn.layer addAnimation:animation forKey:nil];
    
    UIImage * img = [UIImage ZYImageWithName:@"upVersionHeaderImage" TargetClass:[self class]];
    
    self.imageView.image = img;
}
- (void)cancelBtnClick:(UIButton *)btn{
    [self hidens];
    
}
- (void)hidens{
    [self removeFromSuperview];
}
- (void)updataClick:(UIButton *)btn{
    //[self hidens];
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",_APPID]; //更换id即可
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
- (UIView *)baseView{
    if (_baseView == nil) {
        _baseView = [UIView new];
        _baseView.backgroundColor = [UIColor clearColor];
        _baseView.layer.masksToBounds = YES;
        _baseView.layer.cornerRadius = 12;
    }
    return _baseView;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        
        _imageView.image = [UIImage ZYImageWithName:@"upVersionHeaderImage" TargetClass:[self class]];
    }
    return _imageView;
}
- (UIView *)describeView{
    if (_describeView == nil) {
        _describeView = [UIView new];
        _describeView.backgroundColor = [UIColor whiteColor];
    }
    return _describeView;
}
- (UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        //UIImage * image = [UIImage Zy_imgWithName:@"upVersionCancelBtnImage" targetClass:[self class]];
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_cancelBtn setImage:[UIImage ZYImageWithName:@"upVersionCancelBtnImage" TargetClass:[self class]] forState:UIControlStateNormal];
        [_cancelBtn setImage:[UIImage ZYImageWithName:@"upVersionCancelBtnImage" TargetClass:[self class]] forState:UIControlStateHighlighted];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UILabel *)VersionName{
    if (_VersionName == nil) {
        _VersionName = [UILabel new];
        _VersionName.textColor = [self colorWithRGBString:@"#00b868"];
        _VersionName.font = [UIFont systemFontOfSize:18];
        _VersionName.textAlignment = NSTextAlignmentCenter;
    }
    return _VersionName;
}
- (UILabel *)releaseNote{
    if(_releaseNote == nil){
        _releaseNote = [UILabel new];
        _releaseNote.textColor = [self colorWithRGBString:@"#666666"];
        _releaseNote.textAlignment = NSTextAlignmentCenter;
        _releaseNote.font = [UIFont systemFontOfSize:14];
        _releaseNote.numberOfLines = 0;
    }
    return _releaseNote;
}
- (UIButton *)updateBtn{
    if (_updateBtn == nil) {
        _updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateBtn setTitle:@"立即升级" forState:UIControlStateNormal];
        [_updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_updateBtn setBackgroundColor:[self colorWithRGBString:@"#00b868"]];
        [_updateBtn addTarget:self action:@selector(updataClick:) forControlEvents:UIControlEventTouchUpInside];
        _updateBtn.layer.masksToBounds = YES;
        _updateBtn.layer.cornerRadius = 4;
    }
    return _updateBtn;
}
- (CGFloat)heightWithString:(NSString *)string font:(CGFloat)fontSize Width:(CGFloat)width LineH:(CGFloat)lineheight
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineheight;// 字体的行间距
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle};
    CGSize newSize;
    
    if (![self notNull:string]) {
        newSize = CGSizeMake(ScreenWidth, kSize(20));
        
    }else{
        newSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attrs
                                       context:nil].size;
        
    }
    //newSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size; NSStringDrawingUsesFontLeading
    
    return newSize.height;
    
}
- (UIColor *)colorWithRGBString:(NSString *)stringToConvert{
    if ([stringToConvert hasPrefix:@"#"])
    {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    
    int r = (hexNum >> 16) & 0xFF;
    int g = (hexNum >> 8) & 0xFF;
    int b = (hexNum) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
- (BOOL) notNull:(id )val{
    if (val == nil || [val isEqual:[NSNull null]]) {
        return NO;
    }
    
    if ([val isKindOfClass:[NSString class]]) {
        if ([val isEqualToString:@""] || [val isEqualToString:@"null"] || [val isEqualToString:@"<null>"]||[val isEqualToString:@"(null)"]) {
            return NO;
        }
    }
    
    if ([val isKindOfClass:[NSArray class]]) {
        if ([val count] == 0) {
            return NO;
        }
    }
    
    return YES;
}
-(id) isEmpty:(NSString * )str
{
    if (![str isKindOfClass:[NSNull class]]) {
        if (str == nil) {
            str = @"";
        }
    }else
    {
        str=@"";
    }
    return str;
}
@end
