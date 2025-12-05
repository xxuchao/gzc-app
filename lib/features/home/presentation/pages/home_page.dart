import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/colors.dart' show surfaceColor, actionColor, secondaryColor, secondaryTextColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/utils/devices.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState  createState() => HomePageState ();
}

class HomePageState  extends State<HomePage> {
  // 模拟轮播图数据
  final List<String> bannerImages = [
    'https://picsum.photos/300/200?random=2',
    'https://picsum.photos/300/200?random=3',
    'https://picsum.photos/300/200?random=4',
  ];

  // 功能图标数据
  final List<Map<String, String>> functionItems = [
    {'icon': '手机拍照', 'title': '手机拍照'},
    {'icon': '手机录像', 'title': '手机录像'},
    {'icon': '现场录音', 'title': '现场录音'},
    {'icon': '电话录音', 'title': '电话录音'},
    {'icon': '屏幕录制', 'title': '屏幕录制'},
    {'icon': '短信取证', 'title': '短信取证'},
    {'icon': '版权保护', 'title': '版权保护'},
    {'icon': '邮件认证', 'title': '邮件认证'},
    {'icon': '电子合同', 'title': '电子合同'},
    {'icon': '网页取证', 'title': '网页取证'},
    {'icon': '更多操作', 'title': '更多操作'},
    {'icon': '更多操作', 'title': '更多操作'},
  ];

