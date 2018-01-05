//
//  LLQTableViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/4/12.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQSelfCellController.h"
#import "LLQTgCell.h"
#import "LLQTestCell.h"

#import "LLQTopCell.h"
@interface LLQSelfCellController ()

@end

@implementation LLQSelfCellController
static NSString *ID = @"Cell";
static NSString *testID = @"testCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[LLQTgCell class] forCellReuseIdentifier:ID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LLQTestCell" bundle:nil] forCellReuseIdentifier:testID];
    [self.tableView registerNib:[UINib nibWithNibName:@"LLQTopCell" bundle:nil] forCellReuseIdentifier:@"topCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    LLQTgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (indexPath.row % 2 == 0) {
        LLQTgCell * cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.row % 3 == 1) {
        LLQTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
        return cell;
    }
    else{
        LLQTestCell *cell = [tableView dequeueReusableCellWithIdentifier:testID];
        return cell;
    }
    
//    if (cell == nil) {
//        cell = [[LLQTgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
//    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *contentStr = @"weriornsgoweriornsgoweriornsgoweriornsgo";
    CGFloat cellHeight = 0;
    cellHeight += 55;
    CGSize size = CGSizeMake(100, MAXFLOAT);
    cellHeight += [contentStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height ;
    
    return cellHeight;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
