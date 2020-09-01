//
//  LSSChartsBaseView.m
//  LSSCharts
//
//  Created by 陆闪闪 on 2020/8/28.
//

#import "LSSChartsBaseView.h"
@implementation LSSChartsBaseView
-(instancetype)initWithConfig:(LSSChartsConfig *)config frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.config = config;
        self.config.kRiseColor = config.kRiseColor ? config.kRiseColor : [UIColor redColor];
        self.config.kFallColor = config.kFallColor ? config.kFallColor : [UIColor greenColor];
        self.config.spaceTop = config.spaceTop > 0 ? self.config.spaceTop:30;
        self.config.spaceBottom = config.spaceBottom > 0 ? self.config.spaceBottom : 30;
        self.config.spaceLeft = config.spaceLeft > 0 ? self.config.spaceLeft:30;
        self.config.spaceRight = config.spaceRight > 0 ? self.config.spaceRight:30;

        self.config.lineViewHeight = config.lineViewHeight > 0 ? config.lineViewHeight : self.frame.size.height/3.0*2.0 - config.spaceTop - config.spaceBottom;

        self.backgroundColor =  [UIColor whiteColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{

}
///折线图背景线
-(void)drawNumBackLine{
    CGContextRef  contextss = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contextss, kCGLineCapRound);
    
    CGContextSetLineWidth(contextss, 1);  //线宽
    CGContextSetRGBStrokeColor(contextss, 0.5, 0.5, 0.5, 0.5);//线条颜色
    CGFloat top = self.config.spaceTop;
    CGContextMoveToPoint(contextss,  self.config.spaceLeft ,  top - 5);  //起点坐标
    CGContextAddLineToPoint(contextss,  self.config.spaceLeft, self.config.lineViewHeight+top+5);   //终点坐标
    
    CGContextMoveToPoint(contextss, self.viewWidth+ self.config.spaceLeft , top - 5);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+ self.config.spaceLeft, self.config.lineViewHeight+top+5);   //终点坐标
    CGContextMoveToPoint(contextss,  self.config.spaceLeft , top - 5);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+ self.config.spaceLeft, top - 5);   //终点坐标
    CGContextMoveToPoint(contextss,  self.config.spaceLeft , self.config.lineViewHeight+top+5);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+ self.config.spaceLeft, self.config.lineViewHeight+top+5);   //终点坐标

    CGContextStrokePath(contextss);
    
    CGContextRef  contexts = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contexts, kCGLineCapRound);
    
    CGContextSetLineWidth(contexts, 1);  //线宽
    CGContextSetRGBStrokeColor(contexts, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGFloat lengths[] = {3,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    for (int i =0; i<5; i++) {
        
        CGContextMoveToPoint(contexts,  self.config.spaceLeft , self.config.lineViewHeight /4.0*i+ self.config.spaceTop);  //起点坐标
        CGContextAddLineToPoint(contexts, self.viewWidth+ self.config.spaceLeft,  self.config.lineViewHeight/4.0*i + top);   //终点坐标
        
    }
    
    
    CGContextStrokePath(contexts);
}
///K线图背景线
-(void)drawLineBackLine{
    CGContextRef  contextss = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contextss, kCGLineCapRound);
    
    CGContextSetLineWidth(contextss, 1);  //线宽
    CGContextSetRGBStrokeColor(contextss, 0.5, 0.5, 0.5, 0.5);//线条颜色
    //线图区域顶部距离view留空距离
    CGFloat top = self.config.spaceTop;
    CGFloat lineHalf = self.zhuWidth/2.0;
    
    ///左侧线
    CGContextMoveToPoint(contextss,  self.config.spaceLeft -lineHalf ,  top - 5);  //起点坐标
    CGContextAddLineToPoint(contextss,  self.config.spaceLeft - lineHalf, self.config.lineViewHeight+top+5);   //终点坐标
    ///右侧
    CGContextMoveToPoint(contextss, self.viewWidth+ self.config.spaceLeft + lineHalf , top - 5);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+ self.config.spaceLeft+lineHalf, self.config.lineViewHeight+top+5);   //终点坐标
    ///上
    CGContextMoveToPoint(contextss,  self.config.spaceLeft-lineHalf , top - 5);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+ self.config.spaceLeft+lineHalf, top - 5);   //终点坐标
    
    ///下
    CGContextMoveToPoint(contextss,  self.config.spaceLeft - lineHalf, self.config.lineViewHeight+top+5);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+ self.config.spaceLeft+lineHalf, self.config.lineViewHeight+top+5);   //终点坐标
    CGContextStrokePath(contextss);
    
    CGContextRef  contexts = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contexts, kCGLineCapRound);
    
    CGContextSetLineWidth(contexts, 1);  //线宽
    CGContextSetRGBStrokeColor(contexts, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGFloat lengths[] = {3,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    for (int i =0; i<5; i++) {
        
        CGContextMoveToPoint(contexts,  self.config.spaceLeft - lineHalf, self.config.lineViewHeight/4.0*i+top);  //起点坐标
        CGContextAddLineToPoint(contexts, self.viewWidth+ self.config.spaceLeft+lineHalf,  self.config.lineViewHeight/4*i + top);   //终点坐标
        
    }
    
    
    CGContextStrokePath(contexts);

}
//成交量的背景线
-(void)drawDealVolumBackLine{
    CGContextRef  contextss = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contextss, kCGLineCapRound);
    
    CGContextSetLineWidth(contextss, 1);  //线宽
    CGContextSetRGBStrokeColor(contextss, 0.5, 0.5, 0.5, 0.5);//线条颜色
    CGFloat top = self.config.lineViewHeight + self.config.spaceBottom + self.config.spaceTop;
    CGFloat H = self.frame.size.height - top;
    CGFloat w = self.chartsType == LSSBezierCharts ? self.viewWidth : self.viewWidth + self.zhuWidth;
    CGFloat left = self.chartsType == LSSBezierCharts ?  self.config.spaceLeft :  self.config.spaceLeft - self.zhuWidth/2.0;
    //左侧
    CGContextMoveToPoint(contextss, left ,  top);  //起点坐标
    CGContextAddLineToPoint(contextss, left, H+top);   //终点坐标
    //右侧
    CGContextMoveToPoint(contextss, left + w , top);  //起点坐标
    CGContextAddLineToPoint(contextss, left + w, H+top);   //终点坐标
    //
    CGContextMoveToPoint(contextss, left , H+top);  //起点坐标
    CGContextAddLineToPoint(contextss, left + w,  H+top);   //终点坐标
    CGContextMoveToPoint(contextss, left ,  top);  //起点坐标
    CGContextAddLineToPoint(contextss, left + w,  top);   //终点坐标

    CGContextStrokePath(contextss);
    self.volumBackView.frame = CGRectMake(left + self.zhuWidth/2.0, top+5, w - self.zhuWidth, self.frame.size.height - self.config.lineViewHeight - self.config.spaceTop-self.config.spaceBottom-10);
}


