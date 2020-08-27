//
//  TabButtonView.h
//  STLPro
//
//  Created by LuShanshan on 16/5/10.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSSBezierView.h"

@protocol TabButtonViewDelegate <NSObject>

-(void)selectWithIndex:(NSInteger)index;

@end
@interface TabButtonView : UIView

{
    
    UIView * backView;
}
@property (nonatomic,assign) GroupType Type;// 图形类型
@property (nonatomic,assign) BOOL isHeng;// 图形类型

@property(nonatomic,strong)id<TabButtonViewDelegate> delegate;
-(void)initWithView;
@end

