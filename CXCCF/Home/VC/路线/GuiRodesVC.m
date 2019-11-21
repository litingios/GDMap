//
//  GuiRodesVC.m
//  CXCCF
//
//  Created by 李霆 on 2019/11/20.
//  Copyright © 2019 CX. All rights reserved.
//

#import "GuiRodesVC.h"
#import "TextFiledCell.h"
#import "DiZhiCell.h"
#import "GuiDetailRodesVC.h"

@interface GuiRodesVC ()<UITableViewDataSource,UITableViewDelegate,AMapSearchDelegate>
/*** 上面的tableView ****/
@property(nonatomic,strong) UITableView *topTableView;
/*** 头视图 ****/
@property(nonatomic,strong) UIView *headerView;
/*** 按钮父视图 ****/
@property(nonatomic,strong) UIView *btnFatnerView;
/*** 线 ****/
@property(nonatomic,strong) UILabel *rightLable;
/*** 搜索按钮 ****/
@property(nonatomic,strong) UIButton *searchBtn;
/*** topLine ****/
@property(nonatomic,strong) UILabel *topLine;
/*** topLine02 ****/
@property(nonatomic,strong) UILabel *topLine02;
@property(nonatomic,strong) NSMutableArray <DiZhiModel *>*inputArr;
/*** 搜索 ****/
@property(nonatomic) BOOL isSou;
/*** 是否点击了添加途经点 ****/
@property(nonatomic) BOOL isAddTu;
/*** 选中的textFiled ****/
@property(nonatomic,strong) UITextField *selectField;
/*** 标示哪个输入框响应，替换数组的那个位置model ****/
@property(nonatomic,assign) NSInteger whoIndex;
/*** 数组 ****/
@property(nonatomic,strong) NSMutableArray *searchData;
/*** 搜索对象 ****/
@property(nonatomic,strong) AMapSearchAPI *search;
/*** 展示view ****/
@property(nonatomic,strong) UIView *desView;


@end

#define searchTypes @"地名地址信息"

@implementation GuiRodesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ViewBackColor;
    
    [self creatDesView];

    self.title = self.titleStr;
    [self creatTopTableView];
    [self creatSearchView];
    [self creatTopData];

    /*** 地图关键字搜索 ****/
    [AMapServices sharedServices].apiKey = GDAppKey;
    /*** 初始化检索对象 ****/
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}

