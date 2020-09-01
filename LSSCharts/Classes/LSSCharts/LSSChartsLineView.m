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
        lineLbZhu.frame =CGRectMake(currentPoint.x-xWidth/2.0, currentPoint.y, xWidth, self.frame.size.height - self.config.lineViewHeight - self.config.spaceTop - self.config.spaceBottom - currentPoint.y - 5);

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
        CGFloat  xWidth  = self.zhuWidth - 1;

        UILabel * lineLb = [[UILabel alloc]initWithFrame:CGRectMake(currentPoint.x + xWidth/2.0, currentPoint.y, 0.5, previousPoint.y -currentPoint.y)];
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
            lineLbZhu.frame =CGRectMake(currentPointZhu.x, currentPointZhu.y, xWidth, previousPointZhu.y -currentPointZhu.y+0.5);

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
    }
    if (found) {
        LSSDataModel * currentModel = self.dataSource[mid];
        CGPoint  currentjkpoint=CGPointFromString([self.jksjMutPointArr objectAtIndex:mid]);
        CGPoint  currentvolumpoint=CGPointFromString([self.volumMutPointArr objectAtIndex:mid]);

        self.moveHLineLabel.frame = CGRectMake(currentjkpoint.x + (self.zhuWidth-1)/2.0, 0, 1, self.klineBackView.frame.size.height);
        self.moveVLineLabel.frame = CGRectMake(0, currentjkpoint.y, self.klineBackView.frame.size.width, 1);
        self.volumVLineLabel.frame = CGRectMake(0, currentvolumpoint.y, self.volumBackView.frame.size.width, 1);
        self.volumHLineLabel.frame = CGRectMake(currentvolumpoint.x , -5, 1, self.volumBackView.frame.size.height+10);

        if (currentjkpoint.x + (self.zhuWidth-1)/2.0 > self.klineBackView.frame.size.width/2.0) {
            self.valueNumLabel.frame = CGRectMake(self.klineBackView.frame.size.width-30, currentjkpoint.y-7.5, 30, 15);
            self.volumLabel.frame = CGRectMake(self.volumBackView.frame.size.width-30, currentvolumpoint.y-7.5, 30, 15);

        }else{
            self.valueNumLabel.frame = CGRectMake(0, currentjkpoint.y-7.5, 30, 15);
            self.volumLabel.frame = CGRectMake(0, currentvolumpoint.y-7.5, 30, 15);

        }
        self.valueNumLabel.text = currentModel.jksj;
        self.volumLabel.text = currentModel.xl;
    }
    if (longResture.state == UIGestureRecognizerStateEnded) {
        self.moveHLineLabel.frame = CGRectZero;
        self.moveVLineLabel.frame = CGRectZero;
        self.valueNumLabel.frame = CGRectZero;
        self.volumVLineLabel.frame = CGRectZero;
        self.volumHLineLabel.frame = CGRectZero;
        self.volumLabel.frame = CGRectZero;
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
