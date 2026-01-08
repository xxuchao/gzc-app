import 'package:flutter/material.dart';
import 'package:gzc_app/core/theme/spacing.dart';

class SelectableChipGroup extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? initialValue;

  const SelectableChipGroup({
    super.key,
    required this.items,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<SelectableChipGroup> createState() => _SelectableChipGroupState();
}

class _SelectableChipGroupState extends State<SelectableChipGroup> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.md, // 水平间距
      children: widget.items.map((item) {
        return ChoiceChip(
          labelPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          showCheckmark: false,
          label: Text(
            item,
            style: TextStyle(
              color: _selectedValue == item ? Colors.white : Colors.black,
              fontWeight: _selectedValue == item ? FontWeight.bold : null,
            ),
          ),
          selected: _selectedValue == item,
          selectedColor: Colors.blue,
          onSelected: (bool selected) {
            if (selected) {
              setState(() {
                _selectedValue = item;
              });
              widget.onChanged(item);
            } else {
              // 可选：取消选中时设置为 null 或保持原值
              // 这里我们不取消，只允许单选
            }
          },
          backgroundColor: Colors.grey[200],
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
      }).toList(),
    );
  }
}