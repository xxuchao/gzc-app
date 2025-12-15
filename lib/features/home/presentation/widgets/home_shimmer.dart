import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/colors.dart' show surfaceColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:shimmer/shimmer.dart';

/// 通用 Shimmer 占位盒子
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? Spacing.radiusSm),
      ),
    );
  }
}

/// Banner 骨架屏
class BannerShimmer extends StatelessWidget {
  final double bannerHeight;

  const BannerShimmer({
    super.key,
    required this.bannerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: bannerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Spacing.radiusXl),
              bottomRight: Radius.circular(Spacing.radiusXl),
            ),
          ),
        ),
      ),
    );
  }
}

/// 功能图标区骨架屏
class FunctionShimmer extends StatelessWidget {
  final Map<String, double> fnParams;

  const FunctionShimmer({
    super.key,
    required this.fnParams,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: fnParams['areaTop'],
      left: 0,
      right: 0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: fnParams['fnHeight']!,
          margin: EdgeInsets.symmetric(horizontal: fnParams['boxMargin']!),
          padding: EdgeInsets.symmetric(
            vertical: fnParams['boxPaddingV']!,
            horizontal: fnParams['boxPaddingH']!,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: fnParams['crossAxisCount']!.toInt(),
              crossAxisSpacing: fnParams['axisSpacing']!,
              mainAxisSpacing: fnParams['axisSpacing']!,
              childAspectRatio: fnParams['childAspectRatio']!,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerBox(
                    width: fnParams['iconBgSize']!,
                    height: fnParams['iconBgSize']!,
                  ),
                  ShimmerBox(
                    width: fnParams['iconBgSize']! * 0.9,
                    height: 12.h,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 案件取证区骨架屏
class CaseShimmer extends StatelessWidget {
  final double bannerHeight;
  final Map<String, double> fnParams;

  const CaseShimmer({
    super.key,
    required this.bannerHeight,
    required this.fnParams,
  });

  @override
  Widget build(BuildContext context) {
    final double headerHeight = 70.h;
    final double headerPadding = headerHeight * 0.3;
    final double areaTop = bannerHeight + fnParams['fnHeight']! - fnParams['fnHeight']! * 0.3 - headerPadding;
    final double leadingSize = 56.w;

    return Positioned(
      top: areaTop,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          // Header 保持原样
          Container(
            padding: EdgeInsets.only(top: headerPadding),
            height: headerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF950009),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Spacing.radiusXl),
                topRight: Radius.circular(Spacing.radiusXl),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: headerHeight - headerPadding,
              width: double.infinity,
              child: Text(
                "场景化取证案件",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: surfaceColor),
              ),
            ),
          ),
          // Tab 骨架
          Container(
            color: surfaceColor,
            padding: EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.sm),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: EdgeInsets.only(right: Spacing.md),
                    child: ShimmerBox(width: 50.w, height: 24.h),
                  );
                }),
              ),
            ),
          ),
          // 列表骨架
          Expanded(
            child: Container(
              color: surfaceColor,
              padding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: Spacing.sm),
                      padding: EdgeInsets.all(Spacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Spacing.radiusMd),
                      ),
                      child: Row(
                        children: [
                          ShimmerBox(width: leadingSize, height: leadingSize),
                          SizedBox(width: Spacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerBox(width: 100.w, height: 16.h),
                                SizedBox(height: Spacing.xs),
                                ShimmerBox(width: 180.w, height: 14.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
