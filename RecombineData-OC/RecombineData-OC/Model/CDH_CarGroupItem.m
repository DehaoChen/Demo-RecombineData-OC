//
//  CDH_CarGroupItem.m
//  RecombineData-OC
//
//  Created by chendehao on 16/8/8.
//  Copyright © 2016年 CDHao. All rights reserved.
//

#import "CDH_CarGroupItem.h"

@implementation CDH_CarGroupItem

- (NSMutableArray<CDH_CarItem *> *)cars{
    if (!_cars) {
        _cars = [[NSMutableArray alloc] init];
    }
    return _cars;
}

@end
