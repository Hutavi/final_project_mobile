import 'package:flutter/material.dart';
import 'package:student_hub/widgets/button.dart';
// import 'package:student_hub/widgets/circle_container.dart';
import 'package:gap/gap.dart';
// import 'package:student_hub/widgets/select_date_time.dart';
// import 'package:student_hub/widgets/text_field_title.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({super.key});

  @override
  State<CreateMeeting> createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  final titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Gap(4),
            Text(
              'Schedule a video call interview',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(4),
            const Gap(8),
            const SingleChildScrollView(
              child: Column(
                children: [
                  Gap(30),
                  Gap(30),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  colorButton: Colors.blueAccent,
                  colorText: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Button(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Send Invite',
                  colorButton: Colors.blueAccent,
                  colorText: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
