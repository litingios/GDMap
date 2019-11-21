# GDMap
GDMap

# 高德的文件太大，传不上传去
直接运行此项目的话会报错 执行一下 pod install 就可以了

本项目主要是基于高德地图实现了大头针展示，分级大头针，自定制大头针，在地图上画线，线和点共存，路线规划（驾车路线规划），路线导航，等一些常见的功能。不多说了，直接上图吧。

一. 普通大头针展示，这个不多说，请求数据，将数据转化成大头针对象，添加到地图上，实现定制大头针的代理方法即可，如果有点击大头针的需求，和取消的需求，实现两个代理即可，这个不多说，直接看代码就可以了。
![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.54.01.png)

二.分级大头针大头针展示，有的时候根据需要，不同类型的大头针用不同的图片来展示，就比如说优惠活动吧，有优惠活动的商店用优惠的图标，没有的用普通的图标，但是呢，产品还是想要优惠的大头针位于视图的最上层，让用户可以第一眼就可以看到。就用到这个分级了，其实也是很简单，MAPinAnnotationView 有一个属性 zIndex 想让谁在最上面就把这个zIndex的值设大就可以了，比如说优惠的zIndex = 2，普通的zIndex = 1，优惠的就在普通的上面了。
![Image text](https://github.com/litingios/GDMap/blob/master/tupian/Simulator%20Screen%20Shot%20-%20iPhone%207%20-%202019-11-21%20at%2010.58.29.png)
