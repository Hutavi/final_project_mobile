import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/switch_account_page/account_manager.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/bottom_sheet_search.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:student_hub/widgets/project_item.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  TextEditingController projectSearchController = TextEditingController();
  List<ProjectForListModel> listProject = [];
  var isLoading = true;
  int role = -1;

  //Pagination
  int page = 1;
  final scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    fecthData();
    getRole();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getRole() async {
    role = await RoleUser.getRole();
  }

  Future<void> fecthData() async {
    // Call API to get data
    try {
      final dioPulic = DioClient();

      final response = await dioPulic.request('/project',
          queryParameters: {'page': page, 'perPage': 10},
          options: Options(method: 'GET'));
      if (response.statusCode == 200) {
        final List<dynamic> parsed = response.data!['result'];
        List<ProjectForListModel> projects =
            parsed.map<ProjectForListModel>((item) {
          // print(item);
          return ProjectForListModel.fromJson(item);
        }).toList();

        setState(() {
          listProject = listProject + projects;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Brightness brightness = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: null,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: projectSearchController,
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          // fillColor: Theme.of(context).colorScheme.surface,
                          fillColor: kWhiteColor,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: kGrey0,
                          ),
                          hintText: LocaleData.searchProject.getString(context),
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: kGrey0,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 0, color: kBlue600),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 0, color: kGrey1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 1, color: kBlue600),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(width: 1, color: kGrey1)),
                        ),
                        // onChanged: searchProject,
                        onTap: () {
                          _showSearchBottomSheet(
                              context); // Call function to show BottomSheet
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    role == 1
                        ? const SizedBox(
                            height: 1,
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                      context, AppRouterName.projectSaved)
                                  .then((_) => {
                                        setState(() {
                                          fecthData();
                                        })
                                      });
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: kRed,
                            ),
                          )
                  ],
                ),
                isLoading
                    ? const Expanded(
                        child: Center(
                          child: LoadingWidget(),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: isLoadingMore
                              ? listProject.length + 1
                              : listProject.length,
                          itemBuilder: (context, index) {
                            if (index < listProject.length) {
                              final project = listProject[index];
                              // Chuyển đổi màu nền xen kẽ
                              final backgroundColor =
                                  index % 2 == 0 ? true : false;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouterName.projectDetail,
                                    arguments: project,
                                  );
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    children: [
                                      ProjectItem(
                                        isEven: backgroundColor,
                                        projectForListModel: listProject[index],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                child: LoadingWidget(),
                              );
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const BottomSheetSearch();
      },
    );
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page = page + 1;
      await fecthData();
      setState(() {
        isLoadingMore = false;
      });
      // print('Load more');
    }
  }
}
