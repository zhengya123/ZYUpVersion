//
//  UIImage+ZYBundle.m
//  HttpDemo
//
//  Created by 郑亚 on 2019/6/28.
//  Copyright © 2019 郑亚. All rights reserved.
//

#import "UIImage+ZYBundle.h"

@implementation UIImage (ZYBundle)

+ (instancetype)Zy_imgWithName:(NSString *)name targetClass:(Class)targetClass{
    //NSInteger scale = [[UIScreen mainScreen] scale];
    NSBundle *curB = [NSBundle bundleForClass:targetClass];
    NSString *imgName = [NSString stringWithFormat:@"%@.png", name];
    NSString *path = [curB pathForResource:imgName ofType:nil inDirectory:@"ZYImageModule.bundle"];
    return path?[UIImage imageWithContentsOfFile:path]:nil;
}
+ (instancetype)Zy_imageWithName:(NSString *)name bundle:(NSString *)bundleName targetClass:(Class)targetClass{
    //NSInteger scale = [[UIScreen mainScreen] scale];
    NSBundle *curB = [NSBundle bundleForClass:targetClass];
    NSString *imgName = [NSString stringWithFormat:@"%@.png", name];
    NSString *dir = [NSString stringWithFormat:@"%@.bundle",bundleName];
    NSString *path = [curB pathForResource:imgName ofType:nil inDirectory:dir];
    return path?[UIImage imageWithContentsOfFile:path]:nil;
}

+ (instancetype)ZYImageWithName:(NSString *)imgName TargetClass:(Class)targetClasss{
    NSString *bundlePath = [[NSBundle bundleForClass:targetClasss].resourcePath
                            stringByAppendingPathComponent:@"/ZYImageModule.bundle"];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",imgName]
                                inBundle:resource_bundle
           compatibleWithTraitCollection:nil];
    return image;
    
}

@end
