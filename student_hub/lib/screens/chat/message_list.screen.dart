import 'package:flutter/material.dart';
import 'package:student_hub/screens/chat/widgets/chat.widgets.dart';
import 'package:student_hub/widgets/search_field.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> originalList = [
    "Item 1",
    "Item 2",
    "Item 3",
  ];
  List<String> displayedList = [];

  @override
  void initState() {
    _searchController = TextEditingController();
    displayedList = originalList;
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void updateSearchResults(String query) {
    setState(() {
      if (query.isNotEmpty) {
        displayedList = originalList
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        displayedList = originalList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SearchBox(
                  controller: _searchController,
                  handleSearch: updateSearchResults),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedList.length,
                itemBuilder: (ctx, index) {
                  return MessageItem(
                    data: displayedList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
