import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/models/project_models/filter_model.dart';

class FilterProvider extends StateNotifier<FilterModel> {
  FilterProvider() : super(FilterModel());

  void setFilter(FilterModel filterModel) {
    state = filterModel;
  }

  void setProjectScopeFlag(String projectScopeFlag) {
    state.projectScopeFlag = projectScopeFlag;
  }

  void setNumberOfStudents(String numberOfStudents) {
    state.numberOfStudents = numberOfStudents;
  }

  void setProposalsLessThan(String proposalsLessThan) {
    state.proposalsLessThan = proposalsLessThan;
  }
}

final filterProvider = StateNotifierProvider<FilterProvider, FilterModel>(
  (ref) => FilterProvider(),
);
// Path: final_project_mobile/student_hub/lib/screens/browser_page/project_search.dart