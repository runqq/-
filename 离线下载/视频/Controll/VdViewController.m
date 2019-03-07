//
//  VdViewController.m
//  ku耳
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 WO. All rights reserved.
//

#import "VdViewController.h"
#import "VOCollectionViewCell.h"
#import "Model.h"
#import "videodetailViewController.h"

@interface VdViewController ()<UICollectionViewDelegate , UICollectionViewDataSource>
{
    UICollectionView *clV;
    UIView  *view;
    UIImageView *imgI;
    UIButton *btn;
}
@property(nonatomic,assign)int i;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *datalabel;
@property(nonatomic,strong)NSMutableArray *dataimage;
@property(nonatomic,strong)NSMutableArray *datavoice;
@property(nonatomic,copy)NSString *fileDescribe;
@end

@implementation VdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.i=1;//让打开视图为1
    //初始化数据源
    self.dataSource=[[NSMutableArray alloc]init];
    self.datalabel=[[NSMutableArray alloc]init];
    self.datavoice=[[NSMutableArray alloc]init];
    self.dataimage=[[NSMutableArray alloc]init];

self.navigationController.navigationBar.barTintColor=RGB(120, 90, 184, 0.85);
    //导航背景色
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    /*滚动方向*/ layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //格子的大小
    layout.itemSize = CGSizeMake(WIDTH/2-20, 200);
    //行间距
    layout.minimumLineSpacing = 5;
    //列间距
    layout.minimumInteritemSpacing = 10;
    
    //网格视图 (表格 -> 需要注册,需要创建布局)
    //1.frame
    clV = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    clV.backgroundColor=[UIColor whiteColor];
    //2.数据源和代理
    clV.delegate = self;
    clV.dataSource = self;
    // 注册 cell
    [clV registerClass:[VOCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self loadData];
    //3.添加到主视图


    [self.view addSubview:clV];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"➕" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
       NSLog(@"asdasdasdad:一样么=========a========a================aa");
}
-(void)loadData
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:@"http://123.126.40.109:7003/asmr/videos/A1100101.shtml" parameters:self progress:^(NSProgress * _Nonnull downloadProgress) {

        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:1 error:nil];
          //整个的大数组加到字典里然后再给resultarr数组
        NSArray *resultarr=dict[@"result"];
       
        for (NSDictionary *dic in  resultarr) {
            Model *model=[Model new];
            //把字典给数组
            [self.dataimage addObject:dic[@"imageUrl"]];//这两个是一组
            [self.datalabel addObject:dic[@"fileDescribe"]];//
// [self.datalabel addObject:dic[@"fileUrl"]];
            
            
            [model setValuesForKeysWithDictionary:dic];
            [self.datavoice addObject:model];//3这两个是一种
            [self.dataSource addObject:model];//3
            
        }
       
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:NO];
        NSLog(@"网络请求 成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
-(void)reloadTable
{
    [clV  reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//分区单元格
-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VOCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.imagev sd_setImageWithURL:[NSURL URLWithString:self.dataimage[indexPath.row]] ];
    
    cell.labelI.text=self.datalabel[indexPath.row];
    

    return cell;
}
//点击单元格跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [clV deselectItemAtIndexPath:indexPath animated:NO];
    videodetailViewController *detail=[[videodetailViewController alloc]init];
    Model *model=self.datavoice[indexPath.row];//1

    detail.MP4url=model.fileUrl;//1
     detail.MP4image=model.imageUrl;//1
    [self.navigationController pushViewController:detail animated:YES];
   

}
-(void)click
{
    
    if (self.i==1) {
       view=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-170, 80, 150, 100)];
                view.backgroundColor=[UIColor blackColor];
         view.alpha=0.78;
        
        
        for (int j=0; j<2; j++) {
        imgI=[[UIImageView alloc]initWithFrame:CGRectMake(13,20+j*40, 30, 30)];
            NSArray *arr = @[@"我的视频",@"我的音频"];
            NSArray *arr1 = @[@"上传视频1",@"上传音频1"];
            imgI.image = [UIImage imageNamed:arr[j]];
        [view addSubview:imgI];
            
        btn=[[UIButton alloc]initWithFrame:CGRectMake(25, j*40+20, 150, 30)];
            
            [btn setTitle:arr1[j] forState:UIControlStateNormal];
            [view addSubview:btn];
            // btn.tag=i+1; tag唯一性 不等于1
            //
        }
        
        [self.view addSubview:view];
        self.i=0;//运行到这里停止
    }else
    {
        
        view.frame=CGRectMake(0, 0, 0, 0);
        imgI.frame=CGRectMake(0, 0, 0, 0);
        btn.frame=CGRectMake(0, 0, 0, 0);
        self.i=1;
    }
}
@end
