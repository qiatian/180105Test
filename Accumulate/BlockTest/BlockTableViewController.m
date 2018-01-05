//
//  BlockTableViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/6/16.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "BlockTableViewController.h"
#import "CellItem.h"
@interface BlockTableViewController ()
@property(nonatomic,strong)NSArray *items;
@end

@implementation BlockTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    创建模型
    CellItem *item1 = [CellItem itemWithTitle:@"打电话"];
    item1.blockCell = ^{
        NSLog(@"打电话");
    };
    CellItem *item2 = [CellItem itemWithTitle:@"发短信"];
    item2.blockCell = ^{
        NSLog(@"发短信");
    };
    CellItem *item3 = [CellItem itemWithTitle:@"发邮件"];
    item3.blockCell = ^{
        NSLog(@"发邮件");
    };
    _items = @[item1,item2,item3];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CellItem *item = _items[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //把要做的事情（代码）保存到模型中
    CellItem *item = _items[indexPath.row];
    if (item.blockCell) {
        item.blockCell();
    }
}
@end
