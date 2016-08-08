//
//  CDH_CarBrandItem.h
//  RecombineData-OC
//
//  Created by chendehao on 16/8/8.
//  Copyright © 2016年 CDHao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CDH_CarItem;

@interface CDH_CarBrandItem : NSObject

/** CarItem */
//@property (nonatomic, strong) CDH_CarItem *car;

/** name */
@property (nonatomic, copy) NSString *Name;
/** pbid */
@property (nonatomic, copy) NSString *Pbid;


/** Group */
@property (nonatomic, copy) NSString *Letter;

@end
