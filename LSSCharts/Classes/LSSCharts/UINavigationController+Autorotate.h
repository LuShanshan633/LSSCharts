//
//  UINavigationController+Autorotate.h
//  TestLandscape
//
//  Created by LuShanshan on 13-4-16.
//  Copyright (c) 2013年 LuShanshan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UINavigationController (Autorotate)

- (BOOL)shouldAutorotate   ;
- (NSUInteger)supportedInterfaceOrientations;

@end
