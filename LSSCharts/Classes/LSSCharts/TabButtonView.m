

//
//  TabButtonView.m
//  STLPro
//
//  Created by maia on 16/5/10.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "TabButtonView.h"
#import "UIImage+Utilities.h"
#define LSSScreenWidth [UIScreen mainScreen].bounds.size.width
#define LSSScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation TabButtonView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self == [super initWithFrame:frame]) {
        [self initWithViewFrame:frame];
    }
    return self;
}
-(void)initWithView{
    if (_isHeng == YES) {
        for(int i = 0;i<10;i++){
            
            UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake((self.frame.size.width - 30)/10*i, 0, (self.frame.size.width - 30)/10, self.frame.size.height);
            [selectBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [selectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [selectBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"jiaoyipinxiangqing"] forState:UIControlStateSelected];
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            
            if (i  == _Type) {
                selectBtn.selected  =YES;
            }
            if (i == 0) {
                [selectBtn setTitle:@"分时" forState:UIControlStateNormal];
            }
            else if (i == 1){
                
                [selectBtn setTitle:@"5日" forState:UIControlStateNormal];
            }
            else if (i == 2){
                
                [selectBtn setTitle:@"日K" forState:UIControlStateNormal];
            }
            else if (i == 3){
                
                [selectBtn setTitle:@"周K" forState:UIControlStateNormal];
            }
            else if (i == 4){
                
                [selectBtn setTitle:@"月K" forState:UIControlStateNormal];
            }
            else if (i == 5){
                
                [selectBtn setTitle:@"1分" forState:UIControlStateNormal];
            }
            else if (i == 6){
                
                [selectBtn setTitle:@"3分" forState:UIControlStateNormal];
            }
            else if (i == 7){
                
                [selectBtn setTitle:@"5分" forState:UIControlStateNormal];
            }
            else if (i == 8){
                
                [selectBtn setTitle:@"15分" forState:UIControlStateNormal];
            }
            
            else{
                [selectBtn setTitle:@"30分" forState:UIControlStateNormal];
            }
            selectBtn.tag  = i;
            
            [selectBtn addTarget:self action:@selector(selectOther:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:selectBtn];
        }
        
    }
    else{
        for(int i = 0;i<6;i++){
            
            UIButton * selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake((self.frame.size.width - 30)/6*i, 0, (self.frame.size.width - 30)/6, self.frame.size.height);
            [selectBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            [selectBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [selectBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"jiaoyipinxiangqing"] forState:UIControlStateSelected];
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            
            if (i  == _Type) {
                selectBtn.selected  =YES;
            }
            if (i == 0) {
                [selectBtn setTitle:@"分时" forState:UIControlStateNormal];
            }
            else if (i == 1){
                
                [selectBtn setTitle:@"5日" forState:UIControlStateNormal];
            }
            else if (i == 2){
                
                [selectBtn setTitle:@"日K" forState:UIControlStateNormal];
            }
            else if (i == 3){
                
                [selectBtn setTitle:@"周K" forState:UIControlStateNormal];
            }
            else if (i == 4){
                
                [selectBtn setTitle:@"月K" forState:UIControlStateNormal];
            }
            else{
                [selectBtn setTitle:@"分钟" forState:UIControlStateNormal];
            }
            selectBtn.tag  = i;
            
            [selectBtn addTarget:self action:@selector(selectOther:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:selectBtn];
        }
        
        UIImageView * jiaoImg = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 40), 7, 18, 25)];
        jiaoImg.image = [UIImage imageNamed:@"fenzhongxiala"];
        [self addSubview:jiaoImg];
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width , 0.5)];
        [lb setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:lb];
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LSSScreenWidth, LSSScreenHeight)];
        backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [[UIApplication sharedApplication].keyWindow.viewForBaselineLayout addSubview:backView];
        UIButton * btn = [[UIButton alloc]initWithFrame:backView.frame];
        
        [btn addTarget:self action:@selector(hideBackView) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:btn];
        for (int i = 0; i < 5; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((self.frame.size.width - 30)/6*5, (64 + 40 + LSSScreenWidth/3.1)+30*i, (self.frame.size.width - 30)/6, 30);
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            if (i == 0) {
                [btn setTitle:@"1分" forState:UIControlStateNormal];
            }
            else if (i == 1){
                [btn setTitle:@"3分" forState:UIControlStateNormal];
            }
            else if (i == 2){
                [btn setTitle:@"5分" forState:UIControlStateNormal];
            }
            else if (i == 3){
                [btn setTitle:@"15分" forState:UIControlStateNormal];
            }
            else if (i == 4){
                [btn setTitle:@"30分" forState:UIControlStateNormal];
            }
            btn.tag = i;
            UILabel * lineLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 29, (self.frame.size.width - 30)/6-10, 1)];
            [lineLb setBackgroundColor:[UIColor lightGrayColor]];
            [btn addSubview:lineLb];
            [btn addTarget:self action:@selector(selectMinute:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
        }
        backView.hidden = YES;
        
    }

}

-(void)initWithViewFrame:(CGRect)frame{


}
-(void)selectMinute:(UIButton *)sender{
    backView.hidden = YES;
    [_delegate selectWithIndex:sender.tag+5];
    for (UIView * views in self.subviews) {
        if ([[views class] isSubclassOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton *)views;
            if (btn.tag == 5) {
                btn.selected = YES;
                [btn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
            }
            else{
                btn.selected = NO;
            }
            
        }
    }

    
}
-(void)hideBackView{
    backView.hidden = YES;

}

-(void)selectOther:(UIButton *)sender{
    
    if (_isHeng == YES) {
        
        for (UIView * views in self.subviews) {
            if ([[views class] isSubclassOfClass:[UIButton class]]) {
                UIButton * btn = (UIButton *)views;
                    if (btn.tag == sender.tag) {
                        btn.selected = YES;
                        [_delegate selectWithIndex:sender.tag];

                    }
                    else{
                        
                        btn.selected = NO;
                    }
                
            }
        }

    }
    else{
        
        for (UIView * views in self.subviews) {
            if ([[views class] isSubclassOfClass:[UIButton class]]) {
                UIButton * btn = (UIButton *)views;
                if (sender.tag == 5) {
                    backView.hidden = NO;
                }
                else{
                    if (btn.tag == sender.tag) {
                        btn.selected = YES;
                        [_delegate selectWithIndex:sender.tag];

                    }
                    else{
                        if (btn.tag == 5) {
                            [btn setTitle:@"分钟" forState:UIControlStateNormal];
                        }
                        btn.selected = NO;
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
