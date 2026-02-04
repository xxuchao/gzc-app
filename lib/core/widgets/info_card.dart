// 证据，案件，申办信息卡片

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gzc_app/core/theme/colors.dart' show primaryColor;
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/utils/clipboard_utils.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';
import 'package:gzc_app/core/widgets/media_preview.dart';

class InfoButton extends StatelessWidget {
  final String text;
  final void Function(BuildContext context) onpressed;
  const InfoButton({
    super.key,
    required this.text,
    required this.onpressed
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onpressed(context),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: Spacing.cardPadding, vertical: Spacing.buttonPaddingV),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size(0, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall,),
    );
  }
}


class InfoCard extends StatefulWidget {
  final TitleData? titleData;
  final ContentData? contentData;
  final FileInfoData? fileInfoData;
  const InfoCard({
    super.key,
    this.titleData,
    this.contentData,
    this.fileInfoData,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}


class _InfoCardState extends State<InfoCard> {
  late bool _checked;
  final checkSize = 20.w;
  final previewSize = 48.w;

  @override
  void initState() {
    super.initState();
    _checked = widget.titleData!.checked;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.titleData != null) _buildTitleArea(),
      if (widget.contentData != null) _buildContentArea(),
      if (widget.fileInfoData != null) _buildFileInfoArea(),
    ],),);
  }

  Widget _buildTitleArea(){
    Widget titleTextWidget;
    Widget? operateWidget;
    if (widget.titleData?.copyText == null) {
      titleTextWidget = Text(
        widget.titleData!.title,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }else {
      titleTextWidget = GestureDetector(
        onTap: (){
          ClipboardUtils.copyText(
            widget.titleData!.copyText!,
            context: context,
          );
        },
        child: Text(
          widget.titleData!.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    switch (widget.titleData!.operateType) {
      case TitleOperateType.text:
        operateWidget = Text(widget.titleData!.operateText!, style: Theme.of(context).textTheme.bodySmall);
        break;
      case TitleOperateType.textButton:
        operateWidget = GestureDetector(
          onTap: () => widget.titleData!.onpressed!(context),
          child: Text(widget.titleData!.operateText!, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: primaryColor)),
        );
        break;
      case TitleOperateType.checkbox:
        operateWidget = SizedBox(
          width: checkSize,
          height: checkSize,
          child: Transform.scale(
            scale: 0.85,
            child: Checkbox(
              value: _checked,
              // activeColor: Colors.amberAccent,
              checkColor: Colors.white,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (checked){
                setState(() {
                  _checked = checked!;
                });
                widget.titleData!.onChecked!(_checked);
              }
            ),
          ),
        );
        break;
      case TitleOperateType.button:
        operateWidget = Builder(
          builder: (context) {
            return InfoButton(text: widget.titleData!.operateText!, onpressed: widget.titleData!.onpressed!,);
          }
        );
        break;
      case TitleOperateType.infoType:
        operateWidget = Container(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smx),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacing.radiusLg),
            border: BoxBorder.all(color: Colors.black)
          ),
          child: Text(widget.titleData!.operateText!, style: Theme.of(context).textTheme.bodySmall!),
        );
        break;
      case TitleOperateType.widget:
        operateWidget = widget.titleData!.operateWidget!;
        break;
      default:
        operateWidget = null;
        break;
    }

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      titleTextWidget,
      if (operateWidget != null) operateWidget
    ],);
  }

  Widget _buildContentArea(){
    Widget? previewsWidget;
    Widget titleWidget;
    Widget subWidget;
    Widget? createWidget; // = Text(widget.contentData!.createTime!, style: Theme.of(context).textTheme.bodySmall);
    Widget? multiWidget;
    if (widget.contentData!.previews != null) {
      previewsWidget = GestureDetector(
        onTap: (){
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
          margin: EdgeInsets.only(right: Spacing.smx),
          width: previewSize,
          height: previewSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text("查看"),
        ),
      );
    }

    if (widget.contentData?.editTitle == null) {
      titleWidget = Text(widget.contentData!.title);
    }else {
      titleWidget = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(widget.contentData!.title),
        GestureDetector(
          onTap: (){},
          child: Icon(Icons.edit_note, size: Spacing.iconMd,),
        )
      ],);
    }

    if (widget.contentData?.subStatus != null) {
      subWidget = Row(children: [
        Text(widget.contentData!.subtitle, style: Theme.of(context).textTheme.bodySmall),
        SizedBox(width: Spacing.md,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smx),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacing.radiusLg),
            color: Colors.amber
          ),
          child: Text(widget.contentData!.subStatusText!, style: Theme.of(context).textTheme.bodySmall),
        )
      ],);
    }else if (widget.contentData?.subTime != null) {
      subWidget = Row(children: [
        Text(widget.contentData!.subtitle, style: Theme.of(context).textTheme.bodySmall),
        SizedBox(width: Spacing.md,),
        Text(widget.contentData!.subTime!, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey[500]!)),
      ],);
    }else {
      subWidget = Text(widget.contentData!.subtitle, style: Theme.of(context).textTheme.bodySmall);
    }

    if (widget.contentData?.multiInfo != null) {
      if (widget.contentData?.operate == null) {
        multiWidget = Text(widget.contentData!.multiInfo!, style: Theme.of(context).textTheme.bodySmall);
      }else {
        multiWidget = Row(children: [
          Text(widget.contentData!.multiInfo!, style: Theme.of(context).textTheme.bodySmall),
          Spacer(),
          widget.contentData!.operate!
        ],);
      }
    }

    if (widget.contentData?.createTime != null) {
      if (multiWidget != null) {
        createWidget = Text(widget.contentData!.createTime!, style: Theme.of(context).textTheme.bodySmall);
      }else {
        if (widget.contentData?.operate == null) {
          createWidget = Text(widget.contentData!.createTime!, style: Theme.of(context).textTheme.bodySmall);
        }else {
          createWidget = Row(children: [
            Text(widget.contentData!.createTime!, style: Theme.of(context).textTheme.bodySmall),
            Spacer(),
            if (widget.contentData?.operate != null) widget.contentData!.operate!
          ],);
        }
      }
    }

    return Container(
      margin: EdgeInsets.only(top: Spacing.listItemGap),
      padding: EdgeInsets.only(top: Spacing.listItemGap),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!)
        )
      ),
      // color: Colors.amber,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        if (previewsWidget != null) previewsWidget,
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          titleWidget,
          SizedBox(height: Spacing.verticalGapXS,),
          subWidget,
          if (createWidget != null) ...[if(widget.contentData?.operate == null || multiWidget != null) SizedBox(height: Spacing.verticalGapXS,), createWidget],
          if (multiWidget != null) ...[if(widget.contentData?.operate == null) SizedBox(height: Spacing.verticalGapXS,), multiWidget],
        ],),)
      ],),
    );
  }

  Widget _buildFileInfoArea(){
    return Container(
      margin: EdgeInsets.only(top: Spacing.listItemGap),
      padding: EdgeInsets.only(top: Spacing.listItemGap),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!)
        )
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(right: Spacing.smx),
          width: previewSize,
          height: previewSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text("PDF"),
        ),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.fileInfoData!.title),
            SizedBox(height: Spacing.verticalGapXS,),
            Text(widget.fileInfoData!.subTitle),
          ],),
        ),
        Text("下载")
      ],),
    );
  }
}


enum TitleOperateType {
  checkbox,
  textButton,
  none,
  button,
  text,
  infoType,
  widget
}

enum SubStatus {
  step_1,
  step_2,
  step_3,
  step_4,
}

class TitleData {
  final String title;
  final TitleOperateType operateType;
  final String? copyText;
  final String? operateText;
  final Widget? operateWidget;
  final bool checked;
  final void Function(BuildContext context)? onpressed;
  final void Function(bool?)? onChecked;
  TitleData({
    required this.title,
    required this.operateType,
    this.copyText,
    this.onpressed,
    this.operateText,
    this.operateWidget,
    this.checked = false,
    this.onChecked
  });
}

class ContentData {
  final List<String>? previews;
  final String title;
  final bool? editTitle;
  final String subtitle;
  final String? subTime;
  final SubStatus? subStatus;
  final String? subStatusText;
  final String? createTime;
  final String? multiInfo;
  final Widget? operate;
  ContentData({
    this.previews,
    required this.title,
    this.editTitle,
    required this.subtitle,
    this.subTime,
    this.createTime,
    this.subStatus,
    this.subStatusText,
    this.multiInfo,
    this.operate
  });
}

class FileInfoData {
  final String title;
  final String subTitle;
  final String file;
  FileInfoData({
    required this.title,
    required this.subTitle,
    required this.file,
  });
}

// class InfoCardData {
//   final String title;
//   final List<ContentData> contents;
//   InfoCardData({
//     required this.title,
//     required this.contents,
//   });
// }