//
//  LinsAndPiintsVC.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/20.
//  Copyright © 2019 CX. All rights reserved.
//

#import "LinsAndPiintsVC.h"

@interface LinsAndPiintsVC ()<MAMapViewDelegate,AMapSearchDelegate,RouteQueryDelegate>
/*** 地图 ****/
@property(nonatomic,strong) MAMapView *mapView;
/*** 比例尺 ****/
@property(nonatomic) MACoordinateSpan span;
/*** 高德地图区域 ****/
@property(nonatomic) MACoordinateRegion region;
/*** 线的数组 ****/
@property(nonatomic,strong) NSMutableArray *polylineArr;
/*** 线数据的数组 ****/
@property(nonatomic,strong) NSMutableArray *lineArray;
/*** 方案距离数组 ****/
@property(nonatomic,strong) NSMutableArray *distanceArr;
/*** 按钮view ****/
@property(nonatomic,strong) RouteQueryBtnView *btnView;
/*** 选中的地图线 ****/
@property(nonatomic,assign)NSInteger lineIndex;
/*** 方案标记 ****/
@property(nonatomic,assign) NSUInteger count;
/*** 大头针数组 ****/
@property(nonatomic,strong)NSMutableArray * backStateAnnotationArray;
/*** 点数组 ****/
@property(nonatomic,strong) NSMutableArray <MapModel *>*pointsArray;

@end

@implementation LinsAndPiintsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;

    self.lineIndex = 0;

    [self creatMapView];
    [self creatBtnView];

    [self creatData];
}

- (void)creatMapView{
    [AMapServices sharedServices].apiKey = GDAppKey;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-120*HeightScale)];
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

- (void)creatBtnView{
    self.btnView = [[RouteQueryBtnView alloc]initWithFrame:CGRectMake(0, kScreenHeight-64-120*HeightScale,kScreenWidth,120*HeightScale)];
    self.btnView.delegate = self;
    self.btnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btnView];
}

- (void)creatData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"showBuilding" ofType:@"plist"];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:path];
    self.lineArray = [NSMutableArray arrayWithArray:data[@"result"][@"line"]];
    self.pointsArray = [NSMutableArray arrayWithArray:[MapModel mj_objectArrayWithKeyValuesArray:data[@"result"][@"points"]]];
    [self settingLineWithIndexPath];
    [self showPointView];
}

#pragma mark ------  打点  ------
- (void)showPointView{
    [self.mapView removeAnnotations:self.backStateAnnotationArray];
    self.backStateAnnotationArray = [NSMutableArray array];
    //把大头针的坐标加入到数组中
    for (int i = 0; i <self.pointsArray.count; i++) {
        MapModel * model = self.pointsArray[i];
        CLLocationCoordinate2D cooridinate = CLLocationCoordinate2DMake(model.lat, model.lng);
        MAPointAnnotation *pointAnnotation = [MAPointAnnotation new];
        pointAnnotation.coordinate = cooridinate;
        /*** 给大头针标记唯一ID ****/
        pointAnnotation.title = [NSString stringWithFormat:@"%d",i];
        [self.backStateAnnotationArray addObject:pointAnnotation];
    }
    [self.mapView addAnnotations:self.backStateAnnotationArray];
}


#pragma mark ------  画线  ------
- (void)settingLineWithIndexPath{
    //先清除掉线，再重新绘制，高德地图是有缓存的，视觉上体验上都没有问题
    [self.mapView removeOverlays:self.polylineArr];
    self.distanceArr = [NSMutableArray array];
    self.polylineArr = [NSMutableArray array];

    /*** 绘制多条线和绘制单条线比就加了个循环  很简单！ ****/
    for (int j = 0; j < self.lineArray.count;j ++) {
        NSString *str = self.lineArray[j][@"polyline"];
        [self.distanceArr addObject:self.lineArray[j][@"distance"]];
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
        /*** 添加唯一标示 ****/
        commonPolyline.title = [NSString stringWithFormat:@"%d",j+1];
        [self.polylineArr addObject:commonPolyline];
    }
    
    /***
        [_mapView addOverlays:self.polylineArr];这个方法是将全部的线不分层级的添加到地图上面
        [_mapView insertOverlay:self.polylineArr[2] atIndex:-0.1 level:-0.1];这个方法是将全部的线分层级的添加到地图上面
        _lineIndex 代表按钮选中是的那条线，选中哪条线就将哪条线insertOverlay 到地图的最上面，把下面的线盖住，不然会出现线被覆盖的bug（有兴趣的可以自己试试看）
        atIndex:-0.1 level:-0.1 是什么意思？
        地图上的默认控件 atIndex 和 level  等于 0 ，我现在的需求是自己b画的线不要盖住地图上的高速名称所以就atIndex:-0.1 level:-0.1 (感兴趣的话可以自己试试，我也是一点一点自己试出来的)
     ****/
    if (self.polylineArr.count == 0){
        return;
    }
    if (_lineIndex >= self.polylineArr.count) {
        _lineIndex = self.polylineArr.count-1;
    }
    [_mapView insertOverlay:self.polylineArr[_lineIndex] atIndex:0 level:0];
    
    if (_lineIndex == 0) {
        if (_lineIndex+1 <= self.polylineArr.count-1) {
            [_mapView insertOverlay:self.polylineArr[1] atIndex:-0.1 level:-0.1];
        }
        if (_lineIndex+2 <= self.polylineArr.count-1) {
            [_mapView insertOverlay:self.polylineArr[2] atIndex:-0.1 level:-0.1];
        }
    }else if (_lineIndex == 1){
        [_mapView insertOverlay:self.polylineArr[0] atIndex:-0.1 level:-0.1];
        if (_lineIndex+1 <= self.polylineArr.count-1) {
            [_mapView insertOverlay:self.polylineArr[2] atIndex:-0.1 level:-0.1];
        }
    }else if (_lineIndex == 2){
        [_mapView insertOverlay:self.polylineArr[0] atIndex:-0.1 level:-0.1];
        [_mapView insertOverlay:self.polylineArr[1] atIndex:-0.1 level:-0.1];
    }
    
    /*** 这行代码就是确保线可以在地图上完全展示  UIEdgeInsetsMake(60, 40, 80, 40)  上左下右 ****/
    [_mapView showOverlays:self.polylineArr edgePadding:UIEdgeInsetsMake(60, 40, 80, 40) animated:YES];
    [self.btnView creatBtnData:self.distanceArr andIndexPath:_lineIndex andType:1];
}

- (void)projectBtnCiledWithBtn:(UIButton *)btn{
    self.count = btn.tag;
    self.lineIndex = btn.tag-100;
    [self settingLineWithIndexPath];
}


- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]]){
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.lineWidth    = 15*WidthScale;
        if ([overlay.title intValue] == _lineIndex+1) {
            [polylineRenderer setStrokeImage:Image(@"map_line_select")];
        }else{
            [polylineRenderer setStrokeImage:Image(@"map_line_nonal")];
        }        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        return polylineRenderer;
    }
    return nil;
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
         
        MapModel * model = self.pointsArray[[annotation.title intValue]];
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
}

#pragma mark -------- 取消选中一个大头针执行的方法
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
    MapModel * model = self.pointsArray[[view.annotation.title intValue]];
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
}


@end
