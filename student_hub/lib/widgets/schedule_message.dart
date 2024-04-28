import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/build_text_field.dart';

class ScheduleMessageItem extends StatefulWidget {
  const ScheduleMessageItem({
    super.key,
  });

  @override
  State<ScheduleMessageItem> createState() => _ScheduleMessageItemState();
}

class _ScheduleMessageItemState extends State<ScheduleMessageItem> {
  bool isMeetingCancelled = false;
  late String conferencesID;
  final TextEditingController titleSchedule = TextEditingController();

  @override
  void initState() {
    super.initState();
    conferencesID = generateRandomNumber();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String generateRandomNumber() {
    // Tạo một số nguyên ngẫu nhiên từ 1000 đến 9999
    var random = Random();
    int randomNumber = random.nextInt(9000) + 1000;

    // Chuyển số nguyên ngẫu nhiên thành chuỗi và trả về
    return randomNumber.toString();
  }

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

  void _showEnterCodeRoomModal(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BuildTextField(
                  controller: titleSchedule,
                  inputType: TextInputType.text,
                  onChange: () {},
                  fillColor: kWhiteColor,
                  hint: "Enter code room",
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterName.meetingRoom,
                        arguments: conferencesID);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: kWhiteColor,
                      minimumSize: Size.zero,
                      foregroundColor: kBlue700),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text('Confirm'),
                  ),
                )
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
            Text(
              "Catch up meeting",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "60 minutes",
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Row(
          children: [
            Text(
              "Start time: ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Text(
              "Thursday, 13/3/2024 15:00",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        const Row(
          children: [
            Text(
              "End time: ",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            Text(
              "Thursday, 13/3/2024 16:00",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Code room: ",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Text(
              conferencesID,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.red),
            ),
          ],
        ),
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
                    onPressed: () {
                      _showEnterCodeRoomModal(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: kWhiteColor,
                        minimumSize: Size.zero,
                        foregroundColor: kBlue700),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                    child: const Icon(
                      Icons.pending_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
