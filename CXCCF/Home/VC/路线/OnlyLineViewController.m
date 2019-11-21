//
//  OnlyLineViewController.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/20.
//  Copyright © 2019 CX. All rights reserved.
//

#import "OnlyLineViewController.h"

@interface OnlyLineViewController ()<MAMapViewDelegate,AMapSearchDelegate>
/*** 地图 ****/
@property(nonatomic,strong) MAMapView *mapView;
/*** 比例尺 ****/
@property(nonatomic) MACoordinateSpan span;
/*** 高德地图区域 ****/
@property(nonatomic) MACoordinateRegion region;
/*** 线的数组 ****/
@property(nonatomic,strong) NSMutableArray *polylineArr;

@end

@implementation OnlyLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;

    [self creatMapView];
    [self creatData];
}

- (void)creatMapView{
    [AMapServices sharedServices].apiKey = GDAppKey;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mapView.delegate = self;
    //显示用户位置
    _mapView.showsUserLocation = YES;
    //设置定位精度
    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    [self.view addSubview:_mapView];
    _span = MACoordinateSpanMake(55, 55);
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(_mapView.centerCoordinate.latitude-10, _mapView.centerCoordinate.longitude-10);
    _region = MACoordinateRegionMake(coordinate, _span);
    _mapView.region = _region;
}

- (void)creatData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"showBuilding" ofType:@"plist"];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:path];

    [self.mapView removeOverlays:self.polylineArr];
    self.polylineArr = [NSMutableArray array];
    
    NSMutableArray * lineDataArray = [NSMutableArray arrayWithArray:data[@"result"][@"line"]];
    NSString *str = lineDataArray[0][@"polyline"];
    NSArray *array = [str componentsSeparatedByString:@";"];

    //构造折线数据对象
    CLLocationCoordinate2D commonPolylineCoords[array.count];
    for (int i = 0; i < array.count; i++) {
        NSString *str = array[i];
        NSArray *arr = [str componentsSeparatedByString:@","];
        commonPolylineCoords[i].latitude = [arr[1] floatValue];
        commonPolylineCoords[i].longitude = [arr[0] floatValue];
    }
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:array.count];
    [self.polylineArr addObject:commonPolyline];
    
    /*** 将线添加到地图上 ****/
    [_mapView addOverlays:self.polylineArr];
    /*** 这行代码就是确保线可以在地图上完全展示  UIEdgeInsetsMake(60, 40, 80, 40)  上左下右 ****/
    [_mapView showOverlays:self.polylineArr edgePadding:UIEdgeInsetsMake(60, 40, 80, 40) animated:YES];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]]){
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.lineWidth    = 15*WidthScale;
        [polylineRenderer setStrokeImage:Image(@"map_line_select")];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        return polylineRenderer;
    }
    return nil;
}

@end
