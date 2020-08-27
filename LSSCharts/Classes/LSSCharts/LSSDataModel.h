//
//  LSSDataModel.h
//  LSSBezierView
//
//  Created by LuShanshan on 16/5/5.
//  Copyright © 2016年 LuShanshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LSSDataModel : NSObject
@property (nonatomic,strong) NSString * code;//代码
@property (nonatomic,strong) NSString * name;//名称
@property (nonatomic,strong) NSString * isClick;//是否可以点击.

@property (nonatomic,strong) NSString * zgj;//最高价
@property (nonatomic,strong) NSString * zdj;//最低价
@property (nonatomic,strong) NSString * jksj;//今开市价
@property (nonatomic,strong) NSString * zspj;//昨收盘价
@property (nonatomic,strong) NSString * hqdhl;//行情订货量
@property (nonatomic,strong) NSString * zd;//涨跌

@property(nonatomic,strong)  NSString *zxj;
@property (nonatomic,strong) NSString * jsj;//结算价
@property (nonatomic,strong) NSString * mj_in;//买价
@property (nonatomic,strong) NSString * mj_out;//卖价
@property (nonatomic,strong) NSString * str1;//占位符1
@property (nonatomic,strong) NSString * str2;//占位符2
@property (nonatomic,strong) NSString * xl;//现量（最新价所对应的成交量）
@property (nonatomic,strong) NSString * bjsj;//报价时间
@property (nonatomic,strong) NSString * isChange;//是否改变
@property (nonatomic,strong) NSString * zdbl;//涨跌比率
@property (nonatomic,strong) NSString *xs;//休市
@property (nonatomic,strong) NSString *syl;//收益率
@property (nonatomic,strong) NSString *cc;//持仓
@property (nonatomic,strong) NSString *ykz;//盈亏
@property (nonatomic,strong )NSString * kmbs;//可买手数


@end
