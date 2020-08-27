//
//  UIImage+Utilities.h
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utilities)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornorRadius:(CGFloat)cornorRadius;

- (instancetype)scaleToSize:(CGSize)size;

@end
