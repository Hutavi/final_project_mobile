import 'package:flutter/material.dart';
import 'package:student_hub/screens/dashboard/bottomNavigationBar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(
                    20, 10, 0, 10), // Đặt lề cho Container
                child: const Text(
                  "Your jobs",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.grey), // Màu đổ bóng
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        15.0))), // Bo tròn góc
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                            color:
                                Color.fromARGB(255, 8, 11, 1), // Màu đường viền
                            width: 1.2, // Độ dày của đường viền
                          ),
                        ),
                      ),
                      child: const Text(
                        'Post a job',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ],
          ),
          const Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Đặt alignment theo chiều ngang
            crossAxisAlignment:
                CrossAxisAlignment.start, // Đặt alignment theo chiều dọc
            children: <Widget>[
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Đặt alignment theo chiều dọc
                children: <Widget>[
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "You have no jobs",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const bottomNavigationBar(),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.grey[200],
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('lib/assets/images/avatar.png'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
