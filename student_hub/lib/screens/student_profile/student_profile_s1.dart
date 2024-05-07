import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/student_profile/widget/add_education_modal.dart';
import 'package:student_hub/screens/student_profile/widget/add_language_modal.dart';
import 'package:student_hub/screens/student_profile/widget/tags.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/custom_dialog.dart';
import 'package:student_hub/widgets/loading.dart';

class StudentProfileS1 extends StatefulWidget {
  const StudentProfileS1({super.key});

  @override
  State<StudentProfileS1> createState() => _StudentProfileS1State();
}

class _StudentProfileS1State extends State<StudentProfileS1> {
  String? _selectedValueTech;
  int? _selectedValueTechID;
  String? _selectedValue;
  List<String> skillsetTags = [];
  List<Map<String, dynamic>> listEducation = [];
  List<Map<String, dynamic>> listLanguage = [];
  final List<String> dropdownTechStackOptions = [];
  final List<int> dropdownTechStackOptionsID = [];
  List<String> dropdownSkillSetOptions = [];
  List<Map<String, dynamic>> dropdownSkillSetOptionsData = [];
  List<Map<String, dynamic>> dropdownSkillSetOptionsDataRemove = [];
  bool isTechStackChanged = false;
  bool isSkillSetChanged = false;

  var created = false;
  var idStudent = -1;
  var notify = '';
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    getDataDefault();
    getDataDropOption();
  }

  void getDataIdStudent() async {
    final dioPrivate = DioClient();

    final responseProfile = await dioPrivate.request(
      '/profile/student/$idStudent',
      options: Options(
        method: 'GET',
      ),
    );

    final profile = responseProfile.data['result'];

    setState(() {
      final techStack = profile['techStack'];
      final skillSet = profile['skillSets'];
      final educations = profile['educations'];
      final languages = profile['languages'];

      setState(() {
        if (techStack != null && dropdownTechStackOptions.isNotEmpty) {
          _selectedValueTech = techStack['name'];
          _selectedValueTechID = techStack['id'];

          for (var item in skillSet) {
            skillsetTags.add(item['name'].toString());
          }
          List<Map<String, dynamic>> resultArrayData = [];
          for (var item in skillSet) {
            if (!dropdownSkillSetOptionsData
                .any((element) => element['name'] == item['name'])) {
              resultArrayData.add(item);
            }
          }
          for (var item in dropdownSkillSetOptionsData) {
            if (!skillSet.any((element) => element['name'] == item['name'])) {
              resultArrayData.add(item);
            }
          }

          List<String> resultArray = [];
          for (var item in skillSet) {
            if (!dropdownSkillSetOptions
                .any((element) => element == item['name'].toString())) {
              resultArray.add(item.toString());
            }
          }
          for (var item in dropdownSkillSetOptions) {
            if (!skillSet
                .any((element) => element['name'].toString() == item)) {
              resultArray.add(item);
            }
          }
          for (var item in skillSet) {
            dropdownSkillSetOptionsDataRemove
                .add({"id": item['id'], "name": item['name'].toString()});
          }

          dropdownSkillSetOptions = resultArray;
          dropdownSkillSetOptionsData = resultArrayData;

          for (var item in languages) {
            listLanguage.insert(0, {
              'id': item['id'],
              'languageName': item['languageName'].toString(),
              'level': item['level'].toString()
            });
          }
          for (var item in educations) {
            listEducation.add({
              'schoolName': item['schoolName'],
              'startYear': item['startYear'].toString(),
              'endYear': item['endYear'].toString()
            });
          }

          isLoading = false;
        }
      });
    });
  }

  void getDataDropOption() async {
    try {
      final dioPublic = DioClientWithoutToken();

      final responseTeckStack = await dioPublic.request(
        '/techstack/getAllTechStack',
        options: Options(method: 'GET'),
      );

      final responseSkillSet = await dioPublic.request(
        '/skillset/getAllSkillSet',
        options: Options(
          method: 'GET',
        ),
      );

      final listTechStack = responseTeckStack.data['result'];
      final listSkillSet = responseSkillSet.data['result'];

      setState(() {
        for (var item in listTechStack) {
          dropdownTechStackOptions.add(item['name']);
          dropdownTechStackOptionsID.add(item['id']);
        }
        for (var item in listSkillSet) {
          dropdownSkillSetOptions.add(item['name']);
          dropdownSkillSetOptionsData
              .add({'id': item['id'], 'name': item['name']});
        }
      });
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  void getDataDefault() async {
    try {
      final dioPrivate = DioClient();

      final responseUser = await dioPrivate.request(
        '/auth/me',
        options: Options(
          method: 'GET',
        ),
      );

      final user = responseUser.data['result'];

      setState(() {
        if (user['student'] == null) {
          created = false;
        } else {
          created = true;
          final student = user['student'];
          idStudent = student['id'];
          getDataIdStudent();
        }
      });
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  void getIDStudent() async {
    try {
      final dioPrivate = DioClient();

      final responseUser = await dioPrivate.request(
        '/auth/me',
        options: Options(
          method: 'GET',
        ),
      );

      final user = responseUser.data['result'];

      setState(() {
        if (user['student'] == null) {
          created = false;
        } else {
          created = true;
          final student = user['student'];
          idStudent = student['id'];
        }
      });
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (context) => DialogCustom(
        title: "Success",
        description: notify,
        buttonText: 'OK',
        statusDialog: 1,
      ),
    );
  }

  void _showError() {
    showDialog(
      context: context,
      builder: (context) => DialogCustom(
        title: "Fail",
        description: notify,
        buttonText: 'OK',
        statusDialog: 1,
      ),
    );
  }

  void _handlePostProfile() async {
    List<int> skillSetId = dropdownSkillSetOptionsDataRemove
        .map<int>((element) => element['id'])
        .toList();
    final data = {"techStackId": _selectedValueTechID, "skillSets": skillSetId};
    if (created) {
      final dioPrivate = DioClient();
      final responseLanguage = await dioPrivate.request(
        '/profile/student/$idStudent',
        data: data,
        options: Options(method: 'PUT'),
      );

      if (responseLanguage.statusCode == 200) {
        setState(() {
          notify =
              '${LocaleData.updateProfile.getString(context)} ${LocaleData.success.getString(context)}';
          _showSuccess();
          isTechStackChanged = false;
          isSkillSetChanged = false;
        });
      } else {
        setState(() {
          notify =
              '${LocaleData.updateProfile.getString(context)} ${LocaleData.failed.getString(context)}';
          _showError();
        });
      }
    } else {
      final dioPrivate = DioClient();
      final responseLanguage = await dioPrivate.request(
        '/profile/student',
        data: data,
        options: Options(method: 'POST'),
      );

      if (responseLanguage.statusCode == 201) {
        setState(() {
          notify =
              '${LocaleData.createdProfile.getString(context)} ${LocaleData.success.getString(context)}';
          getIDStudent();
          _showSuccess();
          isTechStackChanged = false;
          isSkillSetChanged = false;
        });
      } else {
        setState(() {
          notify =
              '${LocaleData.createdProfile.getString(context)} ${LocaleData.failed.getString(context)}';
          _showError();
        });
      }
    }
  }

  void _onDropdownChangedTech(String? newValue) {
    setState(() {
      if (dropdownTechStackOptions.isNotEmpty && newValue != null) {
        _selectedValueTech = newValue;
        int index = dropdownTechStackOptions.indexOf(newValue);
        _selectedValueTechID = dropdownTechStackOptionsID[index];
        isTechStackChanged = true;
      } else {
        _selectedValueTech = null;
        isTechStackChanged = false;
      }
    });
  }

  void _onDropdownChanged(String? newValue) {
    setState(() {
      if (newValue != null) {
        skillsetTags.add(newValue);
        dropdownSkillSetOptions.remove(newValue);
        var foundElement = dropdownSkillSetOptionsData
            .firstWhere((element) => element['name'] == newValue);
        dropdownSkillSetOptionsDataRemove.add(foundElement);
        dropdownSkillSetOptionsData
            .removeWhere((element) => element['name'] == newValue);
        isSkillSetChanged = true;
      }
      _selectedValue = null;
    });
  }

  void _removeSkillsetTag(String skill) {
    setState(() {
      isSkillSetChanged = true;
      skillsetTags.remove(skill);
      var element = dropdownSkillSetOptionsDataRemove
          .firstWhere((element) => element['name'] == skill);
      dropdownSkillSetOptionsData.add(element);
      var elementName = dropdownSkillSetOptionsDataRemove
          .firstWhere((element) => element['name'] == skill)['name'];
      dropdownSkillSetOptions.add(elementName);
      dropdownSkillSetOptionsDataRemove
          .removeWhere((element) => element['name'] == skill);
    });
  }

  void _handleAcceptAddLanguage(
      String languageName, String languageLevel) async {
    List<Map<String, dynamic>> dataPost = [];

    dataPost.add({
      'languageName': languageName,
      'level': languageLevel,
    });

    for (var item in listLanguage) {
      dataPost.add(item);
    }

    final data = {'languages': dataPost};

    final dioPrivate = DioClient();
    final responseLanguage = await dioPrivate.request(
      '/language/updateByStudentId/$idStudent',
      data: data,
      options: Options(method: 'PUT'),
    );

    if (responseLanguage.statusCode == 200) {
      setState(() {
        notify =
            '${LocaleData.createdLanguage.getString(context)} ${LocaleData.success.getString(context)}';
        _showSuccess();
        listLanguage.insert(0, {
          'languageName': languageName,
          'level': languageLevel,
        });
      });
    } else {
      setState(() {
        notify =
            '${LocaleData.createdLanguage.getString(context)} ${LocaleData.failed.getString(context)}';
        _showError();
      });
    }
  }

  void _handleAcceptUpdateLanguage(
      String languageName, String languageLevel, int index) async {
    List<Map<String, dynamic>> dataPost = [];

    for (var item in listLanguage) {
      dataPost.add(item);
    }
    final updatedEducation = {
      'languageName': languageName,
      'level': languageLevel,
    };
    dataPost[index] = updatedEducation;

    final data = {'languages': dataPost};

    final dioPrivate = DioClient();
    final responseLanguage = await dioPrivate.request(
      '/language/updateByStudentId/$idStudent',
      data: data,
      options: Options(method: 'PUT'),
    );

    if (responseLanguage.statusCode == 200) {
      setState(() {
        notify =
            '${LocaleData.updatedLanguage.getString(context)} ${LocaleData.success.getString(context)}';

        _showSuccess();
        listLanguage[index] = updatedEducation;
      });
    } else {
      setState(() {
        notify =
            '${LocaleData.updatedLanguage.getString(context)} ${LocaleData.failed.getString(context)}';

        _showError();
      });
    }
  }

  void _showLanguageModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddLanguageModal(
          initialLanguageName: '',
          initialSelectedLanguageLevel: 'beginner',
          onAccept: _handleAcceptAddLanguage,
        );
      },
    );
  }

  void _updateLanguageModal(int index) {
    final languages = listLanguage[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddLanguageModal(
          initialLanguageName: languages['languageName'] ?? '',
          initialSelectedLanguageLevel: languages['level'] ?? 'beginner',
          onAccept: (name, level) {
            _handleAcceptUpdateLanguage(name, level, index);
          },
        );
      },
    );
  }

  void _handleAcceptAddEducation(String educationName,
      String educationStartYear, String educationEndYear) async {
    List<Map<String, dynamic>> dataPost = [];

    dataPost.add({
      'schoolName': educationName,
      'startYear': educationStartYear,
      'endYear': educationEndYear,
    });

    for (var item in listEducation) {
      dataPost.add(item);
    }

    final data = {'education': dataPost};
    final dioPrivate = DioClient();
    final responseEducation = await dioPrivate.request(
      '/education/updateByStudentId/$idStudent',
      data: data,
      options: Options(method: 'PUT'),
    );

    if (responseEducation.statusCode == 200) {
      setState(() {
        notify =
            '${LocaleData.createdEducation.getString(context)} ${LocaleData.success.getString(context)}';
        _showSuccess();
        listEducation.insert(0, {
          'schoolName': educationName,
          'startYear': educationStartYear,
          'endYear': educationEndYear,
        });
      });
    } else {
      setState(() {
        notify =
            '${LocaleData.createdEducation.getString(context)} ${LocaleData.failed.getString(context)}';
        _showError();
      });
    }
  }

  void _addEducationModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEducationModal(
          initialEducationName: '',
          initialSelectedEducationStartYear: '2000',
          initialSelectedEducationEndYear: '2024',
          onAccept: _handleAcceptAddEducation,
        );
      },
    );
  }

  void _handleAcceptUpdateEducation(String educationName,
      String educationStartYear, String educationEndYear, int index) async {
    List<Map<String, dynamic>> dataPost = [];

    for (var item in listEducation) {
      dataPost.add(item);
    }

    final updatedEducation = {
      'schoolName': educationName,
      'startYear': educationStartYear,
      'endYear': educationEndYear,
    };
    dataPost[index] = updatedEducation;

    final data = {'education': dataPost};
    final dioPrivate = DioClient();
    final responseEducation = await dioPrivate.request(
      '/education/updateByStudentId/$idStudent',
      data: data,
      options: Options(method: 'PUT'),
    );

    if (responseEducation.statusCode == 200) {
      setState(() {
        notify =
            '${LocaleData.updatedEducation.getString(context)} ${LocaleData.success.getString(context)}';
        _showSuccess();
        listEducation[index] = updatedEducation;
      });
    } else {
      setState(() {
        notify =
            '${LocaleData.updatedEducation.getString(context)} ${LocaleData.failed.getString(context)}';
        _showError();
      });
    }
  }

  void _updateEducationModal(int index) {
    final education = listEducation[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEducationModal(
          initialEducationName: education['schoolName'] ?? '',
          initialSelectedEducationStartYear: education['startYear'] ?? '',
          initialSelectedEducationEndYear: education['endYear'] ?? '',
          onAccept: (name, startYear, endYear) {
            _handleAcceptUpdateEducation(name, startYear, endYear, index);
          },
        );
      },
    );
  }

  void _removeLanguage(int index) async {
    List<Map<String, dynamic>> dataPost = [];

    for (var item in listLanguage) {
      dataPost.add(item);
    }
    dataPost.removeAt(index);

    final data = {'languages': dataPost};

    final dioPrivate = DioClient();
    final responseLanguage = await dioPrivate.request(
      '/language/updateByStudentId/$idStudent',
      data: data,
      options: Options(method: 'PUT'),
    );

    if (responseLanguage.statusCode == 200) {
      setState(() {
        notify =
            '${LocaleData.removeLanguage.getString(context)} ${LocaleData.success.getString(context)}';
        _showSuccess();
        listLanguage.removeAt(index);
      });
    } else {
      setState(() {
        notify =
            '${LocaleData.removeLanguage.getString(context)} ${LocaleData.failed.getString(context)}';
        _showError();
      });
    }
  }

  void _removeEducation(int index) async {
    List<Map<String, dynamic>> dataPost = [];

    for (var item in listEducation) {
      dataPost.add(item);
    }
    dataPost.removeAt(index);

    final data = {'education': dataPost};

    final dioPrivate = DioClient();
    final responseLanguage = await dioPrivate.request(
      '/education/updateByStudentId/$idStudent',
      data: data,
      options: Options(method: 'PUT'),
    );

    if (responseLanguage.statusCode == 200) {
      setState(() {
        notify =
            '${LocaleData.removeEducation.getString(context)} ${LocaleData.success.getString(context)}';
        _showSuccess();
        listEducation.removeAt(index);
      });
    } else {
      setState(() {
        notify =
            '${LocaleData.removeEducation.getString(context)} ${LocaleData.failed.getString(context)}';
        _showError();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(title: "Student Hub"),
        body: isLoading
            ? const LoadingWidget()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    // Welcome message
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        LocaleData.edtProfileCompanyTitle.getString(context),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Tell us about yourself
                    Text(
                      LocaleData.welcomeLine2.getString(context),
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          menuMaxHeight: 200,
                          value: _selectedValueTech,
                          hint: Text(
                              LocaleData.selectTechStack.getString(context),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey)),
                          items: dropdownTechStackOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 13),
                              ),
                            );
                          }).toList(),
                          onChanged: _onDropdownChangedTech,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 26,
                          underline: const SizedBox(),
                        ),
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          menuMaxHeight: 200,
                          hint: Text(
                              LocaleData.selectSkillSet.getString(context),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey)),
                          value: _selectedValue,
                          onChanged: _onDropdownChanged,
                          items: dropdownSkillSetOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 26,
                          underline: const SizedBox(),
                        ),
                      ),
                    ),

                    // Display selected skillset tags
                    SkillsetTagsDisplay(
                      skillsetTags: skillsetTags,
                      onRemoveSkillsetTag: _removeSkillsetTag,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: isTechStackChanged || isSkillSetChanged
                              ? _selectedValueTech!.isNotEmpty &&
                                      skillsetTags.isNotEmpty
                                  ? _handlePostProfile
                                  : null
                              : null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              isTechStackChanged || isSkillSetChanged
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(100, 36)),
                          ),
                          child: Text(
                            created
                                ? LocaleData.save.getString(context)
                                : LocaleData.create.getString(context),
                            style: TextStyle(
                              color: isTechStackChanged || isSkillSetChanged
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

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
                              Row(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: created ? _showLanguageModal : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: listLanguage.isNotEmpty &&
                              listLanguage.length * 120 > 120
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${language['languageName']}: ${language['level']}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              _updateLanguageModal(index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground
                                                        .withOpacity(0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(6),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 16,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0),
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              _removeLanguage(index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground
                                                        .withOpacity(0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(6),
                                              child: const Icon(
                                                Icons.delete,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
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
                              Row(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(50),
                                    onTap: created ? _addEducationModal : null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: listEducation.isNotEmpty &&
                              listEducation.length * 100 > 100
                          ? 84
                          : null,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listEducation.length,
                        itemBuilder: (context, index) {
                          final education = listEducation[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Card(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          education['schoolName'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              onTap: () {
                                                _updateEducationModal(index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onBackground
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 16,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              onTap: () {
                                                _removeEducation(index);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onBackground
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 4,
                                                      offset:
                                                          const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                          ],
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
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: !isLoading
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    created
                        ? Navigator.pushNamed(context, AppRouterName.profileS2)
                        : null;
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
              )
            : const SizedBox());
  }
}
