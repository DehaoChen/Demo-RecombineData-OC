//
//  CDH_CarItem.h
//  RecombineData-OC
//
//  Created by chendehao on 16/8/8.
//  Copyright © 2016年 CDHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDH_CarItem : NSObject

/** name */
@property (nonatomic, copy) NSString *Name;
/** pbid */
@property (nonatomic, copy) NSString *Pbid;


/** 提供一个数组转模型的快速创建的方法 */
+ (instancetype)carItemWithDictionary: (NSDictionary *)dict ;

@end
