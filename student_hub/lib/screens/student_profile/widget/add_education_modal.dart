import 'package:flutter/material.dart';

class AddEducationModal extends StatefulWidget {
  final String initialEducationName;
  final String initialSelectedEducationStartYear;
  final String initialSelectedEducationEndYear;
  final void Function(String educationName, String educationStartYear,
      String educationEndYear) onAccept;

  const AddEducationModal({
    Key? key,
    required this.initialEducationName,
    required this.initialSelectedEducationStartYear,
    required this.initialSelectedEducationEndYear,
    required this.onAccept,
  }) : super(key: key);

  @override
  AddEducationModalState createState() => AddEducationModalState();
}

class AddEducationModalState extends State<AddEducationModal> {
  late TextEditingController _educationNameController;
  late String _selectedEducationStartYear;
  late String _selectedEducationEndYear;
  List<String> yearsList =
      List.generate(51, (index) => (2000 + index).toString());
  var title = '';

  @override
  void initState() {
    super.initState();
    _educationNameController =
        TextEditingController(text: widget.initialEducationName);
    _selectedEducationStartYear = widget.initialSelectedEducationStartYear;
    _selectedEducationEndYear = widget.initialSelectedEducationEndYear;
    title = widget.initialEducationName != ''
        ? 'Update Education'
        : 'Add Education';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black),
                color: Colors.white),
            child: TextField(
              controller: _educationNameController,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                hintText: 'Education Name',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start year',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              menuMaxHeight: 200,
              isExpanded: true,
              value: _selectedEducationStartYear,
              onChanged: (newValue) {
                setState(() {
                  _selectedEducationStartYear = newValue!;
                });
              },
              style: const TextStyle(fontSize: 13),
              items: yearsList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              underline: const SizedBox(),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'End year',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              menuMaxHeight: 200,
              isExpanded: true,
              value: _selectedEducationEndYear,
              onChanged: (newValue) {
                setState(() {
                  _selectedEducationEndYear = newValue!;
                });
              },
              style: const TextStyle(fontSize: 13),
              items: yearsList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
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
                child: const Text('Cancel',
                    style: TextStyle(fontSize: 13, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextButton(
                onPressed: () {
                  if (_educationNameController.text.isNotEmpty &&
                      _selectedEducationStartYear.isNotEmpty &&
                      _selectedEducationEndYear.isNotEmpty) {
                    widget.onAccept(_educationNameController.text,
                        _selectedEducationStartYear, _selectedEducationEndYear);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'Please enter education, start year and end year.'),
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
                child: const Text('Accept',
                    style: TextStyle(fontSize: 13, color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _educationNameController.dispose();
    super.dispose();
  }
}
