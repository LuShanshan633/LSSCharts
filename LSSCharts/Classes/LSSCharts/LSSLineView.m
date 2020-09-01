//
//  LSSLineView.m
//  LSSBezierView
//
//  Created by LuShanshan on 16/5/6.
//  Copyright © 2016年 LuShanshan. All rights reserved.
//

#import "LSSLineView.h"

@implementation LSSLineView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}
-(instancetype)initWithConfig:(LSSChartsConfig *)config frame:(CGRect)frame delegate:(id<LSSLineViewDelegate>)delegate{  if (self = [super init]) {
    self.config = config;
    self.delegate = delegate;
    }
    return self;
}
-(void)drawBackLine{
    
}
-(void)drawRect:(CGRect)rect{
    NSMutableArray * mutmax = [[NSMutableArray alloc]init];
    
    for (LSSDataModel * model in self.points) {
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zdj]];
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zgj]];
    }
    CGFloat max = [self maxWithArr:mutmax];
    
    CGFloat leftW = [NSString stringWithFormat:@"%.2f",max] .length *6;
    CGFloat weidth =self.frame.size.width-leftW-40;
    CGFloat heght ;

    if (_isDragging == NO) {
        heght = weidth/3.2;
    }
    else{
        heght = weidth/1.25;
    }

    CGContextRef  contextss = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contextss, kCGLineCapRound);
    
    CGContextSetLineWidth(contextss, 1);  //线宽
    CGContextSetRGBStrokeColor(contextss, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGContextMoveToPoint(contextss, leftW , 0);  //起点坐标
    CGContextAddLineToPoint(contextss, leftW, heght+10);   //终点坐标
    
    CGContextMoveToPoint(contextss, weidth+leftW , 0);  //起点坐标
    CGContextAddLineToPoint(contextss, weidth+leftW, heght+10);   //终点坐标
    CGContextMoveToPoint(contextss, leftW , 0);  //起点坐标
    CGContextAddLineToPoint(contextss, weidth+leftW, 0);   //终点坐标
    CGContextMoveToPoint(contextss, leftW , heght+10);  //起点坐标
    CGContextAddLineToPoint(contextss, weidth+leftW, heght+10);   //终点坐标

    CGContextStrokePath(contextss);
    
    CGContextRef  contexts = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contexts, kCGLineCapRound);
    
    CGContextSetLineWidth(contexts, 1);  //线宽
    CGContextSetRGBStrokeColor(contexts, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGFloat lengths[] = {3,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    for (int i =0; i<5; i++) {
        
        CGContextMoveToPoint(contexts, leftW , heght/4*i+5);  //起点坐标
        CGContextAddLineToPoint(contexts, weidth+leftW,  heght/4*i+5);   //终点坐标
        
    }
    
    
    CGContextStrokePath(contexts);

    [self initView];
}

-(void)initLb {
    [movelineone removeFromSuperview];
    [movelineoneLable removeFromSuperview];
    [movelinetwo removeFromSuperview];
    [movelinetwoLable removeFromSuperview];
    [centerLb removeFromSuperview];
    
    [moveHistogramlineoneLable removeFromSuperview];
    [moveHistogramlinetwo removeFromSuperview];
    [moveHistogramlineone removeFromSuperview];
    [histogramCenterLb removeFromSuperview];
    histogramCenterLb = nil;

    moveHistogramlineoneLable = nil;
    moveHistogramlinetwo = nil;
    moveHistogramlineone = nil;

    movelinetwoLable = nil;
    movelinetwo = nil;
    movelineoneLable = nil;
    movelineone = nil;
    centerLb = nil;
    

    movelineone = [[UIView alloc] initWithFrame:CGRectMake(0,0, 0.5,
                                                           self.frame.size.height+self.frame.origin.y)];
    movelineone.backgroundColor = [UIColor blackColor];
    [kLineView addSubview:movelineone];
    movelinetwo = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width,0.3)];
    movelinetwo.backgroundColor = [UIColor blackColor];
    [kLineView addSubview:movelinetwo];
    movelineoneLable = [[UILabel alloc] initWithFrame:CGRectMake(kLineView.frame.size.width - 60, -10, 60, 20)];
    movelineoneLable.font = [UIFont fontWithName:@"Arial" size:14];
    movelineoneLable.layer.cornerRadius = 5;
    movelineoneLable.backgroundColor = [UIColor lightGrayColor];
    movelineoneLable.textColor = [UIColor redColor];
    movelineoneLable.textAlignment = NSTextAlignmentCenter;
    movelineoneLable.alpha = 1;
    [movelineone addSubview:movelineoneLable];
    movelinetwoLable = [[UILabel alloc] initWithFrame:CGRectMake(-30,-20 ,  60, 20)];
    movelinetwoLable.layer.cornerRadius = 5;
    movelinetwoLable.backgroundColor = [UIColor lightGrayColor];
    movelinetwoLable.textColor =[UIColor redColor];
    movelinetwoLable.textAlignment = NSTextAlignmentCenter;
    movelinetwoLable.alpha = 0.8;
    [movelinetwo addSubview:movelinetwoLable];
    centerLb = [[UILabel alloc] initWithFrame:CGRectMake(-30,kLineView.frame.size.height ,  4, 4)];
    centerLb.layer.masksToBounds = YES;
    centerLb.layer.cornerRadius = 2;
    centerLb.backgroundColor = [UIColor blackColor];
    centerLb.textAlignment = NSTextAlignmentCenter;
    centerLb.alpha = 1;
    [kLineView addSubview:centerLb];


    
    
    moveHistogramlineone = [[UIView alloc] initWithFrame:CGRectMake(0,0, 0.5,self.frame.size.height+self.frame.origin.y)];
    moveHistogramlineone.backgroundColor = [UIColor blackColor];
    [histogramView addSubview:moveHistogramlineone];
    
    moveHistogramlinetwo = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width,0.3)];
    moveHistogramlinetwo.backgroundColor = [UIColor blackColor];
    [histogramView addSubview:moveHistogramlinetwo];
    moveHistogramlineoneLable = [[UILabel alloc] initWithFrame:CGRectMake(kLineView.frame.size.width - 60, -10, 60, 20)];
    moveHistogramlineoneLable.font = [UIFont fontWithName:@"Arial" size:14];
    moveHistogramlineoneLable.layer.cornerRadius = 5;
    moveHistogramlineoneLable.backgroundColor = [UIColor lightGrayColor];
    moveHistogramlineoneLable.textColor = [UIColor redColor];
    moveHistogramlineoneLable.textAlignment = NSTextAlignmentCenter;
    moveHistogramlineoneLable.alpha = 1;
    [moveHistogramlineone addSubview:moveHistogramlineoneLable];
    
    
    histogramCenterLb = [[UILabel alloc] initWithFrame:CGRectMake(-30,kLineView.frame.size.height ,  4, 4)];
    histogramCenterLb.layer.masksToBounds = YES;
    histogramCenterLb.layer.cornerRadius = 2;
    histogramCenterLb.backgroundColor = [UIColor blackColor];
    histogramCenterLb.textAlignment = NSTextAlignmentCenter;
    histogramCenterLb.alpha = 1;
    [histogramView addSubview:histogramCenterLb];


}
-(void)initView{
    NSMutableArray * mutmax = [[NSMutableArray alloc]init];
    
    for (LSSDataModel * model in self.points) {
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zdj]];
        [mutmax addObject:[NSString stringWithFormat:@"%@",model.zgj]];
        
    }
    CGFloat max = [self maxWithArr:mutmax];
    CGFloat min =[self minWithArr:mutmax];

    CGFloat spase = (max -min)/4.00;
    
    CGFloat leftW = [NSString stringWithFormat:@"%.2f",max] .length *6;
    CGFloat heght ;
    if (_isDragging == NO) {
        heght = (self.frame.size.width- leftW-40)/3.2+10;
    }
    else{
        heght = (self.frame.size.width- leftW-40)/1.25+10;
    }

    [Leftimg removeFromSuperview];
    Leftimg = nil;
    Leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, leftW, heght)];
    [self addSubview:Leftimg];
    for (int i = 0; i<5; i++) {
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(0, (heght-10)/4*i-5, leftW, 20)];
        [lb setTextAlignment:NSTextAlignmentRight];
        if (i<2) {
            [lb setTextColor:[UIColor purpleColor]];
        }
        if (i>2) {
            [lb setTextColor:[UIColor grayColor]];
        }
        [lb setFont:[UIFont fontWithName:@"Arial" size:8]];
        [lb setText:[NSString stringWithFormat:@"%.2f",max - spase*i]];
        [lb setTextAlignment:NSTextAlignmentCenter];
        [Leftimg addSubview:lb];
    }
    if (kLineView == nil) {
        kLineView  = [[LSSBezierView alloc]initWithFrame:CGRectMake(leftW, 0, self.frame.size.width- leftW-40, heght)];
        kLineView.backgroundColor = [UIColor clearColor];
        kLineView.points = self.points;
        kLineView.Type = _Type;
        [self addSubview:kLineView];
        [kLineView startDroke];
        pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(touchBoxAction:)];
        [kLineView addGestureRecognizer:pinchGesture];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        [longPressGestureRecognizer addTarget:self action:@selector(gestureRecognizerHandle:)];
        [longPressGestureRecognizer setMinimumPressDuration:0.3f];
        [longPressGestureRecognizer setAllowableMovement:50.0];
        [self addGestureRecognizer:longPressGestureRecognizer];
        
        histogramView  = [[LSSHistogramView alloc]initWithFrame:CGRectMake(leftW, heght +20, self.frame.size.width- leftW-40, self.frame.size.height - heght - 50)];
        histogramView.backgroundColor = [UIColor clearColor];
        histogramView.points = self.points;
        histogramView.layer.masksToBounds = YES;
        histogramView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        histogramView.layer.borderWidth  = 0.5;
        [self addSubview:histogramView];
        [histogramView setNeedsDisplay];
      UIPinchGestureRecognizer *  pinchGestures = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(touchBoxAction:)];
        [histogramView addGestureRecognizer:pinchGestures];

    }

    NSMutableArray * mutarr1 = [[NSMutableArray alloc]init];
    for (LSSDataModel * model in self.points) {
        [mutarr1 addObject:[NSString stringWithFormat:@"%f",[model.jksj floatValue]]];
    }
    NSMutableArray * mutarr2 = [[NSMutableArray alloc]init];
    for (LSSDataModel * model in self.points) {
        [mutarr2 addObject:[NSString stringWithFormat:@"%f",[model.zspj floatValue]]];
    }
    NSMutableArray * mutarr3 = [[NSMutableArray alloc]init];
    for (LSSDataModel * model in self.points) {
        [mutarr3 addObject:[NSString stringWithFormat:@"%f",[model.xl floatValue]]];
    }

    maxArr = [kLineView returnLinePointmax:mutarr1];
    minArr =[kLineView returnLinePointmax:mutarr2];
    volValueArr = [histogramView returnLinePointmax:mutarr3];

}
-(void)startDroke{

    kLineView.Type = _Type;
    [self setNeedsDisplay];
    [kLineView startDroke];
    [histogramView setNeedsDisplay];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch  locationInView:kLineView];
    beginTouchPoint = point;
    pagesright = 1;
    pageLeft = 1;
}
int pageLeft = 0;
int pagesright = 0;

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_isDragging == NO) {
        UITouch * touch = [touches anyObject];
        CGPoint point = [touch  locationInView:kLineView];
        CGFloat  widthw =[self lineWidth:self.points.count];
        
        if (point.x > beginTouchPoint.x) {
            int counts = (point.x - beginTouchPoint.x)/widthw;
            if (counts != 0) {
                int count = counts - pageLeft;
                if (pageLeft!=counts) {
                    if (count >0) {
//                        [_delegate moveViewWithLOrR:NO Count:count];
                        
                    }
                    else{
//                        [_delegate moveViewWithLOrR:YES Count:-count];

                    }
                    pageLeft = counts;
                }
                
                
            }
            
        }
        else if (point.x < beginTouchPoint.x){
            
            int counts = (beginTouchPoint.x - point.x)/widthw;
            if (counts != 0) {
                int count = counts - pagesright;
                
                if (pagesright!=counts) {
                    if (count >0) {
//                        [_delegate moveViewWithLOrR:YES Count:count];
                        
                    }
                    else{
//                        [_delegate moveViewWithLOrR:NO Count:-count];

                    }
                    pagesright = counts;
                }
                
            }
        }

    }

}
int s=0;

