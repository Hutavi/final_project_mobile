import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class ProposalDetailStudentS1 extends StatefulWidget {
  final dynamic data;
  const ProposalDetailStudentS1({super.key, required this.data});

  @override
  State<ProposalDetailStudentS1> createState() =>
      _ProposalDetailStudentS1State();
}

class _ProposalDetailStudentS1State extends State<ProposalDetailStudentS1> {
  List<String> skillsetTags = [];
  List<dynamic> listEducation = [];
  List<Map<String, dynamic>> listLanguage = [];
  final List<String> dropdownTechStackOptions = [];
  final List<int> dropdownTechStackOptionsID = [];
  List<String> dropdownSkillSetOptions = [];
  List<Map<String, dynamic>> dropdownSkillSetOptionsData = [];
  List<Map<String, dynamic>> dropdownSkillSetOptionsDataRemove = [];

  @override
  void initState() {
    print(widget.data);
    super.initState();
    listEducation.addAll(widget.data['educations']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(title: "Student Hub"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              // // Welcome message
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 12.0),
              //   child: Text(
              //     LocaleData.edtProfileCompanyTitle.getString(context),
              //     style: const TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),

              // // Tell us about yourself
              // Text(
              //   LocaleData.welcomeLine2.getString(context),
              //   style:
              //       const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              // ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      LocaleData.techStack.getString(context),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
                ],
              ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    // border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).cardColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
                  child: Text(widget.data['techStack']['name']),
                ),
              ),
              // Skillset
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        LocaleData.skillSet.getString(context),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       color: Theme.of(context).cardColor),
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 10, top: 12, bottom: 12),
              //     child: Wrap(
              //       spacing: 8.0,
              //       runSpacing: 8.0,
              //       children: [
              //         for (var skill in (widget.data['']
              //                 .map<dynamic>(
              //                     (element) => element['name'].toString())
              //                 .toList() as List<dynamic>? ??
              //             []))
              //           Card(
              //             elevation: 2,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 12.0, vertical: 4),
              //               child: Text(
              //                 skill,
              //                 style: const TextStyle(fontSize: 13),
              //               ),
              //             ),
              //           ),
              //       ],
              //     ),
              //   ),
              // ),

              const SizedBox(height: 8),

              // Languages
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleData.language.getString(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height:
                    listLanguage.isNotEmpty && listLanguage.length * 120 > 120
                        ? 120
                        : null,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listLanguage.length,
                  itemBuilder: (context, index) {
                    final language = listLanguage[index];
                    return Card(
                      elevation: 2,
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${language['languageName']}: ${language['level']}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          LocaleData.education.getString(context),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height:
                    listEducation.isNotEmpty && listEducation.length * 100 > 100
                        ? 84
                        : null,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listEducation.length,
                  itemBuilder: (context, index) {
                    final education = listEducation[index];
                    return Card(
                      color: Theme.of(context).cardColor,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  education['schoolName'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              '${education['startYear']} - ${education['endYear']}',
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouterName.profileS2);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(LocaleData.continu.getString(context),
                style: const TextStyle(color: Colors.white)),
          ),
        ));
  }
}