//将所有数据转化为坐标点
-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
   self.alldataSourceArr = [[NSMutableArray alloc]init];
    NSMutableArray * valomArr = [NSMutableArray new];
    //获取所有数据的最大值、最小值
    for (LSSDataModel * model in dataSource) {
        [self.alldataSourceArr addObject:[NSString stringWithFormat:@"%@",model.zdj]];
        [self.alldataSourceArr addObject:[NSString stringWithFormat:@"%@",model.zgj]];
        [valomArr addObject:[NSString stringWithFormat:@"%@",model.xl]];
        
    }
    self.maxNum = [self maxWithArr:self.alldataSourceArr];
    self.minNum = [self minWithArr:self.alldataSourceArr];
    //线形图图形区域宽度
    self.viewWidth = self.frame.size.width- self.config.spaceLeft- self.config.spaceRight;
    //一组数据的最大值最小值的差
    CGFloat spese = self.maxNum - self.minNum;
    //线形图图形区域高度
    //可拖动区域view
    

    CGFloat sup = self.config.lineViewHeight/spese;
    
    self.zgjMutPointArr = [[NSMutableArray alloc]init];
    self.zdjMutPointArr = [[NSMutableArray alloc]init];
    self.jksjMutPointArr = [[NSMutableArray alloc]init];
    self.zspjMutPointArr = [[NSMutableArray alloc]init];
    self.volumMutPointArr = [[NSMutableArray alloc]init];
    //线形图图形区域点之间的间隔
    CGFloat lineWidth = [self lineWidths:dataSource viewWidth:self.viewWidth];
    self.zhuWidth = lineWidth;
    self.klineBackView.frame = CGRectMake( self.config.spaceLeft-self.zhuWidth/2.0, self.config.spaceTop, self.viewWidth+self.zhuWidth, self.config.lineViewHeight);

    CGFloat volumHeight = self.frame.size.height - self.config.lineViewHeight - self.config.spaceBottom - self.config.spaceTop-10;
    CGFloat volumMax = [self maxWithArr:valomArr];
    CGFloat volumMin = [self minWithArr:valomArr];
    CGFloat volumSup = volumHeight / (volumMax - volumMin);
    for ( int i = 0; i<dataSource.count; i++) {
        LSSDataModel * model = [dataSource objectAtIndex:i];
        CGFloat zgjY =(self.maxNum -[model.zgj floatValue]) *sup;
        CGPoint zgjPoint = CGPointMake(lineWidth*i,zgjY);
        [self.zgjMutPointArr addObject: NSStringFromCGPoint(zgjPoint)];

        CGFloat zdjY =(self.maxNum -[model.zdj floatValue]) *sup;
        CGPoint zdjPoint = CGPointMake(lineWidth*i,zdjY);
        [self.zdjMutPointArr addObject: NSStringFromCGPoint(zdjPoint)];

        CGFloat jksjY =(self.maxNum -[model.jksj floatValue]) *sup;
        CGPoint jksjPoint = CGPointMake(lineWidth*i,jksjY);
        [self.jksjMutPointArr addObject: NSStringFromCGPoint(jksjPoint)];

        CGFloat zspjY =(self.maxNum -[model.zspj floatValue]) *sup;
        CGPoint zspjPoint = CGPointMake(lineWidth*i,zspjY);
        [self.zspjMutPointArr addObject: NSStringFromCGPoint(zspjPoint)];
        
        CGFloat volumY =(volumMax -[model.xl floatValue]) *volumSup;
        CGPoint volumPoint = CGPointMake(lineWidth*i,volumY);
        [self.volumMutPointArr addObject: NSStringFromCGPoint(volumPoint)];
    }

}
//获取📊柱子宽度
-(CGFloat)lineWidths:(NSMutableArray*)arr viewWidth:(CGFloat)viewWidth{
    return viewWidth/(arr.count - 1);
}

