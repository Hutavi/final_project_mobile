import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/models/project_models/project_model_new.dart';

class PostProjectNotifier extends StateNotifier<ProjectModelNew> {
  PostProjectNotifier() : super(ProjectModelNew());

  void setStateModel(ProjectModelNew projectModel) {
    state = projectModel;
  }

  void setProjectTitle(String title) {
    state.title = title;
  }

  void setProjectDescription(String description) {
    state.description = description;
  }

  void setProjectScopeFlag(int projectScopeFlag) {
    state.projectScopeFlag = projectScopeFlag;
  }

  void setNumberOfStudents(int numberOfStudents) {
    state.numberOfStudents = numberOfStudents;
  }

  void setTypeFlag(int typeFlag) {
    state.typeFlag = typeFlag;
  }

  void setCompanyId(int companyId) {
    state.companyId = companyId;
  }

  void setId(int id) {
    state.id = id;
  }
}

final postProjectProvider =
    StateNotifierProvider<PostProjectNotifier, ProjectModelNew>(
        (ref) => PostProjectNotifier());
// Path: lib/screens/post/post_screen_1.dart