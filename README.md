# GDMap
GDMap

# 高德的文件太大，传不上传去
直接运行此项目的话会报错 执行一下 pod install 就可以了

本项目主要是基于高德地图实现了大头针展示，分级大头针，自定制大头针，在地图上画线，线和点共存，路线规划（驾车路线规划），路线导航，等一些常见的功能。不多说了，直接上图吧。


一. 普通大头针展示，这个不多说，请求数据，将数据转化成大头针对象，添加到地图上，实现定制大头针的代理方法即可，如果有点击大头针的需求，和取消的需求，实现两个代理即可，这个不多说，直接看代码就可以了。
![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.54.01.png)


二.分级大头针大头针展示，有的时候根据需要，不同类型的大头针用不同的图片来展示，就比如说优惠活动吧，有优惠活动的商店用优惠的图标，没有的用普通的图标，但是呢，产品还是想要优惠的大头针位于视图的最上层，让用户可以第一眼就可以看到。就用到这个分级了，其实也是很简单，MAPinAnnotationView 有一个属性 zIndex 想让谁在最上面就把这个zIndex的值设大就可以了，比如说优惠的zIndex = 2，普通的zIndex = 1，优惠的就在普通的上面了。
![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.58.29.png)


三.自定制大头针大头针展示，有的时候产品想让大头针展示的信息更多，那么就遇到自定制了。（1）自定制 MAAnnotationView（具体的看高德文档，不细说了） （2）CustomCalloutView 自定制气泡 （这个也还是看高德文档），当你按着高德文档将代码写完后，发现并没有实现咱们想要的效果。


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
        
        [annotationView setSelected:YES]
        
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

加上这行代码

- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `[annotationView setSelected:YES]`

那么就实现了以下效果

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.58.38.png)

当你正在高兴的时候，却发现大头针的点击事件不见了，是因为弹出了自定义气泡，不在走大头针的代理方法。那么主意来了在自定制的气泡上面添加一个透明
的按钮，不就可以解决了吗，却发现按钮的点击事件失效？？？ what 什么鬼   在使用高德地图sdk开发的时候,需要自定义气泡吹出框,发现气泡添加的点击事件或者button都没响应  原因:自定义的气泡是添加到大头针上的，而大头针的size只有下面很小一部分，所以calloutView是在大头针的外面的。
 而 iOS 按钮超过父视图范围是无法响应事件的处理方法。
 
 - ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `解决方法 在CustomAnnotationView.m（自定制大头针类）中重写hittest方法`
 
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView *view = [super hitTest:point withEvent:event];

    if (view == nil) {

        CGPoint tempoint = [self.calloutView.btn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.calloutView.btn.bounds, tempoint))

        {
            view = self.calloutView.btn;
        }
    }
    return view;
}
 
就实现了如下效果

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.58.41.png)

- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `大头针知识补充`
在地图上添加的大头针数量有的时候多达几千个，有的时候少则几十个，产品呢希望 几千个 的时候大头针在地图上显示全，在 几十个 的时候吧，地图比例尺最大，也就是显示最详细的位置信息，这个需求不要再苦苦的设置地图的比例尺了，

一行代码搞定

[self.mapView showAnnotations:self.backStateAnnotationArray edgePadding:UIEdgeInsetsMake(40, 40, 40, 40) animated:YES]; 

//UIEdgeInsetsMake 参数 上左下右


四.画单线，按照高德的文档，拿到数据后，将数据转化为线的对象，再添加到地图上就可以了，在这里说一个坑吧，就是画的线在地图上展示不全的问题，也就是画的线在地图的显示范围内只露着半截或者更少。

再将线添加到地图上之后加上就可以了

- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `    [_mapView showOverlays:self.polylineArr edgePadding:UIEdgeInsetsMake(60, 40, 80, 40) animated:YES];`


实现效果

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.58.52.png)


五.画多条线，其实也简单，在单条线的外层加上一个循环即可，

那么在做路线规划类的需求时，需要实现以下效果

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.59.04.png)

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2013.11.47.png)


![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2013.11.42.png)

点击下面方案按钮时地图上的线的颜色也是跟着改变需要怎么实现呢？？

- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `大思路`
    
高德地图画线时将线添加到地图上大家可能使用的是

[_mapView addOverlays:self.polylineArr];这个方法，这个方法默认的添加的线全部位于同一个层级，那个画的第三条线肯定会盖在第一条线和第二条线的bug

展示如下

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/WechatIMG67.jpeg)

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/WechatIMG68.jpeg)

![Image text](https://github.com/litingios/GDMap/blob/master/tupian/WechatIMG69.jpeg)


- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `解决方法`


使用这行代码  [_mapView insertOverlay:self.polylineArr[i] atIndex:-0.1 level:-0.1];  

点击那条线就把那条线 insert到地图的最上层，永远不会被别的线挡住。

- ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `注意点`

[_mapView insertOverlay:self.polylineArr[i] atIndex:-0.1 level:-0.1];

地图上的默认地理标示 atInde: level: 这两个参数默认为0，我这里设为0.1的原因，是因为在做路线规划时，我不希望自己画的线盖住地图原有的高速名称，所以将这

两个参数改成了-0.1，也就是位于地图默认地理标示的下面。

具体代码请查看本 Demo

六。路线规划以及导航的实现

贴几张实现效果吧，具体的下载Demo自行查看


![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.59.19.png)


![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2011.00.04.png)


![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.59.35.png)


















 
 
 
 
 
 
