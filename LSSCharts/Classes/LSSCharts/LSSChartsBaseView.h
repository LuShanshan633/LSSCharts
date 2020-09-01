//
//  LSSChartsBaseView.h
//  LSSCharts
//
//  Created by 陆闪闪 on 2020/8/28.
//

#import <UIKit/UIKit.h>
#import "LSSChartsConfig.h"
#import "LSSDataModel.h"
typedef enum : NSUInteger {
    LSSBezierCharts,//折线图
    LSSLineCharts//k线图
} LSSChartsType;

@protocol LSSChartsViewDelegate <NSObject>

-(void)moveViewWithLOrR:(BOOL)isLeft Count:(int)count;

-(void)scaleViewWithDOrX:(BOOL)isDa;

-(void)valuesLbWithModel:(LSSDataModel *_Nonnull)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LSSChartsBaseView : UIView
@property(nonatomic,strong)id<LSSChartsViewDelegate> delegate;

@property (nonatomic,strong) LSSChartsConfig *config;

@property (nonatomic,strong) NSMutableArray<LSSDataModel *> * dataSource;
@property (nonatomic,strong) NSMutableArray * alldataSourceArr;
@property (nonatomic,strong) NSMutableArray * zgjMutPointArr;
@property (nonatomic,strong) NSMutableArray * zdjMutPointArr;
@property (nonatomic,strong) NSMutableArray * jksjMutPointArr;
@property (nonatomic,strong) NSMutableArray * zspjMutPointArr;
@property (nonatomic,strong) NSMutableArray * jsjMutPointArr;
@property (nonatomic,strong) NSMutableArray * volumMutPointArr;

@property (nonatomic,assign) CGFloat maxNum;
@property (nonatomic,assign) CGFloat minNum;

@property (nonatomic,assign) CGFloat maxVolumNum;
@property (nonatomic,assign) CGFloat minVolumNum;
@property (nonatomic,assign) CGFloat viewWidth;
@property (nonatomic,assign) CGFloat zhuWidth;

@property (nonatomic,assign) LSSChartsType chartsType;
@property (nonatomic,strong) UIView * klineBackView;
@property (nonatomic,strong) UIView * volumBackView;
@property (nonatomic,strong) UILabel * moveVLineLabel;
@property (nonatomic,strong) UILabel * moveHLineLabel;
@property (nonatomic,strong) UILabel * valueNumLabel;
@property (nonatomic,strong) UILabel * timeNumLabel;
@property (nonatomic,strong) UILabel * volumHLineLabel;
@property (nonatomic,strong) UILabel * volumVLineLabel;
@property (nonatomic,strong) UILabel * volumLabel;

-(instancetype)initWithConfig:(LSSChartsConfig *)config frame:(CGRect)frame;
-(void)drawNumBackLine;
-(void)drawLineBackLine;
-(void)drawDealVolumBackLine;

@end

NS_ASSUME_NONNULL_END
