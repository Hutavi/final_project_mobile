import 'package:dio/dio.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/services/dio_client.dart';

class ProjectService extends DioClient {
  ProjectService() : super();

  get dio => null;
  Future<dynamic> getFavoriteProjects(int studentId) async {
    try {
      Response response = await dio.get(
        '/favoriteProject/$studentId',
      );
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch saved projects');
    }
  }

  Future<void> updateFavoriteProject(
      int studentId, int projectId, int disableFlag) async {
    try {
      await dio.patch(
        '/favoriteProject/$studentId',
        data: {
          'projectId': projectId,
          'disableFlag': disableFlag,
        },
      );
      // return response;
    } catch (e) {
      throw Exception('Failed to update favorite project');
    }
  }

  Future<List<ProjectForListModel>> getProjects(
      [Map<String, Object?>? params]) async {
    if (params != null) {
      params.removeWhere((key, value) => value == null || value == '');
    }
    print("object");
    try {
      final dio = DioClient();
      Response response = await dio.request(
        '/project',
        queryParameters: params,
        options: Options(method: 'GET'),
      );
      return response.data['result']
          .map<ProjectForListModel>((item) => ProjectForListModel.fromMap(item))
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      throw Exception('Failed to fetch projects');
    }
  }

  Future<dynamic> filterProject(Map<String, dynamic> queries) async {
    try {
      Response response = await dio.get(
        '/project',
        queryParameters: queries,
      );
      return response.data['result'];
    } catch (e) {
      throw Exception('Failed to fetch project');
    }
  }
}
