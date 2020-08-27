//
//  MIBezierView.m
//  MIBezierView
//
//  Created by maia on 16/5/5.
//  Copyright © 2016年 Maia. All rights reserved.
//

#import "MIBezierView.h"
#define ponty 200

@implementation MIBezierView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }

    if (_Type == 0) {
        [self getPoint];

    }
    else{
        [self line];

    }


}
-(void)startDroke{
    [self setNeedsDisplay];
}

- (void)pan:(UITapGestureRecognizer *)pan {
    UILabel *label=(UILabel*)pan.view;
    [self addLabelWithTapLabel:label];
}
-(void)addLabelWithTapLabel:(UILabel *)sender{
    UILabel * lb;
    lb= [[UILabel alloc]initWithFrame:CGRectMake(sender.frame.origin.x +10, sender.frame.origin.y-5, 50, 20)];
    [lb setBackgroundColor:[UIColor yellowColor]];
    [lb setTextColor:[UIColor orangeColor]];
    [lb setText:[self.points objectAtIndex:sender.tag]];
    [lb setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lb];
    
    UILabel * lineLb;
    lineLb= [[UILabel alloc]initWithFrame:CGRectMake(sender.frame.origin.x +5, 0, 1, self.frame.size.height)];
    [lineLb setBackgroundColor:[UIColor blackColor]];
    [self addSubview:lineLb];

    UILabel * lineLbs;
    lineLbs= [[UILabel alloc]initWithFrame:CGRectMake(0, sender.frame.origin.y +5,  self.frame.size.width, 1)];
    [lineLbs setBackgroundColor:[UIColor blackColor]];
    [self addSubview:lineLbs];

}

-(CGFloat)lineWidths:(NSMutableArray*)arr{
    return self.frame.size.width/arr.count - 1;
}
-(void)line{
    NSMutableArray * mutarr1 = [[NSMutableArray alloc]init];
    for (MIDataModel * model in self.points) {
        [mutarr1 addObject:[NSString stringWithFormat:@"%@",model.zgj]];
    }
    NSMutableArray * mutarr2 = [[NSMutableArray alloc]init];
    for (MIDataModel * model in self.points) {
        [mutarr2 addObject:[NSString stringWithFormat:@"%@",model.zdj]];
    }
    NSMutableArray * mutarr3 = [[NSMutableArray alloc]init];
    for (MIDataModel * model in self.points) {
        [mutarr3 addObject:[NSString stringWithFormat:@"%@",model.jksj]];
    }
    NSMutableArray * mutarr4 = [[NSMutableArray alloc]init];
    for (MIDataModel * model in self.points) {
        [mutarr4 addObject:[NSString stringWithFormat:@"%@",model.zspj]];
    }

    NSMutableArray * arr1 = [self returnLinePointmax:mutarr1];
    NSMutableArray * arr2 =[self returnLinePointmax:mutarr2];
    NSMutableArray * arr3 = [self returnLinePointmax:mutarr3];
    NSMutableArray * arr4 = [self returnLinePointmax:mutarr4];

    
    for (int i = 0;i<arr1.count;i++) {
        MIDataModel * model = [self.points objectAtIndex:i];
        CGPoint  currentPoint=CGPointFromString([arr1 objectAtIndex:i]);
        CGPoint previousPoint =CGPointFromString([arr2 objectAtIndex:i]);

        UILabel * lineLb = [[UILabel alloc]initWithFrame:CGRectMake(currentPoint.x, currentPoint.y, 0.5, previousPoint.y -currentPoint.y)];
        if (model.jksj > model.zspj) {
            [lineLb setBackgroundColor:LineGreenColor];
            
        }
        else{
            [lineLb setBackgroundColor:LineRedCorlor];
        }
        [self addSubview:lineLb];
    }
    CGFloat xwide= [self lineWidths:arr1];
    for (int i = 0;i<mutarr2.count;i++) {
        MIDataModel * model = [self.points objectAtIndex:i];
        
        CGPoint  currentPoint=CGPointFromString([arr3 objectAtIndex:i]);
        CGPoint previousPoint =CGPointFromString([arr4 objectAtIndex:i]);
        
        UILabel * lineLb = [[UILabel alloc]init ];
        if (currentPoint.y == previousPoint.y) {
            lineLb.frame =CGRectMake(currentPoint.x-xwide/2, currentPoint.y, xwide, previousPoint.y -currentPoint.y+0.5    );

        }
        else{
            lineLb.frame =CGRectMake(currentPoint.x-xwide/2, currentPoint.y, xwide, previousPoint.y -currentPoint.y);
        }

        if (model.jksj > model.zspj) {
            [lineLb setBackgroundColor:LineGreenColor];

        }
        else{
            [lineLb setBackgroundColor:LineRedCorlor];
        }

        [self addSubview:lineLb];

    }

}

