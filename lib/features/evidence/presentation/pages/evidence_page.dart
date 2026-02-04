import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/router/app_router.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/custom_tabbar.dart';
import 'package:gzc_app/core/widgets/info_card.dart';
import 'package:gzc_app/core/widgets/media_preview.dart';
import 'package:gzc_app/core/widgets/popup_menu.dart';

class EvidencePage extends StatefulWidget {
  const EvidencePage({super.key});

  @override
  State<EvidencePage> createState() => _EvidencePageState();
}

class _EvidencePageState extends State<EvidencePage> {
  // 当前选中的状态标签
  String _selectedStatusTab = "未存证据";
  
  // 当前选中的类型标签
  String _selectedTypeTag = "全部";

  // 搜索控制器
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // 状态标签列表
  final List<Tab> _statusTabs = [
    Tab(text: "未存证据"),
    Tab(text: "已存证据"),
    Tab(text: "已申请存证证明"),
    Tab(text: "已申请公证书"),
  ];

  // 类型标签列表
  final List<String> _typeTags = ["全部", "网页取证", "见证实录", "手机相册", "现场录音", "手机录像", "电话录音", "屏幕录制", "短信发送"];
  
  // 每行显示的标签数量
  final int _tagsPerRow = 5;

  // 模拟证据数据
  final List<EvidenceItem> _evidenceList = [
    EvidenceItem(
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 手机拍照",
      time: "2025-09-05 16:16:53",
      status: "网站点击查看",
    ),
    EvidenceItem(
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 手机录像",
      time: "2025-09-05 16:16:53",
      status: "网站点击查看",
    ),
    EvidenceItem(
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 现场录音",
      time: "2025-09-05 16:16:53",
      status: "网站点击查看",
    ),
    EvidenceItem(
      title: "证据名称证据名称证据名称证据名称",
      subtitle: "彭于晏 | 电话录音",
      time: "2025-09-05 16:16:53",
      status: "网站点击查看",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 搜索栏
            _buildSearchBar(),
            
            // 时间筛选
            _buildTimeFilter(),

            Expanded(
              child: CustomTabBar(
                tabBarViewPadding: EdgeInsets.zero,
                tabs: _statusTabs,
                tabViews: [_buildNotStoredEvidence(), Container(), Container(), Container()],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 构建搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.cardPadding,
        vertical: Spacing.verticalGapMd,
      ),
      color: surfaceColor,
      child: Container(
        height: 42.h,
        decoration: BoxDecoration(
          color: Colors.grey[300], // 设置背景为浅灰色
          borderRadius: BorderRadius.circular(Spacing.radiusXXL), // 圆角
        ),
        child: TextField(
          style: Theme.of(context).textTheme.bodyMedium, // 输入文字颜色设为黑色以保证可读性
          cursorColor: Colors.black, // 光标颜色
          decoration: InputDecoration(
            hintText: '证据包名称/编号/证据名称',
            hintStyle: TextStyle(color: Colors.grey[600]), // 提示文字颜色稍暗一些
            contentPadding: EdgeInsets.symmetric(
              horizontal: Spacing.cardPadding,
              vertical: 0,
            ),
            border: InputBorder.none, // 去掉默认边框
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 6),
              child: Icon(
                Icons.search,
                color: Colors.grey[600], // 搜索图标颜色
                size: 20,
              ),
            ),
          ),
          onSubmitted: (value) {
            // 执行搜索逻辑
          },
        ),
      ),
    );
  }

  // 构建时间筛选
  Widget _buildTimeFilter() {
    return Container(
      padding: EdgeInsets.only(left: Spacing.cardPadding, right: Spacing.cardPadding, top: Spacing.verticalGapMd, bottom: Spacing.buttonPaddingV),
      decoration: BoxDecoration(
        color: surfaceColor,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!))
      ),
      child: Row(
        children: [
          Text(
            "时间筛选",
          ),
          SizedBox(width: Spacing.md),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.verticalGapMd),
              height: 42.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Spacing.radiusXXL),
                border: BoxBorder.all(color: Colors.grey)
              ),
              child: Row(children: [
                Icon(Icons.calendar_today, color: Colors.grey, size: Spacing.iconMd,),
                Spacer(),
                Text("日期起始值"),
                Spacer(),
                Text("至"),
                Spacer(),
                Text("日期结束值"),
              ],),
            ),
          ),
          // SizedBox(width: Spacing.md),
          Builder(
            builder: (context) {
              return IconButton(visualDensity: VisualDensity.compact, icon: Icon(Icons.more_horiz_outlined), onPressed: () async {
                final result = await showCustomPopupMenu(
                  triggerContext: context,
                  menuShowCount: 4,
                  menuWidth: 150.w,
                  options: [
                    PopupOption(key: 'opt1', label: '批量存证'),
                    PopupOption(key: 'opt2', label: '批量申请存证证明'),
                    PopupOption(key: 'opt3', label: '批量申请公证书', enabled: false),
                    PopupOption(key: 'opt4', label: '批量删除'),
                  ]
                );
                if (result != null) {
                  if (result == 'opt1' || result == 'opt4') {
                    AppRouter.pushNamed(AppRoutes.evidenceBatch);
                  }
                }
              },);
            }
          )
        ],
      ),
    );
  }

  // 构建标签行
  List<Widget> _buildTagRows() {
    List<Widget> rows = [];
    
    for (int i = 0; i < _typeTags.length; i += _tagsPerRow) {
      int endIndex = (i + _tagsPerRow < _typeTags.length) ? i + _tagsPerRow : _typeTags.length;
      List<String> rowTags = _typeTags.sublist(i, endIndex);
      
      rows.add(
        Row(
          children: rowTags.map((tag) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Spacing.xs,
                  vertical: Spacing.verticalGapXS,
                ),
                child: _buildTagItem(tag),
              ),
            );
          }).toList(),
        ),
      );
    }
    
    return rows;
  }

  // 构建单个标签项
  Widget _buildTagItem(String tag) {
    final isSelected = tag == _selectedTypeTag;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTypeTag = tag;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.sm,
          vertical: Spacing.verticalGapXS,
        ),
        decoration: BoxDecoration(
          color: isSelected ? tagDangerColor : Colors.white,
          borderRadius: BorderRadius.circular(Spacing.radiusXXL),
          border: Border.all(
            color: isSelected ? tagDangerColor : Colors.grey[300]!,
          ),
        ),
        child: Text(
          tag,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: isSelected ? Colors.white : secondaryTextColor,
          ),
        ),
      ),
    );
  }

  // 构建证据列表
  Widget _buildEvidenceList() {
    return ListView.builder(
      itemCount: _evidenceList.length,
      itemBuilder: (context, index) {
        // return _buildEvidenceItem(_evidenceList[index]);
        return InfoCard(
          titleData: TitleData(
            title: "取证时间：2025-10-10 10:10:10",
            operateType: TitleOperateType.checkbox,
            checked: false,
            onChecked: (p0) => {},
            // operateWidget: Row(children: [
            //   InfoButton(text: "存证", onpressed: (BuildContext context){},),
            //   SizedBox(width: Spacing.sm),
            //   InfoButton(text: "删除", onpressed: (BuildContext context){},),
            // ],),
            // operateWidget: Text("123123")
            // operateText: "存证",
            // onpressed: (BuildContext context){
            //   print("123");
            // }
          ),
          contentData: ContentData(
            title: "证据名称",
            previews: [],
            editTitle: true,
            subtitle: "张三 | 手机拍摄",
            // subTime: "2020-10-10 10:10:10",
            subStatus: SubStatus.step_1,
            subStatusText: "存证中",
            createTime: "2023-10-10 10:10:10",
            multiInfo: "证据10/1",
            operate: Row(children: [
              InfoButton(text: "存证", onpressed: (BuildContext context){},),
              SizedBox(width: Spacing.sm),
              InfoButton(text: "删除", onpressed: (BuildContext context){},),
            ],),
          ),
          fileInfoData: FileInfoData(title: "xxxx.pdf", subTitle: "2023-10-10 10:10:10", file: "PDF"),
        );
      },
    );
  }

  // 构建证据项
  Widget _buildEvidenceItem(EvidenceItem item) {
    return CustomCard(
      margin: EdgeInsets.only(bottom: Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 取证时间和操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "取证时间：${item.time}",
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryTextColor,
                ),
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      AppRouter.pushNamed(AppRoutes.evidenceDetail);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.cardPadding, vertical: Spacing.buttonPaddingV),
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size(0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('存证', style: Theme.of(context).textTheme.bodySmall,),
                  ),
                  SizedBox(width: Spacing.sm),
                  Builder(
                    builder: (context) {
                      return OutlinedButton(
                        onPressed: () async {
                          print("按压");
                          final result = await showCustomPopupMenu(
                            triggerContext: context,
                            menuShowCount: 4,
                            menuWidth: 150.w,
                            options: [
                              PopupOption(key: 'opt1', label: '添加至案件'),
                              PopupOption(key: 'opt2', label: '转义证据'),
                              PopupOption(key: 'opt3', label: '修改备注'),
                              PopupOption(key: 'opt4', label: '删除'),
                            ]
                          );
                          if (result != null) {
                            if (result == 'opt1' || result == 'opt4') {
                              AppRouter.pushNamed(AppRoutes.evidenceBatch);
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: Spacing.cardPadding, vertical: Spacing.buttonPaddingV),
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size(0, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text('删除', style: Theme.of(context).textTheme.bodySmall,),
                      );
                    }
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: Spacing.md),
          
          // 证据内容
          Row(
            children: [
              // 状态标签
              InkWell(
                onTap: ()  {
                  final imageUrls = [
                    'https://picsum.photos/800/600?random=1',
                    'https://picsum.photos/800/600?random=2',
                    'https://picsum.photos/800/600?random=3',
                    'https://picsum.photos/800/600?random=4',
                    'https://picsum.photos/800/600?random=5',
                  ];
                  
                  final titles = [
                    '美丽的风景 1',
                    '美丽的风景 2', 
                    '美丽的风景 3',
                    '美丽的风景 4',
                    '美丽的风景 5',
                  ];
                  
                  final descriptions = [
                    '第一张示例图片，展示美丽的自然风光',
                    '第二张示例图片，色彩丰富',
                    '第三张示例图片，构图优美',
                    '第四张示例图片，光影效果佳',
                    '第五张示例图片，意境深远',
                  ];
                  
                  // 使用便捷的图片画廊方法
                  MediaPreviewUtils.showImageGallery(
                    context,
                    imageUrls,
                    titles: titles,
                    descriptions: descriptions,
                    initialIndex: 1, // 从第二张开始
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "网站",
                        style: TextStyle(
                          fontSize: 10,
                          color: tagDangerColor,
                        ),
                      ),
                      Text(
                        "点击查看",
                        style: TextStyle(
                          fontSize: 8,
                          color: tagDangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(width: Spacing.md),
              
              // 证据信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Spacing.xs),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              // 编辑图标
              Icon(
                Icons.edit_outlined,
                color: primaryColor,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 构建操作按钮
  Widget _buildActionButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.xs,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(Spacing.radiusSm),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: secondaryTextColor,
          ),
        ),
      ),
    );
  }

  // 构建未存证据
  Widget _buildNotStoredEvidence(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: Spacing.md),
          color: surfaceColor,
          child: Column(children: _buildTagRows(),),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: Spacing.pageHorizontal, right: Spacing.pageHorizontal, top: Spacing.buttonPaddingV, bottom: 0),
            child: _buildEvidenceList(),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}

// 证据项数据类
class EvidenceItem {
  final String title;
  final String subtitle;
  final String time;
  final String status;

  EvidenceItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.status,
  });
}