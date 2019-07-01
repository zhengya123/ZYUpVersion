//
//  WJC_LoadingView.m
//  baseapp
//
//  Created by zkml on 2018/4/25.
//  Copyright © 2018年 zkml-zy. All rights reserved.
//

#import "WJC_LoadingView.h"
//屏幕的宽度
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
//屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kSize(r) (([UIScreen mainScreen].bounds.size.width < 400)?(375.0/1080.0*(r)):(412.0/1080.0*(r)))
@implementation WJC_LoadingView

+ (WJC_LoadingView *)shareView{
    static WJC_LoadingView *sharedWJC_LoadingView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedWJC_LoadingView = [[self alloc] init];
    });
    return sharedWJC_LoadingView;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}
- (void)setMessage:(NSString *)messageStr{
    self.messageLabel.text = messageStr;
    
}
- (void)showWithMessage:(NSString *)message{
    
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.baseView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.loadingImgBaseView.frame = CGRectMake(ScreenWidth/2 - 55, ScreenHeight/2 - 55, 110, 110);
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    CALayer *layer = [CALayer layer];
    
    //layer.backgroundColor = [UIColor colorWithRed:104/255.0 green:242/255.0 blue:174/255.0 alpha:0.8].CGColor; //圆环底色
    layer.backgroundColor =[self colorWithRGBString:(@"#00b868")].CGColor;
    layer.frame = CGRectMake(self.loadingImgBaseView.frame.size.width/2 - 35, 5, 70, 70);
    
    self.messageLabel.frame = CGRectMake(0, self.loadingImgBaseView.frame.size.height - 30, self.loadingImgBaseView.frame.size.width, 20);
    self.messageLabel.text = [NSString stringWithFormat:@"%@",message];
    
    //创建一个圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(35, 35) radius:25 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [self colorWithRGBString:(@"#00b868")].CGColor;
    shapeLayer.lineWidth = 3;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.7;
    shapeLayer.path = bezierPath.CGPath;
    
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[self colorWithRGBString:(@"#00b868")].CGColor,(id)[self colorWithRGBString:(@"#f2f1ed")].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, 70, 35);
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    
    [layer addSublayer:gradientLayer]; //设置颜色渐变
    [layer setMask:shapeLayer];
    

    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [layer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
    
    
    UIImageView * ima = [UIImageView new];
    ima.image = [UIImage imageNamed:@"loadingImg"];
    ima.frame = CGRectMake(self.loadingImgBaseView.frame.size.width/2 - 13, 27, 26, 26);
                
    [self.loadingImgBaseView addSubview:ima];
    [self.loadingImgBaseView addSubview:self.messageLabel];
    [self.loadingImgBaseView.layer addSublayer:layer];
    [self.baseView addSubview:self.loadingImgBaseView];
    self.loadingImgBaseView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:self.baseView];
                
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    [window addSubview:self];
    
}
- (void)hidens{
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.alpha = 0;
        
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self hidens];
    
}
#pragma mark - lan
- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel new];
        _messageLabel.textColor = [self colorWithRGBString:@"#999999"];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
- (UIView *)loadingImgBaseView{
    if (_loadingImgBaseView == nil) {
        _loadingImgBaseView = [UIView new];
        _loadingImgBaseView.layer.masksToBounds = YES;
        _loadingImgBaseView.layer.cornerRadius  = 5;
    }
    return _loadingImgBaseView;
}
- (UIView *)baseView{
    if (_baseView == nil) {
        _baseView = [UIView new];
        
    }
    return _baseView;
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