-(void)touchBoxAction:(UIPinchGestureRecognizer*)pGesture{
    if (_isDragging == NO) {
        UIPinchGestureRecognizer* ges = (UIPinchGestureRecognizer*)pGesture;
        NSUInteger touchCount = ges.numberOfTouches;
        
        if (touchCount == 2) {
            if (pGesture.scale>1) {
                if (self.points.count > 4 && [[[[NSString stringWithFormat:@"%f",pGesture.scale] componentsSeparatedByString:@"."] objectAtIndex:0] intValue]  != s) {
                    s=[[[[NSString stringWithFormat:@"%f",pGesture.scale] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
//                    [_delegate scaleViewWithDOrX:YES];
                }
                // 放大手势
            }else{
                if (self.points.count < 50 ) {
                    s = 0;
                    
//                    [_delegate scaleViewWithDOrX:NO];
                }
                // 缩小手势
            }

    }

}
    

}
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));
    
}

-(void)gestureRecognizerHandle:(UILongPressGestureRecognizer*)longResture{
    

    touchViewPoint = [longResture locationInView:kLineView];
    
    
    if (_Type == 0) {
        CGPoint points;
        LSSDataModel * models;

        for (int i = 0; i<kLineView.linePoints.count; i++) {
            CGPoint currentPoint =CGPointFromString( [kLineView.linePoints objectAtIndex:i]);
            if (i < kLineView.linePoints.count-1) {
                CGFloat leftX = currentPoint.x - 2.5;
                CGFloat rightX = leftX + 2.5;
                if (touchViewPoint.x >leftX && touchViewPoint.x <= rightX) {
                    points = currentPoint;
                    LSSDataModel * model = [self.points objectAtIndex:i];
                    models = model;

                }
                

            }
        }

        if(longResture.state == UIGestureRecognizerStateBegan){
            [self initLb];
            if ([_delegate respondsToSelector:@selector(valuesLbWithModel:)]) {
//                [_delegate valuesLbWithModel:models];
            }

            movelineone.frame = CGRectMake(0, points.y-0.25, kLineView.frame.size.width, 0.5);
            movelinetwo.frame = CGRectMake(points.x-0.25, 0, 0.5, kLineView.frame.size.height);
            centerLb.frame =  CGRectMake(points.x - 2,points.y - 2,  4, 4);
            movelineoneLable.text = [NSString stringWithFormat:@"%.2f",[models.jksj floatValue]];
            if (points.x > kLineView.frame.size.width/2) {
                movelineoneLable.frame = CGRectMake(0, -10, 60, 20);
            }
            else{
                movelineoneLable.frame = CGRectMake(kLineView.frame.size.width - 60, -10, 60, 20);
                
            }


        }
        
        if (longResture.state == UIGestureRecognizerStateChanged && points.x>2.5 && points.x<kLineView.frame.size.width ) {
            if ([_delegate respondsToSelector:@selector(valuesLbWithModel:)]) {
//                [_delegate valuesLbWithModel:models];
            }

            movelineone.frame = CGRectMake(0, points.y-0.25, kLineView.frame.size.width, 0.5);
            movelinetwo.frame = CGRectMake(points.x-0.25, 0, 0.5, kLineView.frame.size.height);
            centerLb.frame =  CGRectMake(points.x - 2,points.y - 2,  4, 4);
            movelineoneLable.text = [NSString stringWithFormat:@"%.2f",[models.jksj floatValue]];
            if (points.x > kLineView.frame.size.width/2) {
                movelineoneLable.frame = CGRectMake(0, -10, 60, 20);
            }
            else{
                movelineoneLable.frame = CGRectMake(kLineView.frame.size.width - 60, -10, 60, 20);
                
            }

        }
    }
    
    else{
        CGPoint points;
        LSSDataModel * models;
        for (int i = 0; i<minArr.count; i++) {
            CGPoint currentPoint =CGPointFromString( [minArr objectAtIndex:i]);
            CGFloat leftX = currentPoint.x - [self lineWidths:maxArr]/2;
            CGFloat rightX = leftX+[self lineWidths:maxArr];
            if (touchViewPoint.x >=leftX && touchViewPoint.x <= rightX) {
                points = currentPoint;
                LSSDataModel * model = [self.points objectAtIndex:i];
                models = model;
            }
        }
        
        CGPoint pointsHis;
        LSSDataModel * modelsHis;
        for (int i = 0; i<volValueArr.count; i++) {
            CGPoint currentPoint =CGPointFromString( [volValueArr objectAtIndex:i]);
            CGFloat leftX = currentPoint.x - [self lineWidths:volValueArr]/2;
            CGFloat rightX = leftX+[self lineWidths:volValueArr];
            if (touchViewPoint.x >=leftX && touchViewPoint.x <= rightX) {
                pointsHis = currentPoint;
                LSSDataModel * model = [self.points objectAtIndex:i];
                modelsHis = model;
            }
        }
        
        // 手指长按开始时更新一般
        if(longResture.state == UIGestureRecognizerStateBegan && points.x<kLineView.frame.size.width - 1){
            [self initLb];
            if ([_delegate respondsToSelector:@selector(valuesLbWithModel:)]) {
//                [_delegate valuesLbWithModel:models];
            }
            movelineone.frame = CGRectMake(0, points.y-0.25, kLineView.frame.size.width, 0.5);
            movelinetwo.frame = CGRectMake(points.x-0.25, 0, 0.5, kLineView.frame.size.height);
            
            if (points.x > kLineView.frame.size.width/2) {
                movelineoneLable.frame = CGRectMake(0, -10, 60, 20);
            }
            else{
                movelineoneLable.frame = CGRectMake(kLineView.frame.size.width - 60, -10, 60, 20);
                
            }
            movelineoneLable.text = [NSString stringWithFormat:@"%.2f",[models.zspj floatValue]];
            centerLb.frame =  CGRectMake(points.x - 2,points.y - 2,  4, 4);
            
            
            moveHistogramlineone.frame = CGRectMake(0, pointsHis.y-0.25, histogramView.frame.size.width, 0.5);
            moveHistogramlinetwo.frame = CGRectMake(pointsHis.x-0.25, 0, 0.5, histogramView.frame.size.height);
            
            if (pointsHis.x > kLineView.frame.size.width/2) {
                if (pointsHis.y<10) {
                    moveHistogramlineoneLable.frame = CGRectMake(0, 0, 60, 20);
                    
                }
                else if (pointsHis.y>histogramView.frame.size.height-10){
                    moveHistogramlineoneLable.frame = CGRectMake(0, -20+histogramView.frame.size.height-pointsHis.y, 60, 20);
                }
                else{
                    moveHistogramlineoneLable.frame = CGRectMake(0, -10, 60, 20);
                }
            }
            else{
                if (pointsHis.y<10) {
                    moveHistogramlineoneLable.frame = CGRectMake(histogramView.frame.size.width - 60, 0, 60, 20);
                    
                }
                else if (pointsHis.y>histogramView.frame.size.height-10){
                    moveHistogramlineoneLable.frame = CGRectMake(histogramView.frame.size.width - 60, -20+histogramView.frame.size.height-pointsHis.y, 60, 20);
                }
                else{
                    moveHistogramlineoneLable.frame = CGRectMake(histogramView.frame.size.width - 60, -10, 60, 20);
                    
                }
            }
            histogramCenterLb.frame =  CGRectMake(pointsHis.x - 2,pointsHis.y - 2,  4, 4);
            moveHistogramlineoneLable.text = [NSString stringWithFormat:@"%.2f",[models.xl floatValue]];
            
        }
        // 手指移动时候开始显示十字线
        if (longResture.state == UIGestureRecognizerStateChanged && points.x>3 && points.x<kLineView.frame.size.width - 1) {
            if ([_delegate respondsToSelector:@selector(valuesLbWithModel:)]) {
//                [_delegate valuesLbWithModel:models];
            }
            movelineone.frame = CGRectMake(0, points.y-0.25, kLineView.frame.size.width, 0.5);
            movelinetwo.frame = CGRectMake(points.x-0.25, 0, 0.5, kLineView.frame.size.height);
            if (points.x > kLineView.frame.size.width/2) {
                movelineoneLable.frame = CGRectMake(0, -10, 60, 20);
            }
            else{
                movelineoneLable.frame = CGRectMake(kLineView.frame.size.width - 60, -10, 60, 20);
                
            }
            movelineoneLable.text = [NSString stringWithFormat:@"%.2f",[models.zspj floatValue]];
            centerLb.frame =  CGRectMake(points.x - 2,points.y - 2,  4, 4);
            
            moveHistogramlineone.frame = CGRectMake(0, pointsHis.y-0.25, histogramView.frame.size.width, 0.5);
            moveHistogramlinetwo.frame = CGRectMake(pointsHis.x-0.25, 0, 0.5, histogramView.frame.size.height);
            
            if (pointsHis.x > kLineView.frame.size.width/2) {
                if (pointsHis.y<10) {
                    moveHistogramlineoneLable.frame = CGRectMake(0, 0, 60, 20);
                    
                }
                else if (pointsHis.y>histogramView.frame.size.height-10){
                    moveHistogramlineoneLable.frame = CGRectMake(0, -20+histogramView.frame.size.height-pointsHis.y, 60, 20);
                }
                else{
                    moveHistogramlineoneLable.frame = CGRectMake(0, -10, 60, 20);
                }
            }
            else{
                if (pointsHis.y<10) {
                    moveHistogramlineoneLable.frame = CGRectMake(histogramView.frame.size.width - 60, 0, 60, 20);
                    
                }
                else if (pointsHis.y>histogramView.frame.size.height-10){
                    moveHistogramlineoneLable.frame = CGRectMake(histogramView.frame.size.width - 60, -20+histogramView.frame.size.height-pointsHis.y, 60, 20);
                }
                else{
                    moveHistogramlineoneLable.frame = CGRectMake(histogramView.frame.size.width - 60, -10, 60, 20);
                    
                }
            }
            histogramCenterLb.frame =  CGRectMake(pointsHis.x - 2,pointsHis.y - 2,  4, 4);
            moveHistogramlineoneLable.text = [NSString stringWithFormat:@"%.2f",[models.xl floatValue]];
            
            
        }

        
    }

    
    // 手指离开的时候移除十字线
    if (longResture.state == UIGestureRecognizerStateEnded) {
        movelineone.hidden = YES;
        movelinetwo.hidden = YES;
        movelineoneLable.hidden = YES;
        movelinetwoLable.hidden = YES;
        centerLb.hidden   = YES;
        moveHistogramlineoneLable.hidden = YES;
        moveHistogramlinetwo.hidden = YES;
        moveHistogramlineone.hidden  = YES;
        histogramCenterLb.hidden  = YES;
        if ([_delegate respondsToSelector:@selector(valuesLbWithModel:)]) {
//            [_delegate valuesLbWithModel:nil];
        }
    }
}
-(CGFloat)maxWithArr:(NSArray *)arr{
    CGFloat max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
    
    return max;
}

-(CGFloat)minWithArr:(NSArray*)arr{
    CGFloat min = [[arr valueForKeyPath:@"@min.floatValue"] floatValue];
    
    return min;
    
}
-(CGFloat)lineWidth:(NSInteger)count{
    return kLineView.frame.size.width/count - 1;
}

-(CGFloat)lineWidths:(NSMutableArray*)arr{
    return self.frame.size.width/arr.count - 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