  // 二级分类标签
  final List<String> tabs = ['网购', '现场取证', '其他', '网购', '现场取证', '其他'];
  final List<Map<String, String>> contentItems = [
    {'title': '网购', 'desc': '适用于网络平台侵权购物'},
    {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
    {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
    {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
    {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
    {'title': '售货实录', 'desc': '适用于电子书、直播等无实体证物的维权场景'},
  ];

  final double bannerHeight = 220.h;

  late final Map<String, double> fnParams;

  @override
  void initState() {
    super.initState();
    fnParams = calculateFn();
  }

  // 计算功能图标区参数
  Map<String, double> calculateFn(){
    const int crossAxisCount = 5; // 每行显示 5 个
    final double axisSpacing = Spacing.sm; // 每个item的水平间距
    final double boxMargin = Spacing.pageHorizontal; // 盒子距离屏幕两侧的距离
    final double screenWidth = DeviceUtils.screenWidth - (2 * boxMargin); // 屏幕宽度
    final double itemWidth = ((screenWidth - (crossAxisCount - 1) * axisSpacing) / 5); // 每个图标的大小
    const double childAspectRatio = 0.9; // item的宽高比
    final double itemHeight = itemWidth / childAspectRatio; 

    final double iconBgSize = itemWidth * 0.74; // 图标背景大小

    final double boxPaddingV = Spacing.md; // 垂直内边距
    final double boxPaddingH = axisSpacing; // 水平内边距

    late final double fnHeight;
    if (functionItems.length > crossAxisCount) {
      fnHeight = itemHeight * 2 + boxPaddingV * 2;
    } else {
      fnHeight = itemHeight + boxPaddingV * 2;
    }
    final double areaTop = bannerHeight - (fnHeight * 0.3);
    return {
      'fnHeight': fnHeight,
      'areaTop': areaTop,
      'itemHeight': itemHeight,
      'iconBgSize': iconBgSize,
      'boxPaddingV': boxPaddingV,
      'boxPaddingH': boxPaddingH,
      'boxMargin': boxMargin,
      'crossAxisCount': crossAxisCount.toDouble(),
      'axisSpacing': axisSpacing,
      'childAspectRatio': childAspectRatio,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // ====== 1. Banner 轮播图 ======
            _buildBanner(),

            // ====== 3. 案件取证区 ======
            _buildCase(),

            // ====== 2. 功能图标区 ======
            _buildFn(context),
          ],
        ),
      ),
    );
  }

  // 轮播图区
  Widget _buildBanner(){
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: bannerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Spacing.radiusXl),
            bottomRight: Radius.circular(Spacing.radiusXl),
          )
        ),
        clipBehavior: Clip.hardEdge,
        child: CarouselSlider(
          items: bannerImages.map((url) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            viewportFraction: 1,
            enlargeFactor: 0
          ),
        ),
      ),
    );
  }

  // 功能图标区
  Widget _buildFn(BuildContext context){
    return Positioned(
      top: fnParams['areaTop'],
      left: 0,
      right: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: fnParams['fnHeight']!),
        child: Container(
          height: fnParams['fnHeight']!,
          margin: EdgeInsets.symmetric(horizontal: fnParams['boxMargin']!, vertical: 0),
          padding: EdgeInsets.symmetric(vertical: fnParams['boxPaddingV']!, horizontal: fnParams['boxPaddingH']!),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            boxShadow: [
              BoxShadow(color: secondaryTextColor.withAlpha(100), blurRadius: Spacing.radiusMd),
            ],
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: fnParams['crossAxisCount']!.toInt(),
              crossAxisSpacing: fnParams['axisSpacing']!,
              mainAxisSpacing: fnParams['axisSpacing']!,
              childAspectRatio: fnParams['childAspectRatio']!,
            ),
            itemCount: functionItems.length,
            itemBuilder: (context, index) {
              final item = functionItems[index];
              return Container(
                color: surfaceColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: fnParams['iconBgSize']!,
                      height: fnParams['iconBgSize']!,
                      decoration: BoxDecoration(
                        color: actionColor,
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      ),
                      child: Icon(Icons.camera_alt, color: surfaceColor, size: Spacing.iconXl),
                    ),
                    Text(
                      item['title']!,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }

  // 案件取证区
  Widget _buildCase(){
    final double headerHeight = 70.h;
    final double headerPadding = headerHeight * 0.3;
    final double remainHeight = headerHeight - headerHeight;
    final double areaTop = bannerHeight + fnParams['fnHeight']! - fnParams['fnHeight']! * 0.3 - headerPadding;
    return Positioned(
      top: areaTop,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: headerPadding),
            height: headerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF950009),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Spacing.radiusXl),
                topRight: Radius.circular(Spacing.radiusXl),
              )
            ),
            child: Container(
              alignment: Alignment.center,
              height: remainHeight,
              width: double.infinity,
              child: Text(
                "场景化取证案件",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: surfaceColor),
              ),
            )
          ),
          _buildCaseType()
        ],
      ),
    );
  }

  // 取证分类
  Widget _buildCaseType(){
    final double leadingSize = 56.w;
    return Expanded(
      child: DefaultTabController(
        length: 8,
        child: Column(
          children: [
            Container(
              color: surfaceColor,
              padding: EdgeInsets.symmetric(horizontal: Spacing.md),
              child: PreferredSize(
                preferredSize: Size.fromHeight(46.h),
                child: TabBar(
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.symmetric(horizontal: Spacing.md),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  labelColor: secondaryColor,
                  dividerHeight: 0,
                  indicatorColor: secondaryColor,
                  tabs: [
                    Tab(text: "全部"),
                    Tab(text: "待审核"),
                    Tab(text: "未通过"),
                    Tab(text: "已通过"),
                    Tab(text: "已完成"),
                    Tab(text: "已取消"),
                    Tab(text: "已拒绝"),
                    Tab(text: "已过期"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: Spacing.sm),
                child: TabBarView(
                  children: List.generate(8, (index) {
                  return _buildCaseList(index, leadingSize);
                }),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  // 取证内容列表
  Widget _buildCaseList(int index, double leadingSize){
    // TODO: 等到后端接口返回数据后，再实现， 不同的tab需要点击到才能加载数据列表
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contentItems.length,
        itemBuilder: (context, index) {
          return Card(
            color: surfaceColor,
            margin: EdgeInsets.only(bottom: Spacing.sm),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: Spacing.md),
              leading: Container(
                width: leadingSize,
                height: leadingSize,
                decoration: BoxDecoration(
                  color: actionColor,
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Icon(Icons.check_circle, color: surfaceColor, size: Spacing.iconXl,),
              ),
              horizontalTitleGap: Spacing.md,
              title: Text("网购$index"),
              subtitle: Text(maxLines: 2, overflow: TextOverflow.ellipsis, "适用于网络平台购物侵权$index"),
            ),
          );
        },
      ),
    );
  }
}