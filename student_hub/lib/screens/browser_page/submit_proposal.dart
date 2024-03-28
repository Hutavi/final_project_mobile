import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/models/project_model.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/constants/colors.dart';

class submitProposal extends StatefulWidget {
  // final ProjectModel projectItem;
  const submitProposal({super.key});
  // const submitProposal({super.key, required this.projectItem});

  @override
  State<submitProposal> createState() => _submitProposalState();
}

class _submitProposalState extends State<submitProposal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        title: 'Student Hub',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Cover letter',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Describe why do you fit to this project',
                  style: TextStyle(
                      fontSize: 13,
                      // fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            const TextField(
              maxLines: 6,
              decoration: InputDecoration(
                  hintText: '',
                  enabledBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                      bottom: Radius.circular(10.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                          bottom: Radius.circular(10.0)))),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: kWhiteColor,
                        foregroundColor: kRed),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: kWhiteColor,
                        foregroundColor: kBlue700),
                    child: const Text('Submit proposal'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
