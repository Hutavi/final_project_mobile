import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/search_provider.dart';
import 'package:student_hub/routers/route_name.dart';

class BottomSheetSearch extends ConsumerStatefulWidget {
  const BottomSheetSearch({super.key});

  @override
  ConsumerState<BottomSheetSearch> createState() => _BottomSheetSearchState();
}

class _BottomSheetSearchState extends ConsumerState<BottomSheetSearch> {
  TextEditingController projectSearchController = TextEditingController();

  void searchProject(String query) {
    // Tiếp tục xử lý tìm kiếm
  }

  void addToSearchHistory(String query, WidgetRef ref) {
    if (query.isNotEmpty) {
      ref.read(searchHistoryProvider.notifier).addToHistory(query);
      Navigator.pushNamed(context, AppRouterName.projectSearch,
          arguments: query);
      setState(() {
        projectSearchController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer(
      builder: (context, ref, _) {
        final searchHistory = ref.watch(searchHistoryProvider);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: screenHeight * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.cancel)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: projectSearchController,
                      cursorColor: kBlue700,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: LocaleData.searchProject.getString(context),
                        hintStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
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
                      onChanged: searchProject,
                      onSubmitted: (query) => addToSearchHistory(query, ref),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (searchHistory.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchHistory.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(searchHistory[index]),
                        onTap: () {
                          // Bạn có thể thực hiện tìm kiếm lại khi người dùng chọn từ khóa từ lịch sử
                          addToSearchHistory(searchHistory[index], ref);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
