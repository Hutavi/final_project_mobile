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
            // CircleContainer(
            //   color: primary_300.withOpacity(0.3),
            //   child: const Icon(Icons.calendar_month, color: primary_300),
            // ),
            const Gap(4),
            Text(
              'Schedule a video call interview',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(4),
            // const Divider(thickness: 1.5, color: primary_300),
            const Gap(8),
            const SingleChildScrollView(
              child: Column(
                children: [
                  // TextFieldTitle(
                  //   title: 'Title',
                  //   hintText: 'Catch up meeting',
                  //   controller: titleController,
                  // ),
                  Gap(30),
                  // const SelectDateTime(
                  //     titleDate: 'Start Date', titleTime: 'Start Time'),
                  // const Gap(30),
                  // const SelectDateTime(
                  //     titleDate: 'End Date', titleTime: 'End Time'),
                  // const Gap(20),
                  // const Divider(thickness: 1.5, color: primary_300),
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
                  colorButton: Colors.red,
                  colorText: Colors.grey,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Button(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Send Invite',
                  colorButton: Colors.red,
                  colorText: Colors.grey,
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
