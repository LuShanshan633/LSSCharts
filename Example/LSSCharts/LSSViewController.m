//
//  LSSViewController.m
//  LSSCharts
//
//  Created by LuShanshan633 on 08/27/2020.
//  Copyright (c) 2020 LuShanshan633. All rights reserved.
//

#import "LSSViewController.h"
#import <LSSCharts/LSSCharts-umbrella.h>

@interface LSSViewController ()<LSSLineViewDelegate,TabButtonViewDelegate>
{
    LSSLineView * bezierView;
    TabButtonView * tabView;
    
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

    tabView = [[TabButtonView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30)];
    tabView.delegate = self;
    [tabView initWithView];
    [tabView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:tabView];
   
    [self data];

    bezierView = [[LSSLineView alloc]initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-110-49-25)];
    bezierView.points = _dataMutArr;
    bezierView.delegate = self;
    bezierView.isDragging = YES;
    [bezierView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:bezierView];
    [bezierView startDroke];
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
