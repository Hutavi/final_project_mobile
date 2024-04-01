import 'package:flutter/material.dart';
import 'package:student_hub/screens/chat/widgets/chat.widgets.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/search_field.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Student Hub"),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SearchBox(controller: _searchController),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return const MessageItem();
              }),
        )
      ]),
    );
  }
}
