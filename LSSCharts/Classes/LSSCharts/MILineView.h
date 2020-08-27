//
//  MILineView.h
//  MIBezierView
//
//  Created by maia on 16/5/6.
//  Copyright © 2016年 Maia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIBezierView.h"
#import "MIHistogramView.h"
@protocol MILineViewDelegate <NSObject>

-(void)moveViewWithLOrR:(BOOL)isLeft Count:(int)count;

-(void)scaleViewWithDOrX:(BOOL)isDa;

-(void)valuesLbWithModel:(MIDataModel*)model;

@end

@interface MILineView : UIView
{
    MIHistogramView * histogramView;
    MIBezierView * kLineView;
    UIPinchGestureRecognizer *pinchGesture;
    CGPoint touchViewPoint;
    NSMutableArray * maxArr;
    NSMutableArray * minArr;
    UIView *movelineone; //竖线
    UIView *movelinetwo;//横线
    UILabel *movelineoneLable;//横线数值展示
    UILabel *movelinetwoLable;//竖线数值栈是
    UILabel *centerLb;
    CGPoint beginTouchPoint;
    UIImageView  *Leftimg;
    UIView *moveHistogramlineone; //柱状图竖线
    UIView *moveHistogramlinetwo;//柱状图横线
    UILabel *moveHistogramlineoneLable;//柱状图数值
    UILabel *histogramCenterLb;
    NSMutableArray * volValueArr;

}
@property (nonatomic,strong) NSMutableArray *points; // 多点连线数组
@property(nonatomic,strong)id<MILineViewDelegate> delegate;
/**
 *  是否可以拖拽
 */
@property(nonatomic,assign)BOOL isDragging;//是否可以拖拽
@property (nonatomic,assign) GroupType Type;// 图形类型

-(void)startDroke;
@end

