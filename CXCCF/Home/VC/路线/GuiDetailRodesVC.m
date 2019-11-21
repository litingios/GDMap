//
//  GuiDetailRodesVC.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/20.
//  Copyright © 2019 CX. All rights reserved.
//

#import "GuiDetailRodesVC.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "SpeechSynthesizer.h"

@interface GuiDetailRodesVC ()<MAMapViewDelegate,AMapSearchDelegate,RouteQueryDelegate,AMapNaviDriveViewDelegate,AMapNaviDriveManagerDelegate>
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

/*** 搜索对象 ****/
@property(nonatomic,strong) AMapSearchAPI *search;
/*** 导航 ****/
@property(nonatomic,strong) AMapNaviDriveView *driveView;


@end

@implementation GuiDetailRodesVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"路线规划导航";
    
    self.lineIndex = 0;

    [self creatMapView];
    [self creatBtnView];

    [self creatData];
    
    UIButton *btn =[LTControl createButtonWithFrame:CGRectMake(kScreenWidth-100*WidthScale, kScreenHeight-500*HeightScale, 100*WidthScale, 100*HeightScale) ImageName:nil Target:self Action:@selector(daoHnag) Title:@"导航"];
    btn.backgroundColor = MainColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)daoHnag{
    [self initDriveView];
    [self initDriveManager];
}

#pragma mark ------  导航  ------
- (void)initDriveView
{
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        self.driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.driveView setDelegate:self];
        
        [self.view addSubview:self.driveView];
    }
    self.driveView.lt_y = 0;
}

- (void)initDriveManager
{
    [[AMapNaviDriveManager sharedInstance] setDelegate:self];
    //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
    [[AMapNaviDriveManager sharedInstance] addDataRepresentative:self.driveView];
    
    [[AMapNaviDriveManager sharedInstance] calculateDriveRouteWithStartPoints:@[[AMapNaviPoint locationWithLatitude:self.inputArr[0].latitude longitude:self.inputArr[0].longitude]]
          endPoints:@[[AMapNaviPoint locationWithLatitude:self.inputArr[self.inputArr.count-1].latitude longitude:self.inputArr[self.inputArr.count-1].longitude]]
          wayPoints:nil drivingStrategy:17];
    
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    //显示路径或开启导航
    //算路成功后开始GPS导航
    [[AMapNaviDriveManager sharedInstance] startGPSNavi];

}

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager{
    return [[SpeechSynthesizer sharedSpeechSynthesizer] isSpeaking];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

#pragma mark ------  退出按钮点击事件  ------
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView{
    [UIView animateWithDuration:0.3 animations:^{
        self.driveView.lt_y = kScreenHeight;
    }];
    
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    [[SpeechSynthesizer sharedSpeechSynthesizer]stopSpeak];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
}

- (void)dealloc
{
    [[AMapNaviDriveManager sharedInstance] stopNavi];
    [[AMapNaviDriveManager sharedInstance] removeDataRepresentative:self.driveView];
    [[AMapNaviDriveManager sharedInstance] setDelegate:nil];
    [[SpeechSynthesizer sharedSpeechSynthesizer]stopSpeak];
    
    BOOL success = [AMapNaviDriveManager destroyInstance];
    NSLog(@"单例是否销毁成功 : %d",success);
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
    self.btnView = [[RouteQueryBtnView alloc]initWithFrame:CGRectMake(0, kScreenHeight-64-150*HeightScale,kScreenWidth,150*HeightScale)];
    self.btnView.delegate = self;
    self.btnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.btnView];
}

- (void)creatData{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    /*** 点数据 ****/
    NSMutableArray <NSDictionary *>*annArr = [NSMutableArray array];
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    navi.requireExtension = YES;
    navi.strategy = 19;
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.inputArr[0].latitude longitude:self.inputArr[0].longitude];
    [annArr addObject:@{@"lat":[NSString stringWithFormat:@"%f",self.inputArr[0].latitude],@"lng":[NSString stringWithFormat:@"%f",self.inputArr[0].longitude]}];
    
    /*** 途经点 ****/
    if (self.inputArr.count > 2) {
        NSMutableArray <AMapGeoPoint *>*array = [NSMutableArray array];
        for (int i = 0; i < self.inputArr.count; i ++) {
            if (i != 0 && i != self.inputArr.count - 1) {
                [array addObject:[AMapGeoPoint locationWithLatitude:self.inputArr[i].latitude longitude:self.inputArr[i].longitude]];
                [annArr addObject:@{@"lat":[NSString stringWithFormat:@"%f",self.inputArr[i].latitude],@"lng":[NSString stringWithFormat:@"%f",self.inputArr[i].longitude]}];
            }
        }
        navi.waypoints = array;
        NSLog(@"----&&&&& %ld",array.count);
    }
    
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.inputArr[1].latitude longitude:self.inputArr[self.inputArr.count-1].longitude];
    [annArr addObject:@{@"lat":[NSString stringWithFormat:@"%f",self.inputArr[self.inputArr.count-1].latitude],@"lng":[NSString stringWithFormat:@"%f",self.inputArr[self.inputArr.count-1].longitude]}];
    
    //发起驾车路线规划
    [self.search AMapDrivingRouteSearch:navi];
    
    self.pointsArray = [NSMutableArray arrayWithArray:[MapModel mj_objectArrayWithKeyValuesArray:annArr]];
    [self showPointView];
}


/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    
    NSMutableArray *chuLineArray = [NSMutableArray array];
    for (AMapPath *model  in response.route.paths) {
        NSMutableString *linStr = [NSMutableString string];
        for (AMapStep *steMdoel in model.steps) {
            [linStr appendString:steMdoel.polyline];
        }
        [chuLineArray addObject:@{@"polyline":linStr,@"distance":[NSString stringWithFormat:@"%ld",model.distance],@"tolls":[NSString stringWithFormat:@"%.2f",model.tolls],@"duration":[NSString stringWithFormat:@"%ld",model.duration],@"strategy":model.strategy}];
    }
    self.lineArray = [NSMutableArray arrayWithArray:chuLineArray];
    [self settingLineWithIndexPath];
    
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error:======= %@", error);
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
    [self.btnView creatBtnData:self.lineArray andIndexPath:_lineIndex andType:2];
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
         
        if ([annotation.title intValue] == 0) {
            annotationView.imageView.image = Image(@"text_qi");
        }else if ([annotation.title intValue] == self.inputArr.count-1){
            annotationView.imageView.image = Image(@"text_zhong");
        }else{
            annotationView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"tujing_point_%d",[annotation.title intValue]]];
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


- (void)setInputArr:(NSMutableArray<DiZhiModel *> *)inputArr{
    _inputArr = inputArr;
    
}
@end
