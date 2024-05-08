import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/display_text.dart';

class MessageItem extends StatelessWidget {
  final dynamic data;
  final int idUser;
  const MessageItem({super.key, required this.data, required this.idUser});

  String formatDate(String date) {
    DateTime change = DateTime.parse(date);
    String day = change.day.toString().padLeft(2, '0');
    String month = change.month.toString().padLeft(2, '0');
    String year = change.year.toString();
    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;
    return InkWell(
      onTap: () {
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
                        style: textTheme.labelMedium!,
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
                            width: deviceSize.width * 0.6,
                            child: DisplayText(
                              text: data['content'],
                              style: textTheme.labelSmall!
                                  .copyWith(color: colorScheme.onSurface),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              DisplayText(
                text: formatDate(data['createdAt']),
                style: textTheme.labelSmall!
                    .copyWith(color: colorScheme.onSurface),
              ),
            ],
          )),
    );
  }
}
