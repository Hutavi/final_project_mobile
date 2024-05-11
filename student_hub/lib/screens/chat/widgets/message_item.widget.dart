import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/display_text.dart';

class MessageItem extends StatelessWidget {
  final dynamic data;
  final int idUser;
  final void Function(int) initSocket;
  const MessageItem(
      {super.key,
      required this.data,
      required this.idUser,
      required this.initSocket});

  String formatDate(String date) {
    DateTime change = DateTime.parse(date);
    String hour = change.hour.toString().padLeft(2, '0');
    String minute = change.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;

    String formatTimeAgo(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();
      Duration difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        if (difference.inDays == 1) {
          return '1 ${LocaleData.dayAgo.getString(context)}';
        } else {
          return '${difference.inDays} ${LocaleData.dayAgo.getString(context)}';
        }
      } else if (difference.inHours > 0) {
        if (difference.inHours == 1) {
          return '1 ${LocaleData.hoursAgo.getString(context)}';
        } else {
          return '${difference.inHours} ${LocaleData.hoursAgo.getString(context)}';
        }
      } else if (difference.inMinutes > 0) {
        if (difference.inMinutes == 1) {
          return '1 ${LocaleData.minutesAgo.getString(context)}';
        } else {
          return '${difference.inMinutes} ${LocaleData.minutesAgo.getString(context)}';
        }
      } else {
        if (difference.inSeconds == 1) {
          return '1 ${LocaleData.secondsAgo.getString(context)}';
        } else {
          return '${difference.inSeconds} ${LocaleData.secondsAgo.getString(context)}';
        }
      }
    }

    return InkWell(
      onTap: () {
        initSocket(data['project']['id']);
        Navigator.of(context).pushNamed(AppRouterName.chatScreen, arguments: {
          'idProject': data['project']['id'] as int,
          'idThisUser': idUser == data['receiver']['id']
              ? data['receiver']['id'] as int
              : data['sender']['id'] as int,
          'idAnyUser': idUser != data['receiver']['id']
              ? data['receiver']['id'] as int
              : data['sender']['id'] as int,
          'name': idUser != data['receiver']['id']
              ? data['receiver']['fullname'] as String
              : data['sender']['fullname'] as String,
        });
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(ImageManagent.imgAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DisplayText(
                        text: idUser != data['receiver']['id']
                            ? data['receiver']['fullname']
                            : data['sender']['fullname'],
                        style: textTheme.labelMedium!.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      DisplayText(
                          text: 'Senior frontend developer (Fintech)',
                          style: textTheme.labelSmall!.copyWith(
                            fontSize: 10,
                            color: Colors.green,
                          )),
                      const Gap(5),
                      Row(
                        children: [
                          SizedBox(
                            width: deviceSize.width * 0.5,
                            child: DisplayText(
                              text: '${data['content']}',
                              style: textTheme.labelSmall!.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              DisplayText(
                text: formatTimeAgo(data['createdAt']),
                style: textTheme.labelSmall!
                    .copyWith(color: colorScheme.onSurface),
              ),
            ],
          )),
    );
  }
}
