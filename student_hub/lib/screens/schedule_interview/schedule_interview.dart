import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/widgets/build_text_field.dart';
import 'package:student_hub/widgets/show_date_picker_time.dart';
import 'package:uuid/uuid.dart';

class ScheduleInterview extends StatefulWidget {
  final Function(Message) onSendMessage;

  const ScheduleInterview({super.key, required this.onSendMessage});

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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: MediaQuery.of(context).size.height * 0.6,
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10),
              child: const Text(
                "Schedule a video call interview",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: titleSchedule,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    // Xử lý thay đổi trong TextField ở đây
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter title',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(color: kBlue50),
                    ),
                  ),
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
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
            Row(
              children: [
                const Text(
                  'Duration: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                Text(
                  '${calculateDurationInMinutes()} minutes',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
              ],
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
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kWhiteColor,
                              foregroundColor: kRed),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Message newMessage = Message(
                              id: const Uuid().v4(),
                              chatRoomId: 'chatRoomId1',
                              senderUserId: 'userId2',
                              receiverUserId: 'userId1',
                              title: titleSchedule.text,
                              createdAt: DateTime.now()
                                  .add(const Duration(minutes: 60)),
                              startTime: DateTime.now(),
                              endTime: DateTime.now()
                                  .add(const Duration(minutes: 15)),
                              meeting: true,
                            );
                            print(newMessage);
                            // Gọi hàm callback để gửi tin nhắn mới
                            widget.onSendMessage(newMessage);
                            // Đóng modal
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kBlue600,
                              foregroundColor: kWhiteColor),
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
