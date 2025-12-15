import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gzc_app/core/theme/colors.dart' show surfaceColor, actionColor, secondaryColor, secondaryTextColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/utils/devices.dart';
import 'package:gzc_app/features/home/presentation/controllers/home_controller.dart';
import 'package:gzc_app/features/home/presentation/widgets/home_shimmer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageContentState();
}

class _HomePageContentState extends ConsumerState<HomePage> {
  final double bannerHeight = 220.h;
  late final Map<String, double> fnParams;

  @override
  void initState() {
    super.initState();
    fnParams = _calculateFnParams();
  }

  // 计算功能图标区参数
  Map<String, double> _calculateFnParams() {
    const int crossAxisCount = 5;
    final double axisSpacing = Spacing.sm;
    final double boxMargin = Spacing.pageHorizontal;
    final double screenWidth = DeviceUtils.screenWidth - (2 * boxMargin);
    final double itemWidth = ((screenWidth - (crossAxisCount - 1) * axisSpacing) / 5);
    const double childAspectRatio = 0.9;
    final double itemHeight = itemWidth / childAspectRatio;
    final double iconBgSize = itemWidth * 0.74;
    final double boxPaddingV = Spacing.md;
    final double boxPaddingH = axisSpacing;

    // 默认两行高度（用于 shimmer）
    final double fnHeight = itemHeight * 2 + boxPaddingV * 2;
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
    final bannerValue = ref.watch(bannerProvider);
    final fnValue = ref.watch(fnProvider);
    final caseValue = ref.watch(caseProvider);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // ====== 1. Banner 轮播图 ======
            bannerValue.when(
              loading: () => BannerShimmer(bannerHeight: bannerHeight),
              error: (e, st) => Text("Banner加载失败：${e.toString()}"),
              data: (data) => _buildBanner(data),
            ),

            // ====== 3. 案件取证区 ======
            caseValue.when(
              loading: () =>
                  CaseShimmer(bannerHeight: bannerHeight, fnParams: fnParams),
              error: (e, st) => Text("案件加载失败：${e.toString()}"),
              data: (data) => _buildCase(data),
            ),

            // ====== 2. 功能图标区 ======
            fnValue.when(
              loading: () => FunctionShimmer(fnParams: fnParams),
              error: (e, st) => Text("功能加载失败：${e.toString()}"),
              data: (data) => _buildFn(context, data),
            ),
          ],
        ),
      ),
    );
  }

  // 轮播图区
  Widget _buildBanner(List<String> bannerImages){
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
  Widget _buildFn(BuildContext context, List<Map<String, String>> functionItems){
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
  Widget _buildCase(List<Map<String, String>> caseItems){
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
          _buildCaseType(caseItems)
        ],
      ),
    );
  }

  // 取证分类
  Widget _buildCaseType(List<Map<String, String>> caseItems){
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
                  return _buildCaseList(index, leadingSize, caseItems);
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
  Widget _buildCaseList(int index, double leadingSize, List<Map<String, String>> caseItems){
    // TODO: 等到后端接口返回数据后，再实现， 不同的tab需要点击到才能加载数据列表
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: caseItems.length,
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