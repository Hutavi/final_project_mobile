import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/filter_provider.dart';
import 'package:student_hub/widgets/build_text_field.dart';

class BottomSheetFilter extends ConsumerStatefulWidget {
  final Function(int?, int?, int?) applyFilters;
  const BottomSheetFilter({super.key, required this.applyFilters});

  @override
  ConsumerState<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends ConsumerState<BottomSheetFilter> {
  TextEditingController projectSearchController = TextEditingController();
  TextEditingController amountStudentNeedController = TextEditingController();
  TextEditingController proposalsController = TextEditingController();
  String? _selectedLength;
  int? amountStudentNeed;
  int? proposalsLessThan;
  int? selectedLengthValue;

  int? _getLengthValue(String? length) {
    switch (length) {
      case "Less than one month":
        return 0;
      case "1 to 3 months":
        return 1;
      case "3 to 6 months":
        return 2;
      case "More than 6 months":
        return 3;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // print(ref.watch(filterProvider).projectScopeFlag);
    // print(ref.watch(filterProvider).numberOfStudents);
    // print(ref.watch(filterProvider).proposalsLessThan);

    if (ref.watch(filterProvider).projectScopeFlag != null) {
      _selectedLength = ref.watch(filterProvider).projectScopeFlag!;
    }

    if (ref.watch(filterProvider).numberOfStudents != null) {
      amountStudentNeedController.text =
          ref.watch(filterProvider).numberOfStudents!;
    }

    if (ref.watch(filterProvider).proposalsLessThan != null) {
      proposalsController.text = ref.watch(filterProvider).proposalsLessThan!;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: screenHeight * 0.8,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.cancel),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: kGrey0))),
              child: Text(
                LocaleData.filterByTitle.getString(context),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleData.projectLenght.getString(context),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                RadioListTile<String>(
                  title: Text(
                    LocaleData.lessThanOneMonth.getString(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                  value: "Less than one month",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                    if (_selectedLength != null) {
                      ref
                          .read(filterProvider.notifier)
                          .setProjectScopeFlag(_selectedLength!);
                    }
                  },
                  activeColor: kBlue800,
                ),
                RadioListTile<String>(
                  title: Text(
                    LocaleData.oneToThreeMonth.getString(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                  value: "1 to 3 months",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                    if (_selectedLength != null) {
                      ref
                          .read(filterProvider.notifier)
                          .setProjectScopeFlag(_selectedLength!);
                    }
                  },
                  activeColor: kBlue800,
                ),
                RadioListTile<String>(
                  title: Text(
                    LocaleData.threeToSixMonth.getString(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                  value: "3 to 6 months",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                    if (_selectedLength != null) {
                      ref
                          .read(filterProvider.notifier)
                          .setProjectScopeFlag(_selectedLength!);
                    }
                  },
                  activeColor: kBlue800,
                ),
                RadioListTile<String>(
                  title: Text(
                    LocaleData.moreThanSixMonth.getString(context),
                    style: const TextStyle(fontSize: 16),
                  ),
                  value: "More than 6 months",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                    if (_selectedLength != null) {
                      ref
                          .read(filterProvider.notifier)
                          .setProjectScopeFlag(_selectedLength!);
                    }
                  },
                  activeColor: kBlue800,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleData.studentNeeded.getString(context),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextField(
                  controller: amountStudentNeedController,
                  inputType: TextInputType.number,
                  onChange: (value) {
                    amountStudentNeedController.text = value;
                    ref
                        .read(filterProvider.notifier)
                        .setNumberOfStudents(amountStudentNeedController.text);
                  },
                  fillColor: Theme.of(context).cardColor,
                  hint: LocaleData.studentNeededPlaholder.getString(context),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleData.proposalsLessThan.getString(context),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextField(
                  controller: proposalsController,
                  inputType: TextInputType.number,
                  onChange: (value) {
                    proposalsController.text = value;
                    ref
                        .read(filterProvider.notifier)
                        .setProposalsLessThan(proposalsController.text);
                  },
                  fillColor: Theme.of(context).cardColor,
                  hint: LocaleData.proposalLessThanPlaholder.getString(context),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedLength = null;
                              amountStudentNeedController.clear();
                              proposalsController.clear();
                            });

                            ref
                                .read(filterProvider.notifier)
                                .setProjectScopeFlag('');
                            ref
                                .read(filterProvider.notifier)
                                .setNumberOfStudents(
                                    amountStudentNeedController.text);
                            ref
                                .read(filterProvider.notifier)
                                .setProposalsLessThan(proposalsController.text);

                            selectedLengthValue =
                                _getLengthValue(_selectedLength);
                            amountStudentNeed =
                                int.tryParse(amountStudentNeedController.text);
                            proposalsLessThan =
                                int.tryParse(proposalsController.text);

                            widget.applyFilters(selectedLengthValue,
                                amountStudentNeed, proposalsLessThan);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kWhiteColor,
                              foregroundColor: kBlueGray600),
                          child:
                              Text(LocaleData.clearFilter.getString(context)),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            selectedLengthValue =
                                _getLengthValue(_selectedLength);
                            amountStudentNeed =
                                int.tryParse(amountStudentNeedController.text);
                            proposalsLessThan =
                                int.tryParse(proposalsController.text);

                            widget.applyFilters(selectedLengthValue,
                                amountStudentNeed, proposalsLessThan);

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kBlue50,
                              foregroundColor: kBlueGray600),
                          child:
                              Text(LocaleData.applyFilter.getString(context)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
