//
//  Second.m
//  离线下载
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 WO. All rights reserved.
//

#import "First.h"
#import "Second.h"
#import "DownLoadCell.h"
#import <MediaPlayer/MediaPlayer.h>
@interface Second ()<UITableViewDataSource, UITableViewDelegate, QSPDownloadToolDelegate>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation Second

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithCapacity:1];
        NSArray *arr = [NSArray arrayWithContentsOfFile:QSPDownloadTool_DownloadFinishedSources_Path];
        
        for (NSData *data in arr) {
            QSPDownloadSource *source = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [_dataArr addObject:source];
        }
    }
    
    return _dataArr;
}

- (void)dealloc
{
    NSLog(@"%@ 销毁啦！", NSStringFromClass([self class]));
    [[QSPDownloadTool shareInstance] removeDownloadToolDelegate:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    
    [[QSPDownloadTool shareInstance] addDownloadToolDelegate:self];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DownLoadCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    QSPDownloadSource *source = self.dataArr[indexPath.row];
//    DownLoadCell  *downLoad = [DownLoadCell new];
    cell.textLabel.text = source.fileName;
    cell.detailTextLabel.text = [QSPDownloadTool calculationDataWithBytes:source.totalBytesExpectedToWrite];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QSPDownloadSource *source = self.dataArr[indexPath.row];
    NSLog(@"%@", source.location);
    MPMoviePlayerViewController *ctr = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:source.location]];
    [self presentViewController:ctr animated:YES completion:nil];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[QSPDownloadTool shareInstance] stopDownload:self.dataArr[indexPath.row]];
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
        for (QSPDownloadSource *source in self.dataArr) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:source];
            [mArr addObject:data];
        }
        [mArr writeToFile:QSPDownloadTool_DownloadFinishedSources_Path atomically:YES];
    }
}

#pragma mark - <QSPDownloadToolDelegate>代理方法
- (void)downloadToolDidFinish:(QSPDownloadTool *)tool downloadSource:(QSPDownloadSource *)source
{
    [self.dataArr addObject:source];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
}

@end

