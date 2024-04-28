import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/data/student_user.dart';
import 'package:student_hub/screens/browser_page/project_list.dart';
import 'package:student_hub/screens/dashboard/dashboard.dart';
import 'package:student_hub/screens/notification/notification.dart';
import 'package:student_hub/screens/chat/message_list.screen.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({
    Key? key, 
  }) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final NavigationController controller = Get.put(NavigationController());

  late List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const ProjectListScreen(),
      const Dashboard(),
      const MessageListScreen(),
      const NotificationPage(),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    screens.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      extendBodyBehindAppBar:
          true, //this is to extend the body behind the appbar
      appBar: const AppBarCustom(
        title: "Student Hub",
        showBackButton: false,
      ),
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Obx(
          () => NavigationBar(
            height: 60.0,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: kWhiteColor,
            indicatorColor: Colors.black.withOpacity(0.2),
            destinations: const [
              NavigationDestination(
                icon: Icon(Iconsax.document_text),
                label: 'Projects',
                selectedIcon: Icon(
                  Iconsax.document_text,
                  color: kBlue700,
                ),
              ),
              NavigationDestination(
                icon: Icon(Iconsax.folder_open),
                label: 'Dashboard',
                selectedIcon: Icon(
                  Iconsax.folder_open,
                  color: kBlue700,
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Iconsax.message,
                ),
                label: 'Message',
                selectedIcon: Icon(
                  Iconsax.message,
                  color: kBlue700,
                ),
              ),
              NavigationDestination(
                icon: Icon(Iconsax.notification),
                label: 'Alerts',
                selectedIcon: Icon(
                  Iconsax.notification,
                  color: kBlue700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
}