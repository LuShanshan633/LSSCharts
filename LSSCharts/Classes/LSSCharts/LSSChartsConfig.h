//
//  LSSChartsConfig.h
//  Pods
//
//  Created by 陆闪闪 on 2020/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSSChartsConfig : NSObject

@property(nonatomic,strong)UIColor * kRiseColor;

@property(nonatomic,strong)UIColor * kFallColor;

@property(nonatomic,strong)UIColor * lineRedColor;

@property(nonatomic,strong)UIColor * lineYellowColor;

@property(nonatomic,strong)UIColor * lineBluwColor;

@property(nonatomic,strong)UIColor * showMoveLineColor;

@property(nonatomic,strong)UIColor * labelBackColor;

@property(nonatomic,strong)UIColor * labelTitleColor;

@property(nonatomic,assign)CGFloat minCount;

@property(nonatomic,assign)CGFloat currentLineWidth;

@property(nonatomic,assign)CGFloat maxCount;

@property(nonatomic,strong)NSArray * points;

@end

NS_ASSUME_NONNULL_END
