import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_new.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:dio/dio.dart';

class PostScreen4 extends ConsumerStatefulWidget {
  const PostScreen4({super.key});

  @override
  ConsumerState<PostScreen4> createState() => _PostScreen4State();
}

class _PostScreen4State extends ConsumerState<PostScreen4> {
  void getDataIdCompany() async {
    final dioPrivate = DioClient();

    final responseProject = await dioPrivate.request(
      '/auth/me',
      options: Options(
        method: 'GET',
      ),
    );

    final companyId = responseProject.data['result']['company']['id'];
    print('Company id: $companyId');
    ref.read(postProjectProvider.notifier).setCompanyId(companyId);
    print(ref.watch(postProjectProvider).companyId);
  }
  
  void postPoject() async {
    var requestData = json.encode({
          'companyId': ref.watch(postProjectProvider).companyId,
          'projectScopeFlag': ref.watch(postProjectProvider).projectScopeFlag,
          'title': ref.watch(postProjectProvider).title,
          'numberOfStudents': ref.watch(postProjectProvider).numberOfStudents,
          'description': ref.watch(postProjectProvider).description,
          'typeFlag': ref.watch(postProjectProvider).typeFlag,
        });
    try{
      final dioPrivate = DioClient();
      final response = await dioPrivate.request(
        '/project',
        data: requestData,
        options: Options(
          method: 'POST',
        ),
      );
      if(response.statusCode == 201){
        ref.read(postProjectProvider.notifier).setStateModel();
        print('Post project success');
      }
    }catch(e){
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    
    final scopeProject = ref.watch(postProjectProvider).projectScopeFlag == 0
        ? '1 to 3 months'
        : '3 to 6 months';
    print('scope ${ref.watch(postProjectProvider).projectScopeFlag}');
    return Scaffold(
      appBar: const _AppBar(),
      body: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "4/4-Project details",
                style: TextStyle(fontWeight: FontWeight.bold),
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
                      color: Colors.black)),
              const Divider(),
              const Text(
                'Project description',
                style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ),
              const SizedBox(height: 5),
              Text("${ref.watch(postProjectProvider).description}",
                  style: const TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.w300,
                      color: Colors.black)),
              
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
                      const Text(
                        'Project scope',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '${scopeProject}',
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
                      const Text(
                        'Student required:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '${ref.watch(postProjectProvider).numberOfStudents}',
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
                  getDataIdCompany();
                  postPoject();
                  Navigator.pushNamed(context, AppRouterName.navigation);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue400,
                  foregroundColor: kWhiteColor,
                ),
                child: const Text('Post a job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.grey[200],
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('lib/assets/images/avatar.png'),
          ),
          onPressed: () {
            // tới profile);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
