import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/bottom_sheet_filter.dart';
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
  String queryData = '';
  int? selectedLengthValue;
  int? amountStudentNeed;
  int? proposalsLessThan;

  @override
  void initState() {
    super.initState();
    queryData = widget.query;
    // print('Abc ${widget.query}');
    fetchData();
  }

  void applyFilters(int? selectedLengthValue, int? amountStudentNeed,
      int? proposalsLessThan) {
    setState(() {
      this.selectedLengthValue = selectedLengthValue;
      this.amountStudentNeed = amountStudentNeed;
      this.proposalsLessThan = proposalsLessThan;
    });

    // Gọi lại fetchData khi nhận được dữ liệu mới
    fetchData();
  }

  void fetchData() async {
    // print("Fetch dataa");
    try {
      final dioPulic = DioClient();

      Map<String, dynamic> queryParams = {
        'title': queryData,
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
      if (response.statusCode == 200) {
        final List<dynamic> parsed = response.data!['result'];
        List<ProjectForListModel> projects =
            parsed.map<ProjectForListModel>((item) {
          // print(item);
          return ProjectForListModel.fromJson(item);
        }).toList();

        setState(() {
          listProject = projects;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("Vinh test");
    // print(projectScopeFlag);
    // print(numberOfStudents);
    // print(proposalsLessThan);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        title: 'Project Search',
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
                      hintText: "Search for project",
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
                    onChanged: (value) {
                      setState(() {
                        queryData = value;
                      });
                      fetchData();
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _showSearchBottomSheet(context);
                  },
                  child: const Icon(
                    Icons.filter_list_sharp,
                  ),
                )
              ],
            ),
            Expanded(
              child: listProject.isEmpty
                  ? const Center(child: Text('Not found project'))
                  : ListView.builder(
                      itemCount: listProject.length,
                      itemBuilder: (context, index) {
                        final project = listProject[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRouterName.projectDetail,
                                arguments: project);
                          },
                          child: ProjectItem(
                            projectForListModel: project,
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

  void _showSearchBottomSheet(BuildContext context) {
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
}
