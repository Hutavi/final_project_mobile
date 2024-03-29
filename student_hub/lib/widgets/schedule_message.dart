import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_hub/constants/colors.dart';

class ScheduleMessageItem extends StatefulWidget {
  const ScheduleMessageItem({super.key});

  @override
  State<ScheduleMessageItem> createState() => _ScheduleMessageItemState();
}

class _ScheduleMessageItemState extends State<ScheduleMessageItem> {
  bool isMeetingCancelled = false;
  void _showOptionsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          child: AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Re-schedule the meeting'),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMeetingCancelled = true;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel the meeting',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Catch up meeting"),
            Text("60 minutes"),
          ],
        ),
        const Text("Start time: Thursday 13/3/2024 15:00"),
        const Text("Start time: Thursday 13/3/2024 16:00"),
        const SizedBox(
          height: 10,
        ),
        isMeetingCancelled
            ? const Text(
                'The meeting is cancelled',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: kWhiteColor,
                        minimumSize: Size.zero,
                        foregroundColor: kBlue700),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text('Join'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showOptionsModal(context);
                    },
                    child: const Icon(FontAwesomeIcons.circleInfo),
                  ),
                ],
              )
      ],
    );
  }
}
