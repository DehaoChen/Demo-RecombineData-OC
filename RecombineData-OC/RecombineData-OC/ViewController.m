//
//  ViewController.m
//  RecombineData-OC
//
//  Created by chendehao on 16/8/8.
//  Copyright © 2016年 CDHao. All rights reserved.
//

#import "ViewController.h"
#import "CDH_CarItem.h"
#import "CDH_CarBrandItem.h"
#import "CDH_CarGroupItem.h"
#import <MJExtension/MJExtension.h>

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

/** carGroups */
@property (nonatomic, strong) NSMutableArray<CDH_CarBrandItem *> *carBrandItems;
@property (nonatomic, strong) NSMutableArray<CDH_CarGroupItem *> *carGroupItems;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 读取数据
    NSDictionary *dictionary = [NSDictionary  dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"brand" ofType:@"plist"]];
    NSArray *array = dictionary[@"data"];
    
    // 字典转模型
    _carBrandItems = [CDH_CarBrandItem mj_objectArrayWithKeyValuesArray:array];
    //    NSLog(@"%@",_carBrandItems);
    
    // 将数组重新分组
    _carGroupItems = [self regroupItemWithArray:_carBrandItems];
    
    // 将模型数组转为字典数组,并写成 plist文件
    [self modelArrayTransferToDictionaryArray:_carGroupItems];
    
    
    // 创建控件
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
}

/**
 *  将模型数组写成字典数组, 并且写为 plist 文件
 *
 *  @param array 模型数组
 *
 *  @return 返回字典数组
 */
- (NSMutableArray *)modelArrayTransferToDictionaryArray:(NSMutableArray *)array{
    // 将模型数组转为字典数组,并写成 plist文件
    NSMutableArray *dictCarGroupItems = [NSMutableArray arrayWithCapacity:_carGroupItems.count];
    for (CDH_CarGroupItem *carGroupItem in array) {
        NSMutableDictionary *dictCarGroupItem = [carGroupItem mj_keyValues];
        [dictCarGroupItems addObject:dictCarGroupItem];
    }
    // 写数据为 plist 文件
    BOOL flag = [dictCarGroupItems writeToFile:@"/Users/chendehao/Desktop/dictArrayCarGroups.plist" atomically:YES];
    NSLog(@"%d",flag);
    return dictCarGroupItems;
}



/**
 *  将数据进行重新分组
 *
 *  @param array 将要用来重新分组的数据(数组)
 */
- (NSMutableArray *)regroupItemWithArray:(NSMutableArray *)array{
    
    NSMutableArray *carGroupItems = [NSMutableArray array];
    
    // 取出数组 carBrandItems 中的数据进行分组
    for (CDH_CarBrandItem *carBrandItem in array) {
        
        // 创建一个汽车模型的
        CDH_CarItem *carItem = [[CDH_CarItem alloc] init];
        carItem.Name = carBrandItem.Name;
        carItem.Pbid = carBrandItem.Pbid;
        
        // 用一个标识符标识遍历到 carGroupItems 数组中是有已经有 Letter 属性这样的对象了,
        // 如果有直接追加数据, 如果没有则创建一个 CDH_CarGroupItem 对象并添加响应的数据
        BOOL flagLetter = NO;
        
        // 遍历找出 carGroupItems 数组中 CDH_CarGroupItem 模型里的 Letter 的值比较
        for (CDH_CarGroupItem *carGroupItem in carGroupItems) {
            // 比较是字符串是否相等,
            // 比较如果相等, 则直接在该对象的数组属性 cars 中添加一个 CDH_CarItem 对象,并且 break 掉遍历
            // 比较如果不相等, 则直接添加一个 CDH_CarGroupItem 类型的对象到 carGroupItems 中
            if ([carGroupItem.Letter isEqualToString:carBrandItem.Letter]) {
                flagLetter = YES; // 已经遍历到相应的数据
                [carGroupItem.cars addObject:carItem]; // 添加到数据模型中
                break; // 退出遍历
            }
        }
        // 没有遍历到对应的数据这要追加
        if (!flagLetter) {
            
            // 创建一个模型用来存储重新分组的 car 模型
            CDH_CarGroupItem *carGroupItem = [[CDH_CarGroupItem alloc] init];
            carGroupItem.Letter = carBrandItem.Letter;
            [carGroupItem.cars addObject:carItem];
            
            // 并将该模型添加到数组中
            [carGroupItems addObject:carGroupItem];
        }
    }
    return carGroupItems;
}

#pragma mark - tableViewSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _carGroupItems.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    CDH_CarGroupItem *carGroupItem = _carGroupItems[section];
    return carGroupItem.cars.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"carBrandCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    CDH_CarGroupItem *carGroupItem = _carGroupItems[indexPath.section];
    CDH_CarItem *carItem = carGroupItem.cars[indexPath.row];
    
    cell.textLabel.text = carItem.Name;
    cell.detailTextLabel.text = carItem.Pbid;
    
    return cell;
}

/**
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
 
 // 使用这个方法, 每组的头部一定要设置高度, 如果不设置是不显示出来的
 //    tableView.sectionHeaderHeight = 44;
 
 UILabel *lable = [[UILabel alloc] init];
 
 // 获取到组数
 CDH_CarGroupItem *carGroupItem = _carGroupItems[section];
 lable.text = carGroupItem.Letter;
 lable.backgroundColor = [UIColor greenColor];
 return lable;
 }
 */

// 设置每组头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    // 获取到组数
    CDH_CarGroupItem *carGroupItem = _carGroupItems[section];
    
    return carGroupItem.Letter;
}

@end
