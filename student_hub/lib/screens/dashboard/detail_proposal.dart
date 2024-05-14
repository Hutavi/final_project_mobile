import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/describe_item.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:student_hub/models/proposal_models/proposal.dart';
import 'package:student_hub/widgets/custom_dialog.dart';

class DetailProposal extends StatefulWidget { 
  // Proposal proposal;
  final String coverletter;
  final int statusFlag;
  final Map project;
  final int idProposal;
  DetailProposal({ required this.coverletter, required this.statusFlag, required this.project , required this.idProposal});
  @override
  State<DetailProposal> createState() => _DetailProposalState();
}

class _DetailProposalState extends State<DetailProposal> {
  bool isOffer = false;

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
          title: LocaleData.success.getString(context),
          description: LocaleData.notiOffer.getString(context),
          buttonText: LocaleData.close.getString(context),
          statusDialog: 1,
          onConfirmPressed: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void receiverOffer()async {
    try {
      final response = await DioClient().request(
        '/proposal/${widget.idProposal}',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['result']['disableFlag'] == 1) {
          print(
            'Data: ${data['result']['disableFlag']}'
          );
          setState(() {
            isOffer = true;
          });
        }
      }

    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  void agreeOffer(int idProposal) async {
    try {
      final response = await DioClient().request(
        '/proposal/$idProposal',
        data: jsonEncode({
          'statusFlag': 3,
        }),
        options: Options(
          method: 'PATCH',
        ),
      );
      if (response.statusCode == 200) {
        print('Đã được tuyển thành công thành công');
        _showSuccessDialog();
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }
  @override
  void initState() {
    super.initState();
    receiverOffer();
  }

  @override
  Widget build(BuildContext context) {
    final scopeProject = widget.project['projectScopeFlag'] == 0
        ? '1 to 3 months'
        : '3 to 6 months';
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const AppBarCustom(
        title: 'Student Hub',
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleData.projectDetail.getString(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text("${widget.project['title']}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kBlue600)),
              const Divider(),
              Text(
                LocaleData.projectDescription.getString(context),
                style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ),
              const SizedBox(height: 5),
              Text("${widget.project['description']}",
                  style: const TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.w300,
                      color: kBlue600)),
              
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Row(
                children: [
                  const Icon(Icons.alarm),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleData.projectScope.getString(context),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '$scopeProject',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Row(
                children: [
                  const Icon(Icons.people),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleData.studentRequired.getString(context),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '${widget.project['numberOfStudents']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  )
                ],
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text(
                "${LocaleData.coverLetter.getString(context)}: ",
                style: const TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ),
              const SizedBox(height: 5),
              Text(widget.coverletter,
                  style: const TextStyle(
                      fontSize: 14,
                      )
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text(
                LocaleData.status.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ),
              const SizedBox(height: 5),
              Text(widget.statusFlag == 0 ? LocaleData.waiting.getString(context)
                                          : widget.statusFlag == 1 ? LocaleData.activeStatus.getString(context)
                                          : widget.statusFlag == 2 ? LocaleData.offer.getString(context)
                                                                  : LocaleData.hired.getString(context),
                  style: const TextStyle(
                      fontSize: 14,
                      )
              ),
              isOffer ? const Divider() : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              isOffer ? Text(
                LocaleData.questionAboutOffer.getString(context),
                style: const TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ) : Container(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        isOffer ? ElevatedButton(
                          onPressed: (){
                            agreeOffer(widget.idProposal);
                          }, 
                          child: 
                          Text(
                            '${LocaleData.accept.getString(context)} offer',
                              ),
                        ): Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}