//
//  LevelAnnotationVC.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/18.
//  Copyright © 2019 CX. All rights reserved.
//

#import "LevelAnnotationVC.h"
#import "SelectAnnotationView.h"

@interface LevelAnnotationVC ()<MAMapViewDelegate,AMapSearchDelegate>
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

@implementation LevelAnnotationVC

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
        /*** 将大头针状态修改成未选中 ****/
        [weakSelf.mapView removeAnnotations:weakSelf.backStateAnnotationArray];
        [weakSelf.mapView addAnnotations:weakSelf.backStateAnnotationArray];
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
    for (int i = 0; i <self.mapData.count; i++) {
        MapModel * model = self.mapData[i];
        CLLocationCoordinate2D cooridinate = CLLocationCoordinate2DMake(model.lat, model.lng);
        MAPointAnnotation *pointAnnotation = [MAPointAnnotation new];
        pointAnnotation.coordinate = cooridinate;
        /*** 给大头针标记唯一ID ****/
        pointAnnotation.title = [NSString stringWithFormat:@"%d",i];
        [self.backStateAnnotationArray addObject:pointAnnotation];
        [self.mapView addAnnotation:pointAnnotation];
    }
    
}

//#pragma mark ------ 自定制大头针样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
         
        MapModel * model = self.mapData[[annotation.title intValue]];
        if ([model.is_discount intValue] == 1) {
            //显示视图最上级  zIndex 数字越大在最上面
            annotationView.zIndex = 4;
            annotationView.imageView.image = Image(@"map_youhui_point");
        }else if ([model.channel intValue] == 3 || [model.channel intValue] == 4){
            annotationView.zIndex = 3;
            annotationView.imageView.image = Image(@"level_2");
        }else{
            if ([model.station_type intValue] == 1) {
                annotationView.zIndex = 2;
                annotationView.imageView.image = Image(@"red_point");
            }else{
                annotationView.zIndex = 1;
                annotationView.imageView.image = Image(@"xianlu_rim");
            }
        }
        annotationView.imageView.contentMode = UIViewContentModeCenter;
        return annotationView;
        
    }
    return nil;
}


/*** 点击某一个大头针 ****/
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    view.imageView.image = Image(@"select_point_dian");
    view.imageView.contentMode = UIViewContentModeCenter;

    MapModel *model = self.mapData[[view.annotation.title intValue]];
    /*** 选中点在中间 ****/
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude = [model lat];
    myCoordinate.longitude = [model lng];
    _span = MACoordinateSpanMake(2, 2);
    _region = MACoordinateRegionMake(_mapView.centerCoordinate, _span);
    _mapView.region = _region;
    _mapView.centerCoordinate=myCoordinate;
    
    model.zIndex = view.zIndex;
    self.selctView.model = model;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.selctView.frame = CGRectMake(0, kScreenHeight-500*HeightScale-64, kScreenWidth, 500*HeightScale);
    }];
}

#pragma mark -------- 取消选中一个大头针执行的方法
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
    MapModel * model = self.mapData[[view.annotation.title intValue]];
    if ([model.is_discount intValue] == 1) {
        //显示视图最上级  zIndex 数字越大在最上面
        view.zIndex = 4;
        view.imageView.image = Image(@"map_youhui_point");
    }else if ([model.channel intValue] == 3 || [model.channel intValue] == 4){
        view.zIndex = 3;
        view.imageView.image = Image(@"level_2");
    }else{
        if ([model.station_type intValue] == 1) {
            view.zIndex = 2;
            view.imageView.image = Image(@"red_point");
        }else{
            view.zIndex = 1;
            view.imageView.image = Image(@"xianlu_rim");
        }
    }
    
    view.imageView.contentMode = UIViewContentModeCenter;
    [UIView animateWithDuration:0.3 animations:^{
        self.selctView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 500*HeightScale);
    }];
}


- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}


@end
