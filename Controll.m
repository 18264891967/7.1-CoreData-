//
//  Controll.m
//  7.1 CoreData (本地练习)
//
//  Created by MS on 16-4-27.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "Controll.h"

@implementation Controll
+(UIButton *)creatButtonFrame:(CGRect)frame buttonTitle:(NSString *)title buttonTitleColor:(UIColor *)color
{
    UIButton *button=[[UIButton alloc]init];
    
    button.frame=frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:color forState:UIControlStateNormal];
    
    return button;
}
+(UITextField *)creatTextFiledFrame:(CGRect)frame textFieldPlacehoder:(NSString *)placeholder
{
    UITextField *field=[[UITextField alloc]init];
    
    field.frame=frame;
    
    field.placeholder=placeholder;
    
    return field;
}
@end
