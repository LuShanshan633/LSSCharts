//
//  LSSChartsLineView.h
//  LSSCharts
//
//  Created by 陆闪闪 on 2020/8/31.
//

#import "LSSChartsBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSSChartsLineView : LSSChartsBaseView{
    CGPoint touchViewPoint;
    CGPoint beginTouchPoint;

}
-(void)drawStroke;
@end

NS_ASSUME_NONNULL_END
