import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/widgets/build_text_field.dart';
import 'package:student_hub/widgets/show_date_picker_time.dart';

class ScheduleInterview extends StatefulWidget {
  const ScheduleInterview({super.key});

  @override
  State<ScheduleInterview> createState() => _ScheduleInterviewState();
}

class _ScheduleInterviewState extends State<ScheduleInterview> {
  TextEditingController projectSearchController = TextEditingController();
  TextEditingController titleSchedule = TextEditingController();

  String? startDateTime;
  String? endDateTime;
  DateTime now = DateTime.now();
  late String currentTime;

  @override
  void initState() {
    currentTime = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String formatDateTimeString(String inputString) {
    DateTime dateTime = DateTime.parse(inputString);
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    return formattedDateTime;
  }

  DateTime parseDateTime(String dateTimeString) {
    String sanitizedDateTimeString = dateTimeString.trim();
    sanitizedDateTimeString = sanitizedDateTimeString.replaceAll(" ", " ");
    return DateFormat("M/d/yyyy h:mm a").parse(sanitizedDateTimeString);
  }

  // Tính toán duration giữa hai thời điểm và trả về số phút
  int calculateDurationInMinutes() {
    if (startDateTime != null && endDateTime != null) {
      // Chuyển đổi chuỗi ngày giờ thành đối tượng DateTime
      DateTime startTime = parseDateTime(startDateTime!);
      DateTime endTime = parseDateTime(endDateTime!);
      // Tính toán duration
      Duration duration = endTime.difference(startTime);
      return duration.inMinutes;
    } else {
      // Trả về 0 nếu một trong hai thời điểm không được chọn
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.cancel),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: kGrey0))),
              child: const Text(
                "Schedule a video call interview",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextField(
                  controller: titleSchedule,
                  inputType: TextInputType.text,
                  onChange: () {},
                  fillColor: kWhiteColor,
                  hint: "Enter title",
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Start time",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    DateTimePicker.show(context, (String? formattedDateTime) {
                      if (formattedDateTime != null) {
                        setState(() {
                          startDateTime = formattedDateTime;
                        });
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: kGrey1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            startDateTime != null && startDateTime!.isNotEmpty
                                ? startDateTime!
                                : "Select Date",
                            style: TextStyle(
                              color: startDateTime != null &&
                                      startDateTime!.isNotEmpty
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_month_rounded),
                          onPressed: () async {
                            DateTimePicker.show(context,
                                (String? formattedDateTime) {
                              if (formattedDateTime != null) {
                                setState(() {
                                  startDateTime = formattedDateTime;
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "End Time",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    DateTimePicker.show(context, (String? formattedDateTime) {
                      if (formattedDateTime != null) {
                        setState(() {
                          endDateTime = formattedDateTime;
                        });
                      }
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: kGrey1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            endDateTime != null && endDateTime!.isNotEmpty
                                ? endDateTime!
                                : "Select Date",
                            style: TextStyle(
                              color:
                                  endDateTime != null && endDateTime!.isNotEmpty
                                      ? Colors.black
                                      : Colors.grey,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_month_rounded),
                          onPressed: () async {
                            DateTimePicker.show(context,
                                (String? formattedDateTime) {
                              if (formattedDateTime != null) {
                                setState(() {
                                  endDateTime = formattedDateTime;
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Duration: ${calculateDurationInMinutes()} minutes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kWhiteColor,
                              foregroundColor: kBlueGray600),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kBlue50,
                              foregroundColor: kBlueGray600),
                          child: const Text('Send Invite'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
