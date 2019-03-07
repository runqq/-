//
//  First.m
//  离线下载
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 WO. All rights reserved.
//

#import "DownLoadCell.h"
#import "Second.h"
#import "First.h"
#import "AppDelegate.h"
@interface First ()<UITableViewDataSource, UITableViewDelegate, QSPDownloadToolDelegate>
@property(nonatomic,strong)NSURLSession *session;

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation First
- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray arrayWithArray:[QSPDownloadTool shareInstance].downloadSources];
    }
    
    return _dataArr;
}
- (void)dealloc
{
    [[QSPDownloadTool shareInstance] removeDownloadToolDelegate:self];//销毁
}
-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *app =(AppDelegate *) [UIApplication sharedApplication].delegate;

        if (app.i==1) {
            [self  addDownLoadData];//执行下载方法
            app.i = 0;
            return;
            }
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
    
    [[QSPDownloadTool shareInstance] addDownloadToolDelegate:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ADASD";

    [self.tableView reloadData];
   

}

- (void)addDownLoadData
{
    NSLog(@"===输出");
    AppDelegate *app =(AppDelegate *) [UIApplication sharedApplication].delegate;

    [self.dataArr addObject:[[QSPDownloadTool shareInstance] addDownloadTast:app.mp4Url andOffLine:YES]];

    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:NO];
    
}
-(void)reloadTable
{
    [self.tableView  reloadData];
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
    DownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[DownLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
      AppDelegate *app =(AppDelegate *) [UIApplication sharedApplication].delegate;

//    cell.imageView.image =[UIImage  imageWithData:[NSData  dataWithContentsOfURL:[NSURL  URLWithString:app.mp4image]]] ;
 
    cell.source = self.dataArr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DownLoadCell_Height;
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
    }
}

#pragma mark - <QSPDownloadToolDelegate>代理方法
- (void)downloadToolDidFinish:(QSPDownloadTool *)tool downloadSource:(QSPDownloadSource *)source
{
    for (int index = 0; index < self.dataArr.count; index++) {
        QSPDownloadSource *currentSource = self.dataArr[index];
        if (currentSource.task == source.task) {
            [self.dataArr removeObject:currentSource];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
        }
    }
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:QSPDownloadTool_DownloadFinishedSources_Path];
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:arr];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:source];
    [mArr addObject:data];
    
    [mArr writeToFile:QSPDownloadTool_DownloadFinishedSources_Path atomically:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