- (void)creatDesView{
    
    self.desView = [[UIView alloc]initWithFrame:CGRectMake(0, 160*HeightScale, kScreenWidth, kScreenHeight-116*HeightScale)];
    self.desView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.desView];
    
    UILabel *titleLab = [LTControl createLabelWithFrame:CGRectMake(0, 10*HeightScale, kScreenWidth, 30*HeightScale) Font:16 Text:@"驾车出行路线规划所需参数及其含义，可自行设置"];
    titleLab.textColor = BlackTextColor;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont boldSystemFontOfSize:16];
    [self.desView addSubview:titleLab];
    
    UILabel *desLab =[LTControl createLabelWithFrame:CGRectMake(30*WidthScale, titleLab.lt_bottom, kScreenWidth-60*HeightScale, self.desView.lt_height-40*HeightScale) Font:16 Text:@"origin：起点坐标，必设\ndestination：终点坐标，必设。\nwaypoints：途经点，最多支持16个途经点。\navoidpolygons：避让区域，最多支持100个避让区域，每个区域16个点。\navoidroad：避让道路，设置避让道路后，避让区域失效。\nstrategy：路径规划的策略，可选，默认为0-速度优先；\n 策略ID 策略描述 \n0 速度优先，不考虑当时路况，返回耗时最短的路线，但是此路线不一定距离最短 \n 1 费用优先，不走收费路段，且耗时最少的路线 \n 2 距离优先，不考虑路况，仅走距离最短的路线，但是可能存在穿越小路/小区的情况 \n 3 速度优先，不走快速路，例如京通快速路（因为策略迭代，建议使用13）\n 4 躲避拥堵，但是可能会存在绕路的情况，耗时可能较长 \n 5 多策略（同时使用速度优先、费用优先、距离优先三个策略计算路径）。其中必须说明，就算使用三个策略算路，会根据路况不固定的返回一到三条路径规划信息 \n 6 速度优先，不走高速，但是不排除走其余收费路段 \n 7费用优先，不走高速且避免所有收费路段 \n 7 费用优先，不走高速且避免所有收费路段 \n 8 躲避拥堵和收费，可能存在走高速的情况，并且考虑路况不走拥堵路线，但有可能存在绕路和时间较长 \n 9 躲避拥堵和收费，不走高速 \n 10 返回结果会躲避拥堵，路程较短，尽量缩短时间，与高德地图的默认策略（也就是不进行任何勾选）一致 \n 11 返回三个结果包含：时间最短；距离最短；躲避拥堵（由于有更优秀的算法，建议用10代替） \n 12 返回的结果考虑路况，尽量躲避拥堵而规划路径，与高德地图的“躲避拥堵”策略一致 \n 13 返回的结果不走高速，与高德地图“不走高速”策略一致 \n 14 返回的结果尽可能规划收费较低甚至免费的路径，与高德地图“避免收费”策略一致 \n 15 返回的结果考虑路况，尽量躲避拥堵而规划路径，并且不走高速，与高德地图的“躲避拥堵&不走高速”策略一致 \n 16 返回的结果尽量不走高速，并且尽量规划收费较低甚至免费的路径结果，与高德地图的“避免收费&不走高速”策略一致 \n 17 返回路径规划结果会尽量的躲避拥堵，并且规划收费较低甚至免费的路径结果，与高德地图的“躲避拥堵&避免收费”策略一致 \n 18 返回的结果尽量躲避拥堵，规划收费较低甚至免费的路径结果，并且尽量不走高速路，与高德地图的“避免拥堵&避免收费&不走高速”策略一致 \n 19 返回的结果会优先选择高速路，与高德地图的“高速优先”策略一致 \n 20 返回的结果会优先考虑高速路，并且会考虑路况躲避拥堵，与高德地图的“躲避拥堵&高速优先”策略一致"];
    desLab.textColor = BlackTextColor;
    desLab.font = FONT(14);
    [self.desView addSubview:desLab];
    self.desView.hidden = NO;
}

- (void)creatTopData{
    DiZhiModel *model01 = [[DiZhiModel alloc]init];
    model01.name = @"我的位置";
    model01.address = NowAddress;
    model01.latitude = NowLatitude;
    model01.longitude = NowLongitude;
    
    DiZhiModel *model02 = [[DiZhiModel alloc]init];
    model02.name = @"请输入终点";
    self.inputArr = [NSMutableArray array];
    [self.inputArr addObject:model01];
    [self.inputArr addObject:model02];
    [self.topTableView reloadData];
}

- (void)creatSearchView{
    self.tableView.backgroundColor = ViewBackColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 61;
    self.tableView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight-64-182*HeightScale);
    self.tableView.separatorColor = rgba(230,234,237,1);
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DiZhiCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DiZhiCell class])];
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
}

