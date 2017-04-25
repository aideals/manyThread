//
//  AppTableViewController.m
//  manyThread
//
//  Created by 鹏 刘 on 2017/4/24.
//  Copyright © 2017年 鹏 刘. All rights reserved.
//

#import "AppTableViewController.h"
#import "AppData.h"
#import "DownLoadOperation.h"

@interface AppTableViewController () <DownLoadOperationDelegate>
@property (nonatomic,strong) NSArray *appAr;
@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *operations;
@property (nonatomic,strong) NSMutableDictionary *images;
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

- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}

- (NSMutableDictionary *)operations
{
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (NSMutableDictionary *)images
{
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
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
    
    static NSString *reuseID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    
    AppData *app = self.appAr[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.downLoad;
    
   // NSLog(@"当前线程:%@",[NSThread currentThread]);
   // NSURL *url = [NSURL URLWithString:app.icon];
   // NSData *imageData = [NSData dataWithContentsOfURL:url];
   // UIImage *image = [UIImage imageWithData:imageData];
   // cell.imageView.image = image;
    
   // DownLoadOperation *operation = [[DownLoadOperation alloc] init];
   // operation.url = app.icon;
   // operation.indexPath = indexPath;
   // operation.delegate = self;
    
    UIImage *image = self.images[app.icon];
    
    if (image) {
        cell.imageView.image = image;
    } else {
        cell.imageView.image = [UIImage imageNamed:@"007"];
        DownLoadOperation *operation = self.operations[app.icon];
        if (operation) {
            
        }else {
            operation = [[DownLoadOperation alloc] init];
            operation.url = app.icon;
            operation.indexPath = indexPath;
            operation.delegate = self;
            [self.queue addOperation:operation];
            //self.operations[app.icon] = operation;
        }
    }
   
    
    
    //NSLog(@"完成显示");
    return cell;
}

- (void)downLoadOperation:(DownLoadOperation *)operation didFinishedDownload:(UIImage *)image
{
   // UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:operation.indexPath];
   // cell.imageView.image = image;
    
   // [self.tableView reloadData];
    
   // NSLog(@"---%@---",[NSThread currentThread]);

    [self.operations removeObjectForKey:operation.url];
    self.images[operation.url] = image;

    [self.tableView reloadRowsAtIndexPaths:@[operation.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"--%ld--%@--",(long)operation.indexPath.row,[NSThread currentThread]);
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
