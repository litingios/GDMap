//
//  CustomAnnotationVC.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/19.
//  Copyright © 2019 CX. All rights reserved.
//

#import "CustomAnnotationVC.h"
#import "CustomAnnotationView.h"
#import "SelectAnnotationView.h"

@interface CustomAnnotationVC ()<MAMapViewDelegate,AMapSearchDelegate>
@property(nonatomic,strong)NSMutableArray * backStateAnnotationArray; //大头针数组
/*** 地图 ****/
@property(nonatomic,strong) MAMapView *mapView;
/*** 比例尺 ****/
@property(nonatomic) MACoordinateSpan span;
/*** 高德地图区域 ****/
@property(nonatomic) MACoordinateRegion region;

@property(nonatomic,strong)NSMutableArray <MapModel *>* mapData; //经纬度数组
/*** <#注释内容#> ****/
@property(nonatomic,strong) SelectAnnotationView *selctView;

@end

@implementation CustomAnnotationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    
    /*** 创建地图 ****/
    [self creatMapView];
    [self creatData];
    [self creatInputView];
}

- (void)creatInputView{
    self.selctView = [[SelectAnnotationView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 500*HeightScale)];
    self.selctView.backgroundColor = [UIColor whiteColor];
    __weakSelf
    self.selctView.deleBlock = ^{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.selctView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 500*HeightScale);
        }];
    };
    [self.view addSubview:self.selctView];
}


- (void)creatMapView{
    [AMapServices sharedServices].apiKey = GDAppKey;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mapView.delegate = self;
    //显示用户位置
    _mapView.showsUserLocation = YES;
    [_mapView showAnnotations:_backStateAnnotationArray animated:YES];
    //设置定位精度
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    [self.view addSubview:_mapView];
    _span = MACoordinateSpanMake(55, 55);
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude-10, _mapView.centerCoordinate.longitude-10);
    _region = MACoordinateRegionMake(coordinate, _span);
    _mapView.region = _region;
}

- (void)creatData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Annotation" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    self.mapData = [NSMutableArray arrayWithArray:[MapModel mj_objectArrayWithKeyValuesArray:arr]];

    for (MapModel *model in self.mapData) {
        NSLog(@"%@",model.name);
    }
    
    //先清空显示的大头针
    [self.mapView removeAnnotations:self.backStateAnnotationArray];
    self.backStateAnnotationArray = [NSMutableArray array];
    
    //把大头针的坐标加入到数组中
    for (int i = 0; i < 10; i++) {
        MapModel * model = self.mapData[i];
        CLLocationCoordinate2D cooridinate = CLLocationCoordinate2DMake(model.lat, model.lng);
        MAPointAnnotation *pointAnnotation = [MAPointAnnotation new];
        pointAnnotation.coordinate = cooridinate;
        /*** 给大头针标记唯一ID ****/
        pointAnnotation.title = [NSString stringWithFormat:@"%d",i];
        [self.backStateAnnotationArray addObject:pointAnnotation];
        [self.mapView addAnnotation:pointAnnotation];
    }
    
    [self.mapView showAnnotations:self.backStateAnnotationArray edgePadding:UIEdgeInsetsMake(40, 40, 40, 40) animated:YES];
}

//#pragma mark ------ 自定制大头针样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"annotationReuseIndetifier";
        CustomAnnotationView*annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        
        MapModel * model = self.mapData[[annotation.title intValue]];
        annotationView.model = model;
        [annotationView setSelected:YES];
        annotationView.imageView.image = Image(@"red_point");
        annotationView.imageView.contentMode = UIViewContentModeCenter;
        annotationView.canShowCallout = NO;
        annotationView.centerOffset = CGPointMake(0, -18);
        __weakSelf
        annotationView.btnCiledblock = ^(MapModel * _Nonnull model) {
            self.selctView.model = model;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.selctView.frame = CGRectMake(0, kScreenHeight-500*HeightScale-64, kScreenWidth, 500*HeightScale);
            }];
        };
        return annotationView;
    }
    return nil;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}

@end
