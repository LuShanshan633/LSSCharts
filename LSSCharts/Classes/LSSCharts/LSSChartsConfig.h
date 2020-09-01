//
//  LSSChartsConfig.h
//  Pods
//
//  Created by 陆闪闪 on 2020/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSSChartsConfig : NSObject
//线形图上涨颜色
@property(nonatomic,strong)UIColor * kRiseColor;
//线形图下跌颜色
@property(nonatomic,strong)UIColor * kFallColor;
//红色折线颜色
@property(nonatomic,strong)UIColor * lineRedColor;
//黄色折线颜色
@property(nonatomic,strong)UIColor * lineYellowColor;
//蓝色折线颜色
@property(nonatomic,strong)UIColor * lineBlueColor;
//移动的线颜色
@property(nonatomic,strong)UIColor * showMoveLineColor;
//展示数据的label背景色
@property(nonatomic,strong)UIColor * showMoveTitleBackColor;
//展示数据的label颜色
@property(nonatomic,strong)UIColor * showMoveLabelTitleColor;

//图形可容纳最少多少个数据
@property(nonatomic,assign)CGFloat minCount;
//图形可容纳最大多少个数据
@property(nonatomic,assign)CGFloat maxCount;

//线形图顶部和View留空距离（放置button工具栏）
@property(nonatomic,assign)CGFloat spaceTop;
//线形图下留空与成交量柱状图的距离
@property(nonatomic,assign)CGFloat spaceBottom;
//左侧边距
@property(nonatomic,assign)CGFloat spaceLeft;
//右侧边距
@property(nonatomic,assign)CGFloat spaceRight;

//线形图高度（默认整个View的2/3-工具栏和时间栏的高度）
@property(nonatomic,assign)CGFloat lineViewHeight;
@end

NS_ASSUME_NONNULL_END
