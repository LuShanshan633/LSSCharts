//
//  MIDataModel.h
//  MIBezierView
//
//  Created by maia on 16/5/5.
//  Copyright © 2016年 Maia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONModel.h"
@interface MIDataModel : JSONModel
@property (nonatomic,strong) NSString<Optional> * code;//代码
@property (nonatomic,strong) NSString<Optional> * name;//名称
@property (nonatomic,strong) NSString<Optional> * isClick;//是否可以点击.

@property (nonatomic,strong) NSString<Optional> * zgj;//最高价
@property (nonatomic,strong) NSString<Optional> * zdj;//最低价
@property (nonatomic,strong) NSString<Optional> * jksj;//今开市价
@property (nonatomic,strong) NSString<Optional> * zspj;//昨收盘价
@property (nonatomic,strong) NSString<Optional> * hqdhl;//行情订货量
@property (nonatomic,strong) NSString<Optional> * zd;//涨跌

@property(nonatomic,strong)  NSString<Optional> *zxj;
@property (nonatomic,strong) NSString<Optional> * jsj;//结算价
@property (nonatomic,strong) NSString<Optional> * mj_in;//买价
@property (nonatomic,strong) NSString<Optional> * mj_out;//卖价
@property (nonatomic,strong) NSString<Optional> * str1;//占位符1
@property (nonatomic,strong) NSString<Optional> * str2;//占位符2
@property (nonatomic,strong) NSString<Optional> * xl;//现量（最新价所对应的成交量）
@property (nonatomic,strong) NSString<Optional> * bjsj;//报价时间
@property (nonatomic,strong) NSString<Optional> * isChange;//是否改变
@property (nonatomic,strong) NSString<Optional> * zdbl;//涨跌比率
@property (nonatomic,strong) NSString<Optional> *xs;//休市
@property (nonatomic,strong) NSString<Optional> *syl;//收益率
@property (nonatomic,strong) NSString<Optional> *cc;//持仓
@property (nonatomic,strong) NSString<Optional> *ykz;//盈亏
@property (nonatomic,strong )NSString<Optional> * kmbs;//可买手数


@end
