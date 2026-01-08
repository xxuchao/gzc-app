import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/colors.dart' show diverColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/custom_list_tile.dart';
import 'package:gzc_app/core/widgets/custom_tabbar.dart';
import 'package:gzc_app/core/widgets/title_tile.dart';

class ApplicantDetail extends StatelessWidget {
  ApplicantDetail({super.key});

  final List<CardTileData> applicantInfo = [
    CardTileData(title: "申请人名称", text: "张三", arrow: false),
    CardTileData(title: "联系手机号", text: "13333333333", arrow: true, onTap: (){}),
    CardTileData(title: "备注", text: "暂无备注", arrow: true, border: false, onTap: (){}),
  ];

  final List<CardTileData> idCardInfo = [
    CardTileData(title: "证件类型", text: "居民身份证", arrow: false),
    CardTileData(title: "证件号码", text: "35222222222222", arrow: false),
    CardTileData(title: "证件有效期", text: "2016-06-16 至 2030-06-16", arrow: false),
  ];

  @override
  Widget build(BuildContext context) {
    const List<Tab> tabs = [
      Tab(text: "申请人类型"),
      Tab(text: "身份证明材料"),
      Tab(text: "其他证明材料"),
    ];
    final List<Widget Function()> tabViews = [
      _buildApplicantInformation,
      _buildIdCardMaterial,
      _buildOtherMaterial,
    ];

    return Scaffold(
      appBar: AppBar(title: Text("申请人详情")),
      body: CustomTabBar(
        tabs: tabs,
        tabViews: List.generate(tabs.length, (index) {
          return tabViews[index]();
        }),
        tabBarHorizontalPadding: EdgeInsets.symmetric(horizontal: Spacing.md),
        labelPadding: EdgeInsets.symmetric(horizontal: Spacing.md),
        // dividerHeight: 0,
      ),
    );
  }

  // 申请人信息
  Widget _buildApplicantInformation(){
    return ListView(
      children: [
        CustomCard(
          child: TitleTile(
            title: "申请人类型",
            sub: Text("境内申请人"),
          ),
        ),
        CustomCard(
          padding: EdgeInsets.zero,
          material: true,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(Spacing.pageHorizontal),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: diverColor,
                      width: 0.5,
                    ),
                  )
                ),
                child: TitleTile(
                  title: "基本信息",
                ),
              ),
              ...applicantInfo.map((item) {
                // return _buildCardTile(item);
                return CustomListTile(
                  title: item.title,
                  showBottomBorder: item.border,
                  showTrailingArrow: item.arrow,
                  trailing: Text(item.text),
                  onTap: item.onTap,
                );
              })
            ],
          ),
        ),
        CustomCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(Spacing.pageHorizontal),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: diverColor,
                      width: 0.5,
                    ),
                  )
                ),
                child: TitleTile(
                  title: "证件信息",
                ),
              ),
              ...idCardInfo.map((item) {
                // return _buildCardTile(item);
                return CustomListTile(
                  title: item.title,
                  showBottomBorder: item.border,
                  trailing: Text(item.text),
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  // 身份证明材料
  Widget _buildIdCardMaterial(){
    return ListView(
      children: [
        Text("身份证明材料")
      ],
    );
  }

  // 其他证明材料
  Widget _buildOtherMaterial(){
    return ListView(
      children: [
        Text("其他证明材料")
      ],
    );
  }

  Widget _buildCardTile(CardTileData data){
    return Container(
      padding: EdgeInsets.all(Spacing.pageHorizontal),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.5, color: diverColor))
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(data.title),
        Row(children: [
          Text(data.text),
          if(data.arrow) Icon(Icons.arrow_forward_ios, size: Spacing.iconXS,)
        ],)
      ],),
    );
  }
}

class CardTileData {
  final String title;
  final String text;
  final bool arrow;
  final VoidCallback? onTap;
  final bool border;

  const CardTileData({
    required this.title,
    required this.text,
    required this.arrow,
    this.onTap,
    this.border = true
  }); 
}