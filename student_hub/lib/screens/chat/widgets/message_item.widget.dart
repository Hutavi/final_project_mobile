import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/display_text.dart';

class MessageItem extends StatelessWidget {
  final dynamic data;
  const MessageItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouterName.chatScreen);
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
                        text: data.toString(),
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
                              text:
                                  'Clear expectation about your project or deliverables',
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
                text: '6/6/2024',
                style: textTheme.labelSmall!
                    .copyWith(color: colorScheme.onSurface),
              ),
            ],
          )),
    );
  }
}