- (void)creatTopTableView{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 166*HeightScale)];
    self.headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.headerView];
    
    self.topTableView = [[UITableView alloc] initWithFrame:CGRectMake(20*WidthScale, 0*HeightScale, kScreenWidth-330*WidthScale,144*HeightScale) style:UITableViewStylePlain];
    self.topTableView.delegate = self;
    self.topTableView.dataSource = self;
    self.topTableView.tableFooterView = [UIView new];
    LRViewBorderRadius(self.topTableView, 8*HeightScale, 2, [UIColor clearColor]);
    self.topTableView.separatorStyle = UITableViewScrollPositionNone;
    [self.topTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TextFiledCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TextFiledCell class])];
    self.topTableView.backgroundColor = [UIColor clearColor];
    [self.headerView addSubview:self.topTableView];
    
    self.btnFatnerView = [[UIView alloc]initWithFrame:CGRectMake(self.topTableView.lt_right, 20*HeightScale, 180*WidthScale, 162*HeightScale)];
    self.btnFatnerView.backgroundColor = rgba(247, 248, 250, 1);
    self.btnFatnerView.lt_centerY = self.topTableView.lt_centerY;
    [self.headerView addSubview:self.btnFatnerView];
    NSArray *titleArr = @[@"切换始终",@"添加途经"];
    NSArray *imageArr = @[@"change_address",@"add_address"];
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *btn = [LTControl createButtonWithFrame:CGRectMake(0, 0+80*HeightScale*i, 179*WidthScale, 79*HeightScale) ImageName:imageArr[i] Target:self Action:@selector(btnCiled:) Title:titleArr[i]];
        btn.tag = 40+i;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10*WidthScale, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10*WidthScale);
        btn.titleLabel.font = FONT(12);
        [btn setTitleColor:BlackTextColor forState:UIControlStateNormal];
        [self.btnFatnerView addSubview:btn];
    }

    self.rightLable = [[UILabel alloc]initWithFrame:CGRectMake(self.topTableView.lt_right, 0, 2*WidthScale, 144*HeightScale)];
    self.rightLable.backgroundColor = ViewBackColor;
    [self.headerView addSubview:self.rightLable];
    
    self.searchBtn = [LTControl createButtonWithFrame:CGRectMake(self.btnFatnerView.lt_right, 0, 146*WidthScale, 162*HeightScale) ImageName:@"ways_gray_sou" Target:self Action:@selector(searchBtnCiled) Title:@"搜索"];
    self.searchBtn.titleLabel.font = FONT(16);
    [self.searchBtn setTitleColor:MainColor forState:UIControlStateHighlighted];
    [self.searchBtn setImage:Image(@"ways_orange_sou") forState:UIControlStateHighlighted];
    self.searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.searchBtn.imageView.frame.size.width, -self.searchBtn.imageView.frame.size.height-10*HeightScale, 0);
    self.searchBtn.imageEdgeInsets = UIEdgeInsetsMake(-self.searchBtn.titleLabel.intrinsicContentSize.height, 0, 0, -self.searchBtn.titleLabel.intrinsicContentSize.width);
    self.searchBtn.backgroundColor = [UIColor whiteColor];
    self.searchBtn.titleLabel.font = FONT(16);
    [self.headerView addSubview:self.searchBtn];
    
    self.topLine = [LTControl createLabelWithFrame:CGRectMake(0, self.topTableView.lt_bottom, kScreenWidth, 20*HeightScale) Font:12 Text:@""];
    self.topLine.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:self.topLine];
    self.topLine02 = [LTControl createLabelWithFrame:CGRectMake(0, 0, 20*WidthScale, 20*HeightScale) Font:12 Text:@""];
    self.topLine02.backgroundColor = [UIColor whiteColor];
    [_headerView addSubview:self.topLine02];
    
}

- (void)btnCiled:(UIButton *)btn{
    switch (btn.tag) {
        case 40:
        {
            [self switchoverBtnCiled];
        }
            break;
        case 41:
        {
            [self addRessBtnCiled];
        }
            break;
            
        default:
            break;
    }
}

/*** 添加途经点 ****/
- (void)addRessBtnCiled{
    if (self.inputArr.count >= 5) {
        [CXAlert showMessage:@"最多只能添加三个途经点" andTrueoOrFalse:NO Time:0];
        return;
    }
    DiZhiModel *model = [[DiZhiModel alloc]init];
    model.name = @"请输入途经点";
    [self.inputArr insertObject:model atIndex:self.inputArr.count-1];
    for (DiZhiModel *model in self.inputArr) {
        NSLog(@"------%@------",model.name);
    }
    self.isAddTu = YES;
    [self relodSubViews:self.inputArr];
}

/*** 切换始终 ****/
- (void)switchoverBtnCiled{

    if (self.inputArr.count < 2) {
        return ;
    }
    /*** 数组逆序 ****/
    NSArray *arr = [[self.inputArr reverseObjectEnumerator] allObjects];
    self.inputArr = [NSMutableArray arrayWithArray:arr];
    [self.view endEditing:YES];
    self.searchData =[NSMutableArray array];
    [self.tableView reloadData];
    [self relodSubViews:self.inputArr];
}

