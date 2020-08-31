//
//  LSSChartsBaseView.h
//  LSSCharts
//
//  Created by 陆闪闪 on 2020/8/28.
//

#import <UIKit/UIKit.h>
#import "LSSChartsConfig.h"
#import "LSSDataModel.h"
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
@property (nonatomic,strong) NSMutableArray * xlMutPointArr;

@property (nonatomic,assign) CGFloat maxNum;
@property (nonatomic,assign) CGFloat minNum;

@property (nonatomic,assign) CGFloat maxVolumNum;
@property (nonatomic,assign) CGFloat minVolumNum;
@property (nonatomic,assign) CGFloat viewWidth;
@property (nonatomic,assign) CGFloat viewHeigth;

-(instancetype)initWithConfig:(LSSChartsConfig *)config frame:(CGRect)frame;
-(void)drawNumBackLine;

@end

NS_ASSUME_NONNULL_END
