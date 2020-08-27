//
//  MIHistogramView.m
//  STLPro
//
//  Created by maia on 16/5/11.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "MIHistogramView.h"
#import "MIDataModel.h"
@implementation MIHistogramView

-(void)drawRect:(CGRect)rect{
    CGContextRef  contexts = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contexts, kCGLineCapRound);
    
    CGContextSetLineWidth(contexts, 1);  //线宽
    CGContextSetRGBStrokeColor(contexts, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGFloat lengths[] = {3,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(contexts, 0 , self.frame.size.height/2);  //起点坐标
    CGContextAddLineToPoint(contexts, self.frame.size.width,  self.frame.size.height/2);   //终点坐标
    
    CGContextStrokePath(contexts);

    
    for (UIView  * views in self.subviews) {
        [views removeFromSuperview];
    }
    
    [self initViews];
    

}

-(void)initViews{
    CGFloat spese = [self lineWidths:self.points];
    NSMutableArray * mutarr1 = [[NSMutableArray alloc]init];
    for (MIDataModel * model in self.points) {
        [mutarr1 addObject:[NSString stringWithFormat:@"%f",[model.xl floatValue]]];
    }
    
    
    
    NSMutableArray * arr1 = [self returnLinePointmax:mutarr1];

    for (int i = 0; i<3; i++) {
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(-50, self.frame.size.height/2*i, 50, 20)];
        [lb setText:[NSString stringWithFormat:@"%.2f",(max - min)/3*(3-i)]];
        [self addSubview:lb];
    }
    for (int i = 0;i<arr1.count;i++) {
        MIDataModel * model = [self.points objectAtIndex:i];
        CGPoint  currentPoint=CGPointFromString([arr1 objectAtIndex:i]);
        
        UILabel * lineLb = [[UILabel alloc]initWithFrame:CGRectMake(currentPoint.x-spese/2, currentPoint.y, spese, self.frame.size.height - currentPoint.y)];
        lineLb.layer.masksToBounds = YES;
        lineLb.layer.borderWidth = 0.8;
        if (model.jksj > model.zspj) {
            lineLb.layer.borderColor =[UIColor greenColor].CGColor;
            [lineLb setBackgroundColor:[UIColor grayColor]];
            
        }
        else{
            lineLb.layer.borderColor =[UIColor redColor].CGColor;
            [lineLb setBackgroundColor:[UIColor purpleColor]];
        }
        [self addSubview:lineLb];
    }

    
}
-(CGFloat)lineWidths:(NSMutableArray*)arr{
    return self.frame.size.width/arr.count - 1;
}
-(NSMutableArray *)returnLinePointmax:(NSMutableArray *)fromarr{
    
    NSMutableArray * mutmax = [[NSMutableArray alloc]init];
    
    for (MIDataModel * model in self.points) {
        [mutmax addObject:[NSString stringWithFormat:@"%f",[model.xl floatValue]]];
    }
    
    max =[self maxWithArr:mutmax];
    min = [self minWithArr:mutmax];
    CGFloat spese = [self maxWithArr:mutmax]-[self minWithArr:mutmax];
    CGFloat h =self.frame.size.height;
    CGFloat sup = h/spese;
    NSMutableArray * arr= [[ NSMutableArray alloc]init];
    
    for (int i = 0; i<fromarr.count; i++) {
        
        CGFloat y =([self maxWithArr:mutmax] -[[fromarr objectAtIndex:i] floatValue]) *sup;
        CGFloat x =((self.frame.size.width - [self lineWidths:fromarr])/(fromarr.count -1));
        CGPoint point = CGPointMake(i*x+[self lineWidths:fromarr]/2,y);
        
        [arr addObject: NSStringFromCGPoint(point)];
    }
    return arr;
}
-(CGFloat)maxWithArr:(NSArray *)arr{
    CGFloat max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
    
    return max;
}

-(CGFloat)minWithArr:(NSArray*)arr{
    CGFloat min = [[arr valueForKeyPath:@"@min.floatValue"] floatValue];
    
    return min;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