- (void)searchBtnCiled{
    int number = 0;
    
    /*** 判断去重的数组 ****/
    NSMutableArray *chongArray = [NSMutableArray array];
    for (DiZhiModel *hModle in self.inputArr) {
        if ([hModle.name rangeOfString:@"输入"].location != NSNotFound){
            number ++;
        }
    }
    if (number >= 1) {
        if (self.whoIndex < self.inputArr.count) {
            DiZhiModel *kModle = self.inputArr[self.whoIndex];
            if ([kModle.name rangeOfString:@"输入"].location != NSNotFound) {
                if (self.searchData.count > 0) {
                    [self.inputArr replaceObjectAtIndex:self.whoIndex withObject:self.searchData[0]];
                    [self.topTableView reloadData];
                }
            }
        }
    }
    [self.view endEditing:YES];
    int emptyNumber = 0;
    int fullNumber = 0;
    [self.selectField resignFirstResponder];
    
    for (int i = 0;i< self.inputArr.count;i++) {
        DiZhiModel *model = self.inputArr[i];
        if ([model.name rangeOfString:@"输入"].location != NSNotFound){
            [CXAlert showMessage:@"请完善线路" andTrueoOrFalse:NO Time:3];
            emptyNumber ++;
        }
        if (!model.latitude || !model.longitude) {
            fullNumber ++;
        }
        int countNumber = 0;
        for (DiZhiModel *lModel in self.inputArr) {
            if ([lModel.name isEqualToString:model.name]) {
                countNumber++;
                if (countNumber > 1) {
                    [chongArray addObject:[NSString stringWithFormat:@"%d",i]];
                    [chongArray addObject:[NSString stringWithFormat:@"%lu",(unsigned long)[self.inputArr indexOfObject:lModel]]];
                }
            }
        }
        
    }
    
    
    if (emptyNumber > 0) {
        [self.topTableView reloadData];
        return;
    }
    if (fullNumber > 0) {
        [CXAlert showMessage:@"路线数据有变更，请输入地点重新搜索" andTrueoOrFalse:NO Time:3];
        return;
    }
    
    /*** 判断重复点操作 ****/
    if (chongArray.count >= 2) {
        if ([chongArray[0] intValue] == 0 &&  [chongArray[1] intValue] == self.inputArr.count-1) {
            [CXAlert showMessage:@"起终点不能相同" andTrueoOrFalse:NO Time:3];
        }else{
            [CXAlert showMessage:@"途经点和起终点不能相同" andTrueoOrFalse:NO Time:3];
        }
         return;
    }
    
    [self relodSubViews:self.inputArr];
    [self.topTableView reloadData];
    GuiDetailRodesVC * view = [[GuiDetailRodesVC alloc]init];
    view.hidesBottomBarWhenPushed = YES;
    view.inputArr = self.inputArr;
    [self.navigationController pushViewController:view animated:YES];
    
    self.isSou = NO;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.topTableView) {
        return self.inputArr.count;
    }else{
        return self.searchData.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72*HeightScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weakSelf
    if (tableView == self.topTableView) {
        TextFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TextFiledCell class]) forIndexPath:indexPath];
        cell.backgroundColor = rgba(247, 248, 250, 1);
        [cell creatArr:self.inputArr andLtIndex:indexPath.row andModel:self.inputArr[indexPath.row] andSouSuo:self.isSou andAddTu:self.isAddTu];
        cell.deleteBlock = ^(DiZhiModel * _Nonnull model) {
            [weakSelf.inputArr removeObject:model];
            weakSelf.isAddTu = YES;
            [weakSelf relodSubViews:self.inputArr];
        };
        cell.backDesAndIndePathBlock = ^(NSString * _Nonnull textStr, NSInteger selectIndex, BOOL start, UITextField * _Nonnull selectTextFiled) {
            weakSelf.isAddTu = NO;
            weakSelf.selectField = selectTextFiled;
            [weakSelf searMethondWithText:textStr andSelectIndex:selectIndex andStart:start];
        };
        /*** 开始响应回掉 ****/
        cell.backBeginBlock = ^(NSString * _Nonnull textStr, NSInteger selectIndex, BOOL start, UITextField * _Nonnull selectTextFiled) {
            weakSelf.selectField = selectTextFiled;
            [weakSelf searMethondWithText:textStr andSelectIndex:selectIndex andStart:start];
        };
        return cell;
    }else{
        DiZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DiZhiCell class])];
        cell.model = self.searchData[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableView){
        /*** 选择地址操作 ****/
        DiZhiModel *model = self.searchData[indexPath.row];
        self.isAddTu = NO;
        [self.inputArr replaceObjectAtIndex:self.whoIndex withObject:model];
        [self.topTableView reloadData];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.hidden = YES;
            self.tableView.lt_y = kScreenHeight;
        }];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark ------  地图搜索相关  ------
