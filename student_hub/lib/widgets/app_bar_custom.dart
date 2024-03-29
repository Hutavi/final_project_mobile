import 'package:flutter/material.dart';
import 'package:student_hub/screens/schedule_interview/schedule_interview.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarCustom({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey[200],
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'scheduleInterview') {
              // Hiển thị bottom sheet khi chọn "Schedule an interview"
              _showSearchBottomSheet(context);
            } else if (value == 'cancel') {
              // Không làm gì khi chọn "Cancel"
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'scheduleInterview',
                child: Text('Schedule an interview'),
              ),
              const PopupMenuItem(
                value: 'cancel',
                child: Text('Cancel'),
              ),
            ];
          },
        ),
      ],
      // actions: <Widget>[
      //   IconButton(
      //     icon: const Icon(Icons.person),
      //     onPressed: () {

      //       //  Navigator.pushNamed(context, AppRouterName.projectSaved);
      //     },
      //   ),
      // ],
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const ScheduleInterview();
      },
    );
  }
}
