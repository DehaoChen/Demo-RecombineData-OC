//
//  CDH_CarItem.m
//  RecombineData-OC
//
//  Created by chendehao on 16/8/8.
//  Copyright © 2016年 CDHao. All rights reserved.
//

#import "CDH_CarItem.h"

@implementation CDH_CarItem

+ (instancetype)carItemWithDictionary:(NSDictionary *)dict{
    
    CDH_CarItem *carItem = [[self alloc] init];
    
    // 字典转模型
    [carItem setValuesForKeysWithDictionary:dict];
    
    return carItem;
}

@end
