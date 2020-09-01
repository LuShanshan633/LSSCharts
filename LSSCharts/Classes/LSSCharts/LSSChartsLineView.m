//
//  LSSChartsLineView.m
//  LSSCharts
//
//  Created by 陆闪闪 on 2020/8/31.
//

#import "LSSChartsLineView.h"

@implementation LSSChartsLineView
-(instancetype)initWithConfig:(LSSChartsConfig *)config frame:(CGRect)frame{
    if (self = [super initWithConfig:config frame:frame]) {
        self.config = config;
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        [longPressGestureRecognizer addTarget:self action:@selector(gestureRecognizerHandle:)];
        [longPressGestureRecognizer setMinimumPressDuration:0.3f];
        [longPressGestureRecognizer setAllowableMovement:50.0];
        [self.klineBackView addGestureRecognizer:longPressGestureRecognizer];
        
        
        UILongPressGestureRecognizer *longPressGestureRecognizer2 = [[UILongPressGestureRecognizer alloc] init];
        [longPressGestureRecognizer2 addTarget:self action:@selector(gestureRecognizerHandle:)];
        [longPressGestureRecognizer2 setMinimumPressDuration:0.3f];
        [longPressGestureRecognizer2 setAllowableMovement:50.0];
        [self.volumBackView addGestureRecognizer:longPressGestureRecognizer2];

        UIPinchGestureRecognizer *  pinchGestures = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(touchBoxAction:)];
        [self.klineBackView addGestureRecognizer:pinchGestures];


    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    [self drawDealVolumBackLine];

    if (self.chartsType == LSSBezierCharts) {
        [self drawNumBackLine];
        [self getPoint];
    }else if(self.chartsType == LSSLineCharts){
        [self drawLineBackLine];
    }
}
-(void)drawStroke{
    [self setNeedsLayout];
    if(self.chartsType == LSSLineCharts){
        for (UIView * v in self.klineBackView.subviews) {
            [v removeFromSuperview];
        }
        for (UIView * v in self.volumBackView.subviews) {
            [v removeFromSuperview];
        }

        [self getKline];
        [self getVolumLine];
    }

}
-(void)getPoint{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
    [color set];  //
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    [aPath moveToPoint:CGPointMake(self.config.spaceLeft, self.frame.size.height/3*2-15)];
    for (int i = 0;i<self.jksjMutPointArr.count;i++) {
        // Set the starting point of the shape.
        CGPoint  currentPoint=CGPointFromString([self.jksjMutPointArr objectAtIndex:i]);

        // Draw the lines
        [aPath addLineToPoint:CGPointMake(currentPoint.x+self.config.spaceLeft, currentPoint.y+25)];

    }
    [aPath addLineToPoint:CGPointMake(self.viewWidth+self.config.spaceLeft , self.frame.size.height/3*2-15)];

    [aPath fill]; //第五条线通过调用c
    
    CGContextRef context;
    context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextSetLineWidth(context, 0.5);  //线宽
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色

    for (int i = 0;i<self.jksjMutPointArr.count;i++) {
        
        UIColor *color = [UIColor redColor];
        [color set];  //设置线条颜色
        if (i<self.jksjMutPointArr.count-1) {
            CGPoint  currentPoint=CGPointFromString([self.jksjMutPointArr objectAtIndex:i]);
            CGPoint previousPoint =CGPointFromString([self.jksjMutPointArr objectAtIndex:(i+1)]);
            CGContextMoveToPoint(context, currentPoint.x+self.config.spaceLeft, currentPoint.y+25);  //起点坐标
            CGContextAddLineToPoint(context, previousPoint.x+self.config.spaceLeft, previousPoint.y+25);   //终点坐标

 
        }

    }
    CGContextStrokePath(context);

}
///成交量图
-(void)getVolumLine{
    for (int i = 0;i<self.dataSource.count;i++) {
        LSSDataModel * model = [self.dataSource objectAtIndex:i];
        CGPoint  currentPoint=CGPointFromString([self.volumMutPointArr objectAtIndex:i]);
        CGFloat  xWidth  = self.zhuWidth - 1;
        UILabel * lineLbZhu = [[UILabel alloc]init];
        lineLbZhu.frame =CGRectMake(currentPoint.x, currentPoint.y, xWidth, self.frame.size.height - self.config.lineViewHeight - self.config.spaceTop - self.config.spaceBottom - currentPoint.y - 5);

        if (model.jksj.floatValue > model.zspj.floatValue) {
            [lineLbZhu setBackgroundColor:self.config.kRiseColor];

        }
        else{
            [lineLbZhu setBackgroundColor:self.config.kFallColor];
        }

        [self.volumBackView addSubview:lineLbZhu];

    }

}
///K线图
-(void)getKline{
    

    for (int i = 0;i<self.dataSource.count;i++) {
        LSSDataModel * model = [self.dataSource objectAtIndex:i];
        CGPoint  currentPoint=CGPointFromString([self.zgjMutPointArr objectAtIndex:i]);
        CGPoint previousPoint =CGPointFromString([self.zdjMutPointArr objectAtIndex:i]);
        CGFloat  xWidth  = self.zhuWidth-1;

        UILabel * lineLb = [[UILabel alloc]initWithFrame:CGRectMake(currentPoint.x+self.zhuWidth/2.0, currentPoint.y, 0.5, previousPoint.y -currentPoint.y)];
        if (model.jksj.floatValue > model.zspj.floatValue) {
            [lineLb setBackgroundColor:self.config.kRiseColor];
        }
        else{
            [lineLb setBackgroundColor:self.config.kFallColor];
        }
        [self.klineBackView addSubview:lineLb];
        
        CGPoint  currentPointZhu=CGPointFromString([self.jksjMutPointArr objectAtIndex:i]);
        CGPoint previousPointZhu =CGPointFromString([self.zspjMutPointArr objectAtIndex:i]);
        UILabel * lineLbZhu = [[UILabel alloc]init];
        if (currentPointZhu.y == previousPointZhu.y) {
            lineLbZhu.frame =CGRectMake(currentPointZhu.x, currentPointZhu.y, xWidth, 1);

        }
        else{
            lineLbZhu.frame =CGRectMake(currentPointZhu.x, currentPointZhu.y,xWidth, previousPointZhu.y -currentPointZhu.y);
        }

        if (model.jksj.floatValue > model.zspj.floatValue) {
            [lineLbZhu setBackgroundColor:self.config.kRiseColor];

        }
        else{
            [lineLbZhu setBackgroundColor:self.config.kFallColor];
        }

        [self.klineBackView addSubview:lineLbZhu];

    }

}

