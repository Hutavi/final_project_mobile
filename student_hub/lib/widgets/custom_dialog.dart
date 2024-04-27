import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/constants/image_assets.dart';

class DialogCustom extends StatelessWidget {
  final String title, description, buttonText;
  final int? statusDialog;
  final VoidCallback? onConfirmPressed;
  const DialogCustom(
      {super.key,
      required this.title,
      required this.description,
      required this.buttonText,
      this.statusDialog,
      this.onConfirmPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 1,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 24.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onConfirmPressed != null) {
                      onConfirmPressed!();
                    }
                  },
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: kBlue700),
                  ),
                ),
              ),
            ],
          ),
        ),
        statusDialog == 1
            ? Positioned(
                top: -30,
                left: 16,
                right: 16,
                child: Center(
                  child: Lottie.asset(ImageManagent.imgDialogSuccess,
                      width: 200, height: 200),
                ),
              )
            : statusDialog == 2
                ? Positioned(
                    top: 20,
                    left: 16,
                    right: 16,
                    child: Lottie.asset(ImageManagent.imgDialogError,
                        width: 110, height: 110),
                  )
                : Container(),
      ],
    );
  }
}
