//
//  LSSHistogramView.h
//  STLPro
//
//  Created by LuShanshan on 16/5/11.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSSHistogramView : UIView{

    CGFloat max;
    CGFloat min;

}
@property(nonatomic,strong)NSMutableArray * points;
-(NSMutableArray *)returnLinePointmax:(NSMutableArray *)fromarr;

@end
