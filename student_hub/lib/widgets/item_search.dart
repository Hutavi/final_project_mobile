import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';

class ItemSearch extends StatefulWidget {
  final String titleSearch;
  const ItemSearch({super.key, required this.titleSearch});

  @override
  State<ItemSearch> createState() => _ItemSearchState();
}

class _ItemSearchState extends State<ItemSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: kWhiteColor,
        border: Border(
          top: BorderSide(
            color: kBlueGray200,
            width: 0.5,
          ),
        ),
      ),
      child: Row(children: [Text(widget.titleSearch)]),
    );
  }
}
