import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';


class CaseListScreen extends StatelessWidget {
  const CaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // 假设有两个案件
      itemBuilder: (context, index) {
        return _buildCaseItem(context);
      },
    );
  }

  Widget _buildCaseItem(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '案件编号：20250985000001123123123123',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              InkWell(
                child: Icon(Icons.edit_note_outlined, size: Spacing.iconMd, color: Color(0xFF379ae6),),
                onTap: (){
                  print("asdf");
                },
              )
            ],
          ),
          Divider(height: Spacing.pageTop, thickness: 0.5,),
          const Text(
            '案件名称案件名称案件案件名称',
          ),
          Text(
            '网购 | 网购',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '2025-09-05 16:16:53',
              ),
              Row(
                spacing: Spacing.xs,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.cardPadding, vertical: Spacing.buttonPaddingV),
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size(0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('查看详情', style: Theme.of(context).textTheme.bodySmall,),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.cardPadding, vertical: Spacing.buttonPaddingV),
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size(0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('更多', style: Theme.of(context).textTheme.bodySmall,),
                  ),
                ],
              ),
            ],
          ),
          Divider(height: Spacing.pageTop, thickness: 0.5,),
          // 附件信息
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 附件类型图标
              Container(
                padding: EdgeInsets.all(Spacing.md),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                ),
                child: const Text(
                  'PDF',
                ),
              ),
              SizedBox(width: Spacing.md),
              // 附件标题和时间
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '证据包名称+公证书.pdf',
                  ),
                  SizedBox(height: Spacing.verticalGapXS),
                  const Text(
                    '2025-09-05 16:16:53',
                  ),
                ],
              ),
              Spacer(),
              // 下载或过期按钮
              TextButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // minimumSize: Size(0, 0),
                ),
                child: const Text(
                  '下载',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}