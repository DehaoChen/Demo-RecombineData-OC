//
//  CDH_CarGroupItem.h
//  RecombineData-OC
//
//  Created by chendehao on 16/8/8.
//  Copyright © 2016年 CDHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDH_CarItem;

@interface CDH_CarGroupItem : NSObject

/** CarItem */
//@property (nonatomic, strong) NSMutableArray *cars;
@property (nonatomic, strong) NSMutableArray<CDH_CarItem *> *cars;
// 注意上面这个数组一定要通过懒加载创建

/** Group */
@property (nonatomic, copy) NSString *Letter;

@end
