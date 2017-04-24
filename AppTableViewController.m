//
//  AppTableViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/24.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "AppTableViewController.h"
#import "AppData.h"

@interface AppTableViewController ()
@property (nonatomic,strong) NSArray *appAr;
@end

@implementation AppTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (NSArray *)appAr
{
    if (_appAr == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"App.plist" ofType:nil];
        NSArray *tempArr = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in tempArr) {
            AppData *app = [AppData appModelWithDict:dict];
            [array addObject:app];
        }
        _appAr = array;
    }
    return _appAr;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.appAr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    
    AppData *app = self.appAr[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.downLoad;
    
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    NSURL *url = [NSURL URLWithString:app.icon];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
    
    NSLog(@"完成显示");
    return cell;
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
