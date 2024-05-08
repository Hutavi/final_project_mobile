import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';

class AddLanguageModal extends StatefulWidget {
  final String initialLanguageName;
  final String initialSelectedLanguageLevel;
  final void Function(String languageName, String languageLevel) onAccept;

  const AddLanguageModal({
    Key? key,
    required this.initialLanguageName,
    required this.initialSelectedLanguageLevel,
    required this.onAccept,
  }) : super(key: key);

  @override
  AddLanguageModalState createState() => AddLanguageModalState();
}

class AddLanguageModalState extends State<AddLanguageModal> {
  late TextEditingController _languageNameController;
  late String _selectedLanguageLevel;
  var title = '';

  @override
  void initState() {
    super.initState();
    _languageNameController =
        TextEditingController(text: widget.initialLanguageName);
    _selectedLanguageLevel = widget.initialSelectedLanguageLevel;
    title = widget.initialLanguageName != '' ? 'update' : 'add';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      // backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(
        title == 'add'
            ? LocaleData.addLanguage.getString(context)
            : LocaleData.updateLanguage.getString(context),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: _languageNameController,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: LocaleData.hintLanguageName.getString(context),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10),
                hintStyle: const TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedLanguageLevel,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguageLevel = newValue!;
                });
              },
              style: const TextStyle(fontSize: 13),
              items: <String>['beginner', 'normal', 'hard']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              underline: const SizedBox(),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                child: Text(LocaleData.cancel.getString(context),
                    style: TextStyle(fontSize: 13, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextButton(
                onPressed: () {
                  if (_languageNameController.text.isNotEmpty &&
                      _selectedLanguageLevel.isNotEmpty) {
                    widget.onAccept(
                        _languageNameController.text, _selectedLanguageLevel);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(LocaleData.hintLanguageLevel.getString(context)),
                    ));
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
                child: Text(LocaleData.accept.getString(context),
                    style: const TextStyle(fontSize: 13, color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _languageNameController.dispose();
    super.dispose();
  }
}