-(CGFloat)maxWithArr:(NSArray *)arr{
    CGFloat max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];

    return max;
}

-(CGFloat)minWithArr:(NSArray*)arr{
    CGFloat min = [[arr valueForKeyPath:@"@min.floatValue"] floatValue];
    
    return min;

}
-(UIView *)klineBackView{
    if (!_klineBackView) {
        _klineBackView = [[UIView alloc]init];
//        _klineBackView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.5];
        [self addSubview:_klineBackView];
    }
    return _klineBackView;
}
-(UIView *)volumBackView{
    if (!_volumBackView) {
        _volumBackView = [[UIView alloc]init];
//        _volumBackView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.3];
        [self addSubview:_volumBackView];
    }
    return _volumBackView;
}

-(UILabel *)moveHLineLabel{
    if (!_moveHLineLabel) {
        _moveHLineLabel = [[UILabel alloc]init];
        _moveHLineLabel.backgroundColor = self.config.showMoveLineColor;
        [self.klineBackView addSubview:_moveHLineLabel];
    }
    return _moveHLineLabel;
}
-(UILabel *)moveVLineLabel{
    if (!_moveVLineLabel) {
        _moveVLineLabel = [[UILabel alloc]init];
        _moveVLineLabel.backgroundColor = self.config.showMoveLineColor;
        [self.klineBackView addSubview:_moveVLineLabel];
    }
    return _moveVLineLabel;
}

-(UILabel *)volumLabel{
    if (!_volumLabel) {
        _volumLabel = [[UILabel alloc]init];
        _volumLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _volumLabel.textAlignment = NSTextAlignmentCenter;
        _volumLabel.backgroundColor = self.config.showMoveTitleBackColor;
        _volumLabel.textColor = self.config.showMoveLabelTitleColor;
        [self.volumBackView addSubview:_volumLabel];
    }
    return _volumLabel;
}
-(UILabel *)volumHLineLabel{
    if (!_volumHLineLabel) {
        _volumHLineLabel = [[UILabel alloc]init];
        _volumHLineLabel.backgroundColor = self.config.showMoveLineColor;
        [self.volumBackView addSubview:_volumHLineLabel];
    }
    return _volumHLineLabel;
}
-(UILabel *)volumVLineLabel{
    if (!_volumVLineLabel) {
        _volumVLineLabel = [[UILabel alloc]init];
        _volumVLineLabel.backgroundColor = self.config.showMoveLineColor;
        [self.volumBackView addSubview:_volumVLineLabel];
    }
    return _volumVLineLabel;
}

-(UILabel *)valueNumLabel{
    if (!_valueNumLabel) {
        _valueNumLabel = [[UILabel alloc]init];
        _valueNumLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _valueNumLabel.textAlignment = NSTextAlignmentCenter;
        _valueNumLabel.backgroundColor = self.config.showMoveTitleBackColor;
        _valueNumLabel.textColor = self.config.showMoveLabelTitleColor;
        [self.klineBackView addSubview:_valueNumLabel];
    }
    return _valueNumLabel;
}

-(UILabel *)timeNumLabel{
    if (!_timeNumLabel) {
        _timeNumLabel = [[UILabel alloc]init];
        _timeNumLabel.backgroundColor = self.config.showMoveTitleBackColor;
        _timeNumLabel.textColor = self.config.showMoveLabelTitleColor;
        [self.klineBackView addSubview:_timeNumLabel];
    }     return _timeNumLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