-(void)gestureRecognizerHandle:(UILongPressGestureRecognizer*)longResture{
    touchViewPoint = [longResture locationInView:longResture.view];
    
    //使用二分法查找当前长按的数值，坐标计算
    NSInteger mid = 0;

    NSInteger min = 0;

    NSInteger max = self.jksjMutPointArr.count - 1;

    BOOL found = NO;
    while (min <= max) {
        mid = (min + max)/2;
        CGPoint currentPoint =CGPointFromString( [self.jksjMutPointArr objectAtIndex:mid]);
           
        CGFloat leftX = currentPoint.x;
           
        CGFloat rightX = leftX + self.zhuWidth;
        if (touchViewPoint.x >leftX && touchViewPoint.x <= rightX) {
            found = YES;

            break;

        } else if (touchViewPoint.x <=leftX) {

            max = mid - 1;

        } else if (touchViewPoint.x > rightX) {

            min = mid + 1;

        }

    }

    if (!found) {
        self.moveHLineLabel.frame = CGRectZero;
        self.moveVLineLabel.frame = CGRectZero;
        self.valueNumLabel.frame = CGRectZero;
        self.volumVLineLabel.frame = CGRectZero;
        self.volumHLineLabel.frame = CGRectZero;
        self.volumLabel.frame = CGRectZero;
        self.moveCenterLabel.frame = CGRectZero;
        self.volumCenterLabel.frame = CGRectZero;
    }
    if (found) {
        LSSDataModel * currentModel = self.dataSource[mid];
        CGPoint  currentjkpoint=CGPointFromString([self.jksjMutPointArr objectAtIndex:mid]);
        CGPoint  currentvolumpoint=CGPointFromString([self.volumMutPointArr objectAtIndex:mid]);

        self.moveHLineLabel.frame = CGRectMake(currentjkpoint.x + self.config.spaceLeft + (self.zhuWidth-1)/2.0, self.config.spaceTop, 1, self.klineBackView.frame.size.height);
        self.moveVLineLabel.frame = CGRectMake(0+self.config.spaceLeft, currentjkpoint.y+self.config.spaceTop, self.klineBackView.frame.size.width, 1);
        
        self.moveCenterLabel.frame = CGRectMake(currentjkpoint.x-2+self.config.spaceLeft+ (self.zhuWidth-1)/2.0, currentjkpoint.y-2+self.config.spaceTop, 4, 4);
        
        self.volumVLineLabel.frame = CGRectMake(0+self.config.spaceLeft, currentvolumpoint.y+self.config.spaceTop+self.config.spaceBottom+self.config.lineViewHeight+5, self.volumBackView.frame.size.width, 1);
        self.volumHLineLabel.frame = CGRectMake(currentvolumpoint.x+self.config.spaceLeft + (self.zhuWidth-1)/2.0, self.config.spaceTop+self.config.spaceBottom+self.config.lineViewHeight, 1, self.volumBackView.frame.size.height+10);
        self.volumCenterLabel.frame = CGRectMake(currentvolumpoint.x-2+self.config.spaceLeft + (self.zhuWidth-1)/2.0, currentvolumpoint.y-2+self.config.spaceTop+self.config.spaceBottom+self.config.lineViewHeight+5, 4, 4);

        if (currentjkpoint.x + (self.zhuWidth-1)/2.0 > self.klineBackView.frame.size.width/2.0) {
            self.valueNumLabel.frame = CGRectMake(self.frame.size.width-self.config.spaceRight-30+self.zhuWidth/2.0, currentjkpoint.y-7.5+self.config.spaceTop, 30, 15);
            self.volumLabel.frame = CGRectMake(self.frame.size.width-self.config.spaceRight-30+self.zhuWidth/2.0, currentvolumpoint.y-7.5+self.config.spaceTop+self.config.spaceBottom+self.config.lineViewHeight, 30, 15);

        }else{
            self.valueNumLabel.frame = CGRectMake(0+self.config.spaceLeft-self.zhuWidth/2.0, currentjkpoint.y-7.5+self.config.spaceTop, 30, 15);
            self.volumLabel.frame = CGRectMake(0+self.config.spaceLeft-self.zhuWidth/2.0, currentvolumpoint.y-7.5+self.config.spaceTop+self.config.spaceBottom+self.config.lineViewHeight, 30, 15);

        }
        self.valueNumLabel.text = currentModel.jksj;
        self.volumLabel.text = currentModel.xl;
        [self.delegate valuesLbWithModel:currentModel];
    }
    if (longResture.state == UIGestureRecognizerStateEnded) {
        self.moveHLineLabel.frame = CGRectZero;
        self.moveVLineLabel.frame = CGRectZero;
        self.valueNumLabel.frame = CGRectZero;
        self.volumVLineLabel.frame = CGRectZero;
        self.volumHLineLabel.frame = CGRectZero;
        self.volumLabel.frame = CGRectZero;
        self.moveCenterLabel.frame = CGRectZero;
        self.volumCenterLabel.frame = CGRectZero;
    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];

    if (touch.view == self.klineBackView || touch.view == self.volumBackView) {
        CGPoint point = [touch  locationInView:self.klineBackView];
        beginTouchPoint = point;

    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    if (touch.view == self.klineBackView || touch.view == self.volumBackView) {

        CGPoint point = [touch  locationInView:self.klineBackView];
        if (point.x > beginTouchPoint.x) {
            int counts = (point.x - beginTouchPoint.x)/self.zhuWidth;
            if (counts > 0) {
                if (self.delegate) {
                    [self.delegate moveViewWithIsLeft:NO Count:counts];
                }
                beginTouchPoint = point;
            }
        }else{
            
            int counts = (beginTouchPoint.x - point.x)/self.zhuWidth;
            if (counts > 0) {
                if (self.delegate) {
                    [self.delegate moveViewWithIsLeft:YES Count:counts];
                }
                beginTouchPoint = point;
            }

        }
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
}
int sl =0;

-(void)touchBoxAction:(UIPinchGestureRecognizer*)pGesture{
    UIPinchGestureRecognizer* ges = (UIPinchGestureRecognizer*)pGesture;
    NSUInteger touchCount = ges.numberOfTouches;
    UIGestureRecognizerState state = [pGesture state];
    if (touchCount == 2) {
        CGFloat spacs = 0;
        if (state == UIGestureRecognizerStateBegan){
           
            oneBeginPinchPoint = [pGesture locationOfTouch: 0 inView:self.klineBackView ];
        
            twoBeginPinchPoint = [pGesture locationOfTouch: 1 inView:self.klineBackView ];
            if (oneBeginPinchPoint.x > twoBeginPinchPoint.x) {
                spacs = oneBeginPinchPoint.x - twoBeginPinchPoint.x;

            }else{
                spacs = twoBeginPinchPoint.x - oneBeginPinchPoint.x;
            }
        }
        else if (state == UIGestureRecognizerStateChanged){
           
            //第一个手指坐标
            CGPoint currentOnePoint = [pGesture locationOfTouch: 0 inView:self.klineBackView ];
            //第二个手指坐标
            CGPoint currentTwoPoint = [pGesture locationOfTouch: 1 inView:self.klineBackView ];
            if (oneBeginPinchPoint.x > twoBeginPinchPoint.x) {
                if (currentOnePoint.x > oneBeginPinchPoint.x) {
                     CGFloat distance = currentOnePoint.x - oneBeginPinchPoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:NO isAdd:NO];
                        oneBeginPinchPoint = currentOnePoint;
                    }


                }else{
                     CGFloat distance = oneBeginPinchPoint.x - currentOnePoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:NO isAdd:YES];
                        oneBeginPinchPoint = currentOnePoint;
                    }

                }
                if (currentTwoPoint.x > twoBeginPinchPoint.x) {
                     CGFloat distance = currentTwoPoint.x - twoBeginPinchPoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:YES isAdd:YES];
                        twoBeginPinchPoint = currentTwoPoint;
                    }


                }else{
                     CGFloat distance = twoBeginPinchPoint.x - currentTwoPoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:YES isAdd:NO];
                        twoBeginPinchPoint = currentTwoPoint;
                    }

                }


            }else{
                if (currentOnePoint.x > oneBeginPinchPoint.x) {
                     CGFloat distance = currentOnePoint.x - oneBeginPinchPoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:YES isAdd:YES];
                        oneBeginPinchPoint = currentOnePoint;
                    }


                }else{
                     CGFloat distance = oneBeginPinchPoint.x - currentOnePoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:YES isAdd:NO];
                        oneBeginPinchPoint = currentOnePoint;
                    }

                }
                if (currentTwoPoint.x > twoBeginPinchPoint.x) {
                     CGFloat distance = currentTwoPoint.x - twoBeginPinchPoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:NO isAdd:NO];
                        twoBeginPinchPoint = currentTwoPoint;
                    }


                }else{
                     CGFloat distance = twoBeginPinchPoint.x - currentTwoPoint.x;
                    if (distance >= self.zhuWidth) {
                        [self.delegate scaleViewWithIsLeft:NO isAdd:YES];
                        twoBeginPinchPoint = currentTwoPoint;
                    }

                }

            }
            

        }
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
