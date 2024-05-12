import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/bottom_sheet_filter.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:student_hub/widgets/project_item.dart';

class ProjectSearch extends StatefulWidget {
  final String query;

  const ProjectSearch({super.key, required this.query});

  @override
  State<ProjectSearch> createState() => _ProjectSearchState();
}

class _ProjectSearchState extends State<ProjectSearch> {
  TextEditingController projectSearchController = TextEditingController();
  List<ProjectForListModel> listProject = [];
  // String queryData = '';
  int? selectedLengthValue;
  int? amountStudentNeed;
  int? proposalsLessThan;
  bool isLoading = true;

  //Pagination
  int page = 1;
  final scrollController = ScrollController();
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    projectSearchController.text = widget.query;
    scrollController.addListener(_scrollListener);
    fetchData();
  }

  void applyFilters(int? selectedLengthValue, int? amountStudentNeed,
      int? proposalsLessThan) {
    listProject.clear();
    setState(() {
      this.selectedLengthValue = selectedLengthValue;
      this.amountStudentNeed = amountStudentNeed;
      this.proposalsLessThan = proposalsLessThan;
    });
    // Gọi lại fetchData khi nhận được dữ liệu mới
    Future.microtask(() => fetchData());
  }

  Future<void> fetchData() async {
    try {
      final dioPulic = DioClient();

      Map<String, dynamic> queryParams = {
        'title': projectSearchController.text,
        'page': page,
        'perPage': 10,
      };

      // Kiểm tra và thêm các tham số truy vấn khác nếu chúng không phải là null
      if (selectedLengthValue != null) {
        queryParams['projectScopeFlag'] = selectedLengthValue;
      }
      if (amountStudentNeed != null) {
        queryParams['numberOfStudents'] = amountStudentNeed;
      }
      if (proposalsLessThan != null) {
        queryParams['proposalsLessThan'] = proposalsLessThan;
      }

      final response = await dioPulic.request(
        '/project',
        options: Options(method: 'GET'),
        queryParameters: queryParams,
      );
      print("Re fetch data");
      if (response.statusCode == 200) {
        final List<dynamic> parsed = response.data!['result'];
        List<ProjectForListModel> projects =
            parsed.map<ProjectForListModel>((item) {
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

  void searchProject(String query) {
    listProject.clear();
    setState(() {
      projectSearchController.text = query;
      isLoading = true;
    });
    // Gọi lại fetchData khi nhận được dữ liệu mới
    Future.microtask(() => fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBarCustom(
        title: LocaleData.searchProjectTitle.getString(context),
        showBackButton: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: projectSearchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: LocaleData.searchProject.getString(context),
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 1, color: kGrey1)),
                    ),
                    onTap: () {},
                    onSubmitted: (value) {
                      searchProject(value);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _showFilterBottomSheet(context);
                  },
                  child: const Icon(
                    Icons.filter_list_sharp,
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
                    child: listProject.isEmpty
                        ? Center(
                            child: Text(
                                LocaleData.notFoundProject.getString(context)))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: listProject.length,
                            itemBuilder: (context, index) {
                              final project = listProject[index];
                              final backgroundColor =
                                  index % 2 == 0 ? true : false;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRouterName.projectDetail,
                                      arguments: project);
                                },
                                child: Column(
                                  children: [
                                    ProjectItem(
                                      isEven: backgroundColor,
                                      projectForListModel: project,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
          ]),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return BottomSheetFilter(
          applyFilters: applyFilters,
        );
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
      await fetchData();
      setState(() {
        isLoadingMore = false;
      });
      // print('Load more');
    }
  }
}
