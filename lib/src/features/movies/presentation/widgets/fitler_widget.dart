import 'package:flutter/material.dart';
import 'package:movieapp/src/constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterWidget extends StatefulWidget {
  final TextEditingController searchTerm;
  final String label;

  final List<String> items;
  final Function(String) onChanged;
  String? selectedItem;
  FilterWidget({
    Key? key,
    required this.searchTerm,
    required this.label,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  }) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late String selectedItemm;
  @override
  void initState() {
    super.initState();
    selectedItemm = widget.selectedItem ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style:
              TextStyle(color: secondaryTextColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 4.h,
        ),
        DropdownButton<String>(
          dropdownColor: dropdownAreaColor,
          borderRadius: BorderRadius.circular(10.r),
          focusColor: mainColor,
          style: TextStyle(color: mainColor),
          value: selectedItemm,
          items: widget.items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      color: mainColor,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: ((value) {
            setState(() {
              selectedItemm = value!;
            });

            widget.onChanged(value!);
          }),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30.sp,
          underline: const SizedBox(),
        ),
      ],
    );
  }
}
