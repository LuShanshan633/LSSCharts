//
//  LSSViewController.m
//  LSSCharts
//
//  Created by LuShanshan633 on 08/27/2020.
//  Copyright (c) 2020 LuShanshan633. All rights reserved.
//

#import "LSSViewController.h"
#import <LSSCharts/LSSCharts.h>

@interface LSSViewController ()<LSSChartsViewDelegate,TabButtonViewDelegate>
{
    LSSLineView * bezierView;
    TabButtonView * tabView;
    LSSChartsLineView * lineView;
    
}
@property(nonatomic,strong)NSMutableArray * dataMutArr;

@end

@implementation LSSViewController
- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    tabView = [[TabButtonView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30)];
//    tabView.delegate = self;
//    [tabView initWithView];
//    [tabView setBackgroundColor:[UIColor whiteColor]];
//    [self.view addSubview:tabView];
//
    [self data];

//    bezierView = [[LSSLineView alloc]initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-110-49-25)];
//    bezierView.points = _dataMutArr;
//    bezierView.delegate = self;
//    bezierView.isDragging = YES;
//    [bezierView setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:bezierView];
//    [bezierView startDroke];
    LSSChartsConfig * config = [LSSChartsConfig new];
//    config.kRiseColor = [UIColor redColor];
//    config.kFallColor = [UIColor greenColor];
    config.lineBlueColor = [UIColor blueColor];
    config.lineRedColor = [UIColor redColor];
    config.lineYellowColor = [UIColor yellowColor];
    config.showMoveLineColor = [UIColor lightGrayColor];
    config.showMoveTitleBackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    config.showMoveLabelTitleColor = [UIColor whiteColor];
    lineView = [[LSSChartsLineView alloc]initWithConfig:config frame:CGRectMake(0, 110, self.view.frame.size.width, 300)];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.delegate = self;
    lineView.dataSource = _dataMutArr;
    lineView.chartsType = LSSLineCharts;
    [self.view addSubview:lineView];
    [lineView drawStroke];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)data{
    _dataMutArr = [NSMutableArray new];
    for (int i =0 ; i<50; i++) {
        int val = [self getRandomNumber:11 to:20];
        int val1 = [self getRandomNumber:1 to:10];
        int val2 =  [self getRandomNumber:val1 to:val];
        int val3 = [self getRandomNumber:val1 to:val];
        int val4 = [self getRandomNumber:1 to:200];
        LSSDataModel * model = [[LSSDataModel alloc]init];
        model.zgj =[NSString stringWithFormat:@"%d",val] ;
        model.zdj = [NSString stringWithFormat:@"%d",val1];
        model.jksj = [NSString stringWithFormat:@"%d",val2];
        model.zspj = [NSString stringWithFormat:@"%d",val3];
        model.xl = [NSString stringWithFormat:@"%d",val4];
        [_dataMutArr addObject:model];
    }

}
-(void)moveViewWithIsLeft:(BOOL)isLeft Count:(int)count{
    if (isLeft == YES) {
        [_dataMutArr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)]];
        for (int i =0 ; i<count; i++) {
            int val = [self getRandomNumber:11 to:20];
            int val1 = [self getRandomNumber:1 to:10];
            int val2 =  [self getRandomNumber:val1 to:val];
            int val3 = [self getRandomNumber:val1 to:val];
            int val4 = [self getRandomNumber:1 to:200];
            LSSDataModel * model = [[LSSDataModel alloc]init];
            model.zgj =[NSString stringWithFormat:@"%d",val] ;
            model.zdj = [NSString stringWithFormat:@"%d",val1];
            model.jksj = [NSString stringWithFormat:@"%d",val2];
            model.zspj = [NSString stringWithFormat:@"%d",val3];
            model.xl = [NSString stringWithFormat:@"%d",val4];
            [_dataMutArr addObject:model];
            
        }
        lineView.dataSource = _dataMutArr;
        [lineView drawStroke];
        
    }
    else{
        [_dataMutArr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_dataMutArr.count - count, count)]];
        for (int i =0 ; i<count; i++) {
            int val = [self getRandomNumber:11 to:20];
            int val1 = [self getRandomNumber:1 to:10];
            int val2 =  [self getRandomNumber:val1 to:val];
            int val3 = [self getRandomNumber:val1 to:val];
            int val4 = [self getRandomNumber:1 to:200];
            LSSDataModel * model = [[LSSDataModel alloc]init];
            model.zgj =[NSString stringWithFormat:@"%d",val] ;
            model.zdj = [NSString stringWithFormat:@"%d",val1];
            model.jksj = [NSString stringWithFormat:@"%d",val2];
            model.zspj = [NSString stringWithFormat:@"%d",val3];
            model.xl = [NSString stringWithFormat:@"%d",val4];
            [_dataMutArr insertObject:model atIndex:0];
            
        }
        
        lineView.dataSource = _dataMutArr;
        [lineView drawStroke];

    }

}
-(void)valuesLbWithModel:(LSSDataModel*)model{
    
}

-(void)selectWithIndex:(NSInteger)index{
    bezierView.Type = index;
    [bezierView startDroke];
    NSLog(@"%ld",(long)index);
}

-(void)scaleViewWithDOrX:(BOOL)isDa{

    if (isDa == YES) {
        [_dataMutArr removeLastObject];
        [_dataMutArr removeObjectAtIndex:0];
        [bezierView startDroke];
    }
    else{
        int val = [self getRandomNumber:11 to:20];
        int val1 = [self getRandomNumber:1 to:10];
        int val2 =  [self getRandomNumber:val1 to:val];
        int val3 = [self getRandomNumber:val1 to:val];
        int val4 = [self getRandomNumber:1 to:200];
        LSSDataModel * model = [[LSSDataModel alloc]init];
        model.zgj =[NSString stringWithFormat:@"%d",val] ;
        model.zdj = [NSString stringWithFormat:@"%d",val1];
        model.jksj = [NSString stringWithFormat:@"%d",val2];
        model.zspj = [NSString stringWithFormat:@"%d",val3];
        model.xl = [NSString stringWithFormat:@"%d",val4];
        [_dataMutArr addObject:model];
        [_dataMutArr insertObject:model atIndex:0];
        [bezierView startDroke];
        
    }
}
-(void)moveViewWithLOrR:(BOOL)isLeft Count:(int)count{
    
    if (isLeft == YES) {
        [_dataMutArr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, count)]];
        for (int i =0 ; i<count; i++) {
            int val = [self getRandomNumber:11 to:20];
            int val1 = [self getRandomNumber:1 to:10];
            int val2 =  [self getRandomNumber:val1 to:val];
            int val3 = [self getRandomNumber:val1 to:val];
            int val4 = [self getRandomNumber:1 to:200];
            LSSDataModel * model = [[LSSDataModel alloc]init];
            model.zgj =[NSString stringWithFormat:@"%d",val] ;
            model.zdj = [NSString stringWithFormat:@"%d",val1];
            model.jksj = [NSString stringWithFormat:@"%d",val2];
            model.zspj = [NSString stringWithFormat:@"%d",val3];
            model.xl = [NSString stringWithFormat:@"%d",val4];
            [_dataMutArr addObject:model];
            
        }
        [bezierView startDroke];
        
        
    }
    else{
        [_dataMutArr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_dataMutArr.count - count, count)]];
        for (int i =0 ; i<count; i++) {
            int val = [self getRandomNumber:11 to:20];
            int val1 = [self getRandomNumber:1 to:10];
            int val2 =  [self getRandomNumber:val1 to:val];
            int val3 = [self getRandomNumber:val1 to:val];
            int val4 = [self getRandomNumber:1 to:200];
            LSSDataModel * model = [[LSSDataModel alloc]init];
            model.zgj =[NSString stringWithFormat:@"%d",val] ;
            model.zdj = [NSString stringWithFormat:@"%d",val1];
            model.jksj = [NSString stringWithFormat:@"%d",val2];
            model.zspj = [NSString stringWithFormat:@"%d",val3];
            model.xl = [NSString stringWithFormat:@"%d",val4];
            [_dataMutArr insertObject:model atIndex:0];
            
        }
        
        [bezierView startDroke];
        
    }
}
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
