import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class PostScreen4 extends ConsumerStatefulWidget {
  const PostScreen4({super.key});

  @override
  ConsumerState<PostScreen4> createState() => _PostScreen4State();
}

class _PostScreen4State extends ConsumerState<PostScreen4> {
  Future<int> getDataIdCompany() async {
    final dioPrivate = DioClient();

    final responseProject = await dioPrivate.request(
      '/auth/me',
      options: Options(
        method: 'GET',
      ),
    );

    final companyId = responseProject.data['result']['company']['id'];
    return companyId;
  }

  void postPoject() async {
    try {
      ref.watch(postProjectProvider).projectScopeFlag ??= 0;

      var requestData = json.encode({
        'companyId': ref.watch(postProjectProvider).companyId,
        'projectScopeFlag': ref.watch(postProjectProvider).projectScopeFlag,
        'title': ref.watch(postProjectProvider).title,
        'numberOfStudents': ref.watch(postProjectProvider).numberOfStudents,
        'description': ref.watch(postProjectProvider).description,
        'typeFlag': ref.watch(postProjectProvider).typeFlag,
      });
      print('Request data1: $requestData');
      final dioPrivate = DioClient();
      final response = await dioPrivate.request(
        '/project',
        data: requestData,
        options: Options(
          method: 'POST',
        ),
      );
      print('Request data2: $requestData');
      if (response.statusCode == 201) {
        print('Post project success');
      }
      if (response.statusCode == 400) {
        // if(requestData get companyId){
        if (response.data['projectScopeFlag'] == null) {
          print(
              'projectScopeFlag should not be empty, projectScopeFlag must be one of the following values: 0, 1, 2, 3');
        }
        if (response.data['numberOfStudents'] == null) {
          print(
              'numberOfStudents must be a number conforming to the specified constraints, numberOfStudents should not be empty');
        }
        if (response.data['description'] == null) {
          print(
              'description should not be empty, description must be a string');
        }
        if (response.data['typeFlag'] == "") {
          print('description should not be empty');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scopeProject = ref.watch(postProjectProvider).projectScopeFlag == 0
        ? LocaleData.oneToThreeMonths.getString(context)
        : LocaleData.threeToSixMonths.getString(context);
    // print('scope ${ref.watch(postProjectProvider).projectScopeFlag}');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const AppBarCustom(
        title: 'Student Hub',
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleData.reviewTitle.getString(context),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text("${ref.watch(postProjectProvider).title}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kBlue600)),
              const Divider(),
              Text(LocaleData.projectDescription.getString(context),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  )),
              const SizedBox(height: 5),
              Text("${ref.watch(postProjectProvider).description}",
                  style: const TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.w300,
                      color: kBlue600)),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Row(
                children: [
                  const Icon(Icons.alarm),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleData.projectScope.getString(context),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '$scopeProject',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Row(
                children: [
                  const Icon(Icons.people),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleData.studentRequired.getString(context),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• '
                        '${ref.watch(postProjectProvider).numberOfStudents}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() async {
                    var companyID = await getDataIdCompany();
                    ref
                        .read(postProjectProvider.notifier)
                        .setCompanyId(companyID);
                    postPoject();
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, AppRouterName.navigation);
                    ref.read(postProjectProvider).companyId = null;
                    ref.read(postProjectProvider).projectScopeFlag = null;
                    ref.read(postProjectProvider).title = null;
                    ref.read(postProjectProvider).numberOfStudents = null;
                    ref.read(postProjectProvider).description = null;
                    ref.read(postProjectProvider).typeFlag = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue400,
                  foregroundColor: kWhiteColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                child: Text(LocaleData.postJob.getString(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
