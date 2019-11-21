//
//  CommonAnnotationVC.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/18.
//  Copyright © 2019 CX. All rights reserved.
//

#import "CommonAnnotationVC.h"

@interface CommonAnnotationVC ()<MAMapViewDelegate,AMapSearchDelegate>
@property(nonatomic,strong)NSMutableArray * backStateAnnotationArray; //大头针数组
/*** 地图 ****/
@property(nonatomic,strong) MAMapView *mapView;
/*** 比例尺 ****/
@property(nonatomic) MACoordinateSpan span;
/*** 高德地图区域 ****/
@property(nonatomic) MACoordinateRegion region;

@property(nonatomic,strong)NSMutableArray <MapModel *>* mapData; //经纬度数组

@end

@implementation CommonAnnotationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleStr;
    
    /*** 创建地图 ****/
    [self creatMapView];
    [self creatData];
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
    /*** 自动调整比例尺，使地图显示全部大头针 ****/
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
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
                    
        if ([self.mapData[[annotation.title intValue]].station_type intValue] == 1) {
            annotationView.imageView.image = Image(@"red_point");
        }else{
            annotationView.imageView.image = Image(@"xianlu_rim");
        }
        if ([self.mapData[[annotation.title intValue]].is_discount intValue] == 1) {
            annotationView.imageView.image = Image(@"map_youhui_point");
        }
        annotationView.imageView.contentMode = UIViewContentModeCenter;

        annotationView.canShowCallout = YES;
        UIView *callView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        UILabel *lable = [LTControl createLabelWithFrame:CGRectMake(0, 0, 60, 40) Font:12 Text:self.mapData[[annotation.title intValue]].name];
        lable.numberOfLines = 0;
        [callView addSubview:lable];
        annotationView.leftCalloutAccessoryView = callView;
        
        UIView *callView02 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        UILabel *lable02 = [LTControl createLabelWithFrame:CGRectMake(0, 0, 60, 40) Font:12 Text:@"我是customCalloutView,此弹出框不会触发-(void)mapView: didAnnotationViewCalloutTapped: since 5.0.0"];
        lable02.numberOfLines = 0;
        [callView02 addSubview:lable02];
        annotationView.rightCalloutAccessoryView = callView02;
        return annotationView;
    }
    return nil;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}

@end