- (void)searMethondWithText:(NSString *)textStr andSelectIndex:(NSInteger )selectIndex andStart:(BOOL )start{
    self.whoIndex = selectIndex;
    if (textStr.length > 0 || start == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.hidden = NO;
            self.tableView.lt_y = self.headerView.lt_bottom;
            self.tableView.lt_height = kScreenHeight - 64 - self.headerView.lt_height;

        }];
        if (textStr.length > 0) {
            [self creatDataWithKey:textStr];
        }else{
            self.searchData = [NSMutableArray array];
            [self.tableView reloadData];
        }
    }else{
        if (selectIndex == 0) {
            DiZhiModel *model = [[DiZhiModel alloc]init];
            model.name = @"请输入起点";
            [self.inputArr replaceObjectAtIndex:0 withObject:model];
        }else if(selectIndex == self.inputArr.count - 1){
            DiZhiModel *model = [[DiZhiModel alloc]init];
            model.name = @"请输入终点";
            [self.inputArr replaceObjectAtIndex:self.inputArr.count - 1 withObject:model];
        }else{
            DiZhiModel *model = [[DiZhiModel alloc]init];
            model.name = @"请输入途经点";
            [self.inputArr replaceObjectAtIndex:selectIndex withObject:model];
        }
        [self.topTableView reloadData];
        [UIView animateWithDuration:0.3 animations:^{
            self.tableView.hidden = YES;
            self.tableView.lt_y = kScreenHeight;
        }];
        self.searchData = [NSMutableArray array];
        [self.tableView reloadData];
    }
}

- (void)creatDataWithKey:(NSString *)keyword{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords            = keyword;
    //    request.city                = @"";
    request.types               = searchTypes;
    request.requireExtension    = YES;
    request.offset = 10;
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = NO;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
}


- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if (response.pois.count == 0){
        return;
    }
    self.searchData = [NSMutableArray array];
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop){
        DiZhiModel *model=[[DiZhiModel alloc]init];
        model.latitude= obj.location.latitude;
        model.longitude= obj.location.longitude;
        model.name= [NSString stringWithFormat:@"%@(%@)",obj.name,obj.province];
        model.address=obj.address;
        model.city=obj.city;
        model.province=obj.province;
        [self.searchData addObject:model];
    }];
    [self.tableView reloadData];
}


- (void)relodSubViews:(NSArray *)arr{
    [UIView animateWithDuration:0.3 animations:^{
        self.headerView.lt_height = 72*HeightScale*arr.count + 20*HeightScale;
        self.headerView.backgroundColor = rgba(247, 248, 250, 1);
        self.topTableView.lt_height = 72*HeightScale*arr.count;
        self.rightLable.lt_height = 72*HeightScale*arr.count;;
        self.btnFatnerView.lt_centerY = self.topTableView.lt_centerY;
        self.searchBtn.frame = CGRectMake(self.btnFatnerView.lt_right, 0, 146*WidthScale, self.topTableView.lt_height);
        self.topLine.lt_y = self.topTableView.lt_bottom;
        self.topLine02.lt_height = self.topTableView.lt_height;
        [self.topTableView reloadData];
    }];
}


@end
