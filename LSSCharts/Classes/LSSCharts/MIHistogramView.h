//
//  MIHistogramView.h
//  STLPro
//
//  Created by maia on 16/5/11.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHistogramView : UIView{

    CGFloat max;
    CGFloat min;

}
@property(nonatomic,strong)NSMutableArray * points;
-(NSMutableArray *)returnLinePointmax:(NSMutableArray *)fromarr;

@end
