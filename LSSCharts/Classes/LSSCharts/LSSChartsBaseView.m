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
        
    }
    return self;
}
-(void)drawNumBackLine{
    CGFloat leftSpace = [NSString stringWithFormat:@"%.2f",self.maxNum] .length *6;

    CGContextRef  contextss = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contextss, kCGLineCapRound);
    
    CGContextSetLineWidth(contextss, 1);  //线宽
    CGContextSetRGBStrokeColor(contextss, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGContextMoveToPoint(contextss, leftSpace , 0);  //起点坐标
    CGContextAddLineToPoint(contextss, leftSpace, self.viewHeigth+10);   //终点坐标
    
    CGContextMoveToPoint(contextss, self.viewWidth+leftSpace , 0);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+leftSpace, self.viewHeigth+10);   //终点坐标
    CGContextMoveToPoint(contextss, leftSpace , 0);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+leftSpace, 0);   //终点坐标
    CGContextMoveToPoint(contextss, leftSpace , self.viewHeigth+10);  //起点坐标
    CGContextAddLineToPoint(contextss, self.viewWidth+leftSpace, self.viewHeigth+10);   //终点坐标

    CGContextStrokePath(contextss);
    
    CGContextRef  contexts = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contexts, kCGLineCapRound);
    
    CGContextSetLineWidth(contexts, 1);  //线宽
    CGContextSetRGBStrokeColor(contexts, 0.5, 0.5, 0.5, 0.5);//线条颜色
    
    CGFloat lengths[] = {3,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    for (int i =0; i<5; i++) {
        
        CGContextMoveToPoint(contexts, leftSpace , self.viewHeigth/4*i+5);  //起点坐标
        CGContextAddLineToPoint(contexts, self.viewWidth+leftSpace,  self.viewHeigth/4*i+5);   //终点坐标
        
    }
    
    
    CGContextStrokePath(contexts);

}

-(void)drawVolumBackLine{
    
}

//将所有数据转化为坐标点
-(void)setDataSource:(NSMutableArray *)dataSource{
    self.alldataSourceArr = [[NSMutableArray alloc]init];
    
    for (LSSDataModel * model in dataSource) {
        [self.alldataSourceArr addObject:[NSString stringWithFormat:@"%@",model.zdj]];
        [self.alldataSourceArr addObject:[NSString stringWithFormat:@"%@",model.zgj]];
        
    }
    self.maxNum = [self maxWithArr:self.alldataSourceArr];
    self.minNum = [self minWithArr:self.alldataSourceArr];
    CGFloat leftSpace = [NSString stringWithFormat:@"%.2f",self.maxNum] .length *6;
    self.viewWidth =self.frame.size.width-leftSpace-40;

    CGFloat spese = self.maxNum - self.minNum;
    CGFloat h = self.frame.size.height - 40;
    self.viewHeigth = h ;
    CGFloat sup = h/spese;
    self.zgjMutPointArr = [[NSMutableArray alloc]init];
    self.zdjMutPointArr = [[NSMutableArray alloc]init];
    self.jksjMutPointArr = [[NSMutableArray alloc]init];
    self.zspjMutPointArr = [[NSMutableArray alloc]init];
    CGFloat lineWidth = [self lineWidths:dataSource viewWidth:self.viewWidth];
    self.config.currentLineWidth = lineWidth;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
