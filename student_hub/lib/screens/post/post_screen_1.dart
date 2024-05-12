import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class PostScreen1 extends ConsumerStatefulWidget {
  const PostScreen1({Key? key}) : super(key: key);

  @override
  ConsumerState<PostScreen1> createState() => _PostScreen1State();
}

class _PostScreen1State extends ConsumerState<PostScreen1> {
  final titleController = TextEditingController();
  bool _titlePost = false;
  
  @override
  Widget build(BuildContext context) {
    if (ref.watch(postProjectProvider).title != null) {
      titleController.text = ref.watch(postProjectProvider).title!;
    }
    
    return ProviderScope(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const AppBarCustom(
          title: 'Student Hub'
          ),
        body: Container(
          // color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 18.0, right: 18.0, top: 36.0, bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  LocaleData.postingTitle.getString(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 14 * 2,
                ),
                Text(
                  LocaleData.postingDescribeItem.getString(context),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height < 600 ? 14 : 14 * 4,
                ),
                TextField(
                  controller: titleController,
                  cursorColor: Theme.of(context).colorScheme.background,
                  style: const TextStyle(
                    color: kGrey0,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kWhiteColor,
                    hintText: LocaleData.postingPlaceholder.getString(context),
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: kGrey0,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                            bottom: Radius.circular(10.0)))),
                  onChanged: (value) {
                    ref.read(postProjectProvider.notifier).setProjectTitle(value);
                    setState(() {
                      _titlePost = value.isNotEmpty;
                    });
                  },
                ),
                const SizedBox(
                  height: 14 * 4,
                ),
                Text(
                  LocaleData.postingExampleTitle.getString(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "• ${LocaleData.postingExample.getString(context)}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "• ${LocaleData.postingExample1.getString(context)}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14 * 4,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRouterName.postScreen2);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: _titlePost ? null : kWhiteColor,
                              backgroundColor: kBlue400,
                              
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ),
                            child: Text(
                              LocaleData.nextScope.getString(context),
                              // style:
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
}