/*    NSMutableArray * mut = [[NSMutableArray alloc]init];
for (MIDataModel * model in self.points) {
    [mut addObject:[NSString stringWithFormat:@"%f",model.maxValue]];
}*/


-(NSMutableArray *)returnLinePointmax:(NSMutableArray *)fromarr{

    NSMutableArray * mutmax = [[NSMutableArray alloc]init];

    for (MIDataModel * model in self.points) {
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zdj]];
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zgj]];
        
    }
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
-(NSMutableArray *)returnLinePoint:(NSMutableArray *)fromarr{
    
    NSMutableArray * mutmax = [[NSMutableArray alloc]init];
    
    for (MIDataModel * model in self.points) {
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zdj]];
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zgj]];
        
    }
    CGFloat spese = [self maxWithArr:mutmax]-[self minWithArr:mutmax];
    CGFloat h =self.frame.size.height;
    CGFloat sup = h/spese;
    NSMutableArray * arr= [[ NSMutableArray alloc]init];
    
    for (int i = 0; i<fromarr.count; i++) {
        
        CGFloat y =([self maxWithArr:mutmax] -[[fromarr objectAtIndex:i] floatValue]) *sup;
        CGPoint point = CGPointMake(5*i,y);
        
        [arr addObject: NSStringFromCGPoint(point)];
    }
    return arr;
}


-(void)getPoint{
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (MIDataModel * model in self.points) {
        [arr addObject:[NSString stringWithFormat:@"%@",model.jksj]];
        
    }
    
    NSMutableArray * arr1 = [self returnLinePoint:arr];
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    UIColor *color = LineBlueBackColor;
    [color set];  //
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    [aPath moveToPoint:CGPointMake(0, self.frame.size.height)];
    for (int i = 0;i<arr1.count;i++) {
        // Set the starting point of the shape.
        CGPoint  currentPoint=CGPointFromString([arr1 objectAtIndex:i]);

        // Draw the lines
        [aPath addLineToPoint:CGPointMake(currentPoint.x, currentPoint.y)];
        
    }
    [aPath addLineToPoint:CGPointMake(5*(arr.count-1) , self.frame.size.height)];

    [aPath fill]; //第五条线通过调用c
    
    
     context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetLineWidth(context, 0.5);  //线宽
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色
    _linePoints = arr1;

    for (int i = 0;i<arr1.count;i++) {
        
        UIColor *color = LineBlueColor;
        [color set];  //设置线条颜色
        if (i<arr1.count-1) {
            CGPoint  currentPoint=CGPointFromString([arr1 objectAtIndex:i]);
            CGPoint previousPoint =CGPointFromString([arr1 objectAtIndex:(i+1)]);
            CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);  //起点坐标
            CGContextAddLineToPoint(context, previousPoint.x, previousPoint.y);   //终点坐标

 
        }

    }
    CGContextStrokePath(context);

}


-(CGFloat)maxWithArr:(NSArray *)arr{
    CGFloat max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];

    return max;
}

-(CGFloat)minWithArr:(NSArray*)arr{
    CGFloat min = [[arr valueForKeyPath:@"@min.floatValue"] floatValue];
    
    return min;

}

@end/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

