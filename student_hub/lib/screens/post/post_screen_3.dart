import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class PostScreen3 extends ConsumerStatefulWidget {
  const PostScreen3({super.key});

  @override
  ConsumerState<PostScreen3> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen3> {
  final descriptionController = TextEditingController();
  bool _descriptionPost = false;

  @override
  Widget build(BuildContext context) {
    if (ref.watch(postProjectProvider).description != null) {
      descriptionController.text = ref.watch(postProjectProvider).description!;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const AppBarCustom(
        title: 'Student Hub',
      ),
      body: Container(
        child: Padding(
          // padding: EdgeInsets.all(16),
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 20.0, bottom: 0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleData.postingDescriptionTitle.getString(context),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  LocaleData.postingDescriptionDescribeItem.getString(context)
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Icon(Icons.circle, size: 5),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Expanded(
                            child: Text(
                              LocaleData.postingDescriptionLine1.getString(context),
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 14), // Đặt kích thước chữ là 14
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Icon(Icons.circle, size: 5),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Expanded(
                            child: Text(
                              LocaleData.postingDescriptionLine2.getString(context),
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 14), // Đặt kích thước chữ là 14
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Icon(Icons.circle, size: 5),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02),
                          Expanded(
                            child: Text(
                              LocaleData.postingDescriptionLine3.getString(context),
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 14), // Đặt kích thước chữ là 14
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  style: const TextStyle(
                    color: kGrey0
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: kWhiteColor,
                      hintText: LocaleData.projectDescription.getString(context),
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: kGrey0,
                      ),
                      
                      enabledBorder: const OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                          bottom: Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                              bottom:Radius.circular(10.0)
                          )
                      )
                  ),
                  onChanged: (value) {
                  ref.read(postProjectProvider.notifier).setProjectDescription(value);
                  setState(() {
                    _descriptionPost = value.isNotEmpty;
                  });
                },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height < 600
                      ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                      : 16,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouterName.postScreen4);
                    },
                    style: ElevatedButton.styleFrom(
                      // Adjust minimum size based on screen size
                      minimumSize: MediaQuery.of(context).size.width < 300
                          ? const Size(200,
                              40) // Adjust width and height for smaller screens
                          : null,
                      // Adjust padding based on screen size (optional)
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width < 300
                            ? 10.0
                            : 16.0, // Adjust padding for smaller screens
                        vertical: 8.0,
                      ),
                      backgroundColor: kBlue400,
                      foregroundColor: kWhiteColor,
                    ),
                    child: Text(LocaleData.reviewYourPost.getString(context)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}