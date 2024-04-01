import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/widgets/schedule_message.dart';

class ScheduleInviteTicket extends StatelessWidget {
  const ScheduleInviteTicket({
    super.key,
    required this.message,
    required this.userId1,
    required this.userId2,
    this.onCancelMeeting,
  });
  final String userId1;
  final String userId2;

  final Message message;

  final VoidCallback? onCancelMeeting;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final alignment = (message.senderUserId != userId1)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = (message.senderUserId == userId1)
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    final colorBtn = (message.senderUserId == userId1)
        ? const Color(0xffB0C5A4)
        : const Color(0xffEBC49F);

    final textColor = (message.senderUserId == userId1)
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.75),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: const Column(
          children: [
            ScheduleMessageItem()

            // Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Expanded(
            //         child: Text(
            //           message.title ?? '',
            //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //                 color: textColor,
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: MediaQuery.of(context).size.width * 0.04, //
            //               ),
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ),
            //       const Gap(8),
            //       Text(
            //         '${message.endTime?.difference(message.startTime!).inMinutes} mins',
            //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //               color: textColor.withOpacity(0.8),
            //               fontSize: MediaQuery.of(context).size.width * 0.04, //
            //             ),
            //       ),
            //     ],
            //   ),
            //   const Gap(4),
            //   Row(
            //     children: [
            //       Text(
            //         'Start Time: ',
            //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //               fontWeight: FontWeight.bold,
            //               color: textColor,
            //               fontSize: MediaQuery.of(context).size.width * 0.04, //
            //             ),
            //       ),
            //       Text(
            //         '${DateFormat.yMMMd().format(message.startTime!)}, ${message.startTime!.hour}:${message.startTime!.minute.toString().padLeft(2, '0')}',
            //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //               color: textColor,
            //               fontSize: MediaQuery.of(context).size.width * 0.04, //
            //             ),
            //       ),
            //     ],
            //   ),
            //   const Gap(4),
            //   Row(
            //     children: [
            //       Text(
            //         'End Time:   ',
            //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //               fontWeight: FontWeight.bold,
            //               color: textColor,
            //               fontSize: MediaQuery.of(context).size.width * 0.04, //
            //             ),
            //       ),
            //       Text(
            //         '${DateFormat.yMMMd().format(message.endTime!)}, ${message.endTime!.hour}:${message.endTime!.minute.toString().padLeft(2, '0')}',
            //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //               color: textColor,
            //               fontSize: MediaQuery.of(context).size.width * 0.04, //
            //             ),
            //       ),
            //     ],
            //   ),
            //   const Gap(8),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       if (!message.canceled)
            //         ElevatedButton(
            //           onPressed: () {
            //             // Navigator.pushNamed(context, AppRouterName.videoCall);
            //           },
            //           style: ElevatedButton.styleFrom(
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(10),
            //               ),
            //               backgroundColor: kWhiteColor,
            //               minimumSize: Size.zero,
            //               foregroundColor: kBlue700),
            //           child: const Padding(
            //             padding:
            //                 EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            //             child: Text('Join'),
            //           ),
            //         ),
            //       const Gap(8),
            //       if (!message.canceled && message.senderUserId == userId2)
            //         PopupMenuButton<String>(
            //           icon: const Icon(
            //             Icons.pending_outlined,
            //             color: Colors.white,
            //           ),
            //           iconSize: 26,
            //           offset: const Offset(0, -140),
            //           color: Theme.of(context).colorScheme.secondaryContainer,
            //           itemBuilder: (BuildContext context) =>
            //               <PopupMenuEntry<String>>[
            //             PopupMenuItem<String>(
            //               value: 'Re-Schedule the meeting',
            //               height: 60,
            //               onTap: () async {},
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.calendar_month,
            //                     color: Theme.of(context)
            //                         .colorScheme
            //                         .primary
            //                         .withOpacity(Theme.of(context).brightness ==
            //                                 Brightness.dark
            //                             ? 1
            //                             : .7),
            //                   ),
            //                   const Gap(16),
            //                   Text(
            //                     'Re-Schedule the meeting',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .labelMedium
            //                         ?.copyWith(fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             PopupMenuItem<String>(
            //               value: 'Cancel the meeting', // Giá trị cho mục "Cancel"
            //               height: 60,
            //               onTap: () {
            //                 // Xử lý khi chọn "Cancel"
            //                 onCancelMeeting!();
            //               },
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.cancel,
            //                     color: Theme.of(context)
            //                         .colorScheme
            //                         .primary
            //                         .withOpacity(Theme.of(context).brightness ==
            //                                 Brightness.dark
            //                             ? 1
            //                             : .7),
            //                   ),
            //                   const Gap(16),
            //                   Text(
            //                     'Cancel the meeting',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .labelMedium
            //                         ?.copyWith(
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       if (message.canceled)
            //         Text(
            //           'The meeting has been canceled',
            //           style: TextStyle(
            //             color: Colors.red,
            //             fontWeight: FontWeight.bold,
            //             fontSize: MediaQuery.of(context).size.width *
            //                 0.04, // Điều chỉnh kích thước văn bản dựa trên chiều rộng của màn hình
            //           ),
            //         )
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}
