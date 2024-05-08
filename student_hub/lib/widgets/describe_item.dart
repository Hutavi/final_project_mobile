import 'package:flutter/material.dart';

class DescribeItem extends StatefulWidget {
  final String? itemDescribe;
  const DescribeItem({super.key, this.itemDescribe});

  @override
  State<DescribeItem> createState() => _DescribeItemState();
}

class _DescribeItemState extends State<DescribeItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
        ),
        const Text(
          '• ',
        ),
        Expanded(
          child: Text(
            widget.itemDescribe!,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}
