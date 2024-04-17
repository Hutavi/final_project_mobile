import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  SearchHistoryNotifier() : super([]);

  void addToHistory(String search) {
    state.add(search);
    if (state.length > 6) {
      state.removeAt(0);
    }
  }
}

final searchHistoryProvider =
    StateNotifierProvider<SearchHistoryNotifier, List<String>>(
  (ref) => SearchHistoryNotifier(),
);
// Path: final_project_mobile/student_hub/lib/screens/browser_page/project_list.dart