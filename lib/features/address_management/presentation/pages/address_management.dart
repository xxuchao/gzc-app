import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gzc_app/core/constants/routes.dart';
import 'package:gzc_app/core/theme/colors.dart';
import 'package:gzc_app/core/theme/spacing.dart';
import 'package:gzc_app/core/widgets/checkradio.dart';
import 'package:gzc_app/core/widgets/custom_card.dart';

class AddressManagement extends StatefulWidget {
  const AddressManagement({super.key});
  @override
  AddressManagementState createState() => AddressManagementState();
}

class AddressManagementState extends State<AddressManagement> {
  int? defaultAddressIndex = -1; // 默认地址索引

  final List<Map<String, String>> addresses = [
    {
      "name": "彭于晏", 
      "phone": "18959265966",
      "address": "福建省厦门市湖里区悦华路豪利大厦2号楼601福建省厦门市湖里区悦华路豪利大厦2号楼601"
    },
    {
      "name": "彭于晏",
      "phone": "18959265966",
      "address": "福建省厦门市湖里区悦华路豪利大厦2号楼601"
    },
    {
      "name": "彭于晏",
      "phone": "18959265966",
      "address": "福建省厦门市路豪利大厦2号楼601"
    },
  ];

  void setDefaultAddress(int index) {
    setState(() {
      defaultAddressIndex = index;
    });
  }

  void deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('地址管理'),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.addAddress),
            icon: Icon(Icons.add),
          )
        ],
      ),
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.pageHorizontal, vertical: Spacing.pageTop),
        child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            return CustomCard(
              // margin: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: Spacing.cardGap),
              // color: surfaceColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(addresses[index]["name"]!, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),),
                          SizedBox(width: Spacing.xs,),
                          Text(addresses[index]["phone"]!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: secondaryTextColor),),
                        ],
                      ),
                      CircleCheckRadio(
                        label: "设为默认",
                        isSelected: defaultAddressIndex == index,
                        onTap: (){
                          setDefaultAddress(index);
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Spacing.listItemGap,),
                      Text(
                        addresses[index]["address"]!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: Spacing.listItemGap),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // TODO: 需要传入数据
                              context.push(AppRoutes.addAddress);
                            },
                            child: const Text(
                              '修改',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          SizedBox(width: Spacing.md,),
                          GestureDetector(
                            onTap: () {
                              deleteAddress(index);
                            },
                            child: const Text(
                              '删除',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
                // contentPadding: const EdgeInsets.all(16),
              ),
            );
          },
        ),
      ),
    );
  }
}