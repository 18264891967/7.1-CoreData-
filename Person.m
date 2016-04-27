//
//  Person.m
//  7.1 CoreData (本地练习)
//
//  Created by MS on 16-4-27.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "Person.h"
/*
@synthesize 
 
@dynamic ;
 
它两者是和属性配合的:
 
@synthesize+属性 ->告诉编译器你不需要手动实现set和get 因为编译器帮你做了
 
@dynamic +属性->告诉编译器你需要手动的实现set和get
 
*/
@implementation Person

@dynamic name;
@dynamic password;

@end
