import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/navigation_menu.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(
        title: 'Student Hub',
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: _Content(),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 150),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              LocaleData.edtProfileCompanyTitle.getString(context),
              style: const TextStyle(
                // color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              LocaleData.welcomeLine1.getString(context),
              style: const TextStyle(
                // color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          // button get started

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavigationMenu()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kBlue400,
            ),
            child: Text(
              LocaleData.getStarted.getString(context),
              style: const TextStyle(
                color: kWhiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ]);
  }
}
