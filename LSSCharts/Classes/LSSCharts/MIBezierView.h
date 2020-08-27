//
//  MIBezierView.h
//  MIBezierView
//
//  Created by maia on 16/5/5.
//  Copyright © 2016年 Maia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIDataModel.h"

typedef enum : NSUInteger {
    MINUTEH,
    FIVEDAY,
    DAYK,
    WEEKK,
    MONTHK,
    MINUTE
} GroupType;

@interface MIBezierView : UIView
{
    UIView *mainboxView; // k线图控件
    CGContextRef context;
    UILabel *MA5; // 5均线显示
    UILabel *MA10; // 10均线
    UILabel *MA20; // 20均线
    UILabel *startDateLab;
    UILabel *endDateLab;
    UILabel *volMaxValueLab; // 显示成交量最大值
    UIView *bottomBoxView; // 成交量
    UIPinchGestureRecognizer *pinchGesture;
    CGPoint touchViewPoint;
    UIView *movelineone; // 手指按下后显示的两根白色十字线
    UIView *movelinetwo;
    UILabel *movelineoneLable;
    UILabel *movelinetwoLable;
}

@property (nonatomic,strong) NSMutableArray *points; // 多点连线数组
@property (nonatomic,assign) CGFloat lineWidth; // 线条宽度
@property (nonatomic,assign) BOOL isK;// 是否是实体K线 默认是连接线
@property (nonatomic,assign) BOOL isVol;// 是否是画成交量的实体
@property (nonatomic,assign) GroupType Type;// 图形类型
@property (nonatomic,strong) NSMutableArray *linePoints; // 多点连线数组


-(void)startDroke;
-(NSMutableArray *)returnLinePointmax:(NSMutableArray *)fromarr;
-(NSMutableArray *)returnLinePoint:(NSMutableArray *)fromarr;


@end
