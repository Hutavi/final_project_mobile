import 'package:flutter/material.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHub',
      home: Scaffold(
        appBar: const AppBarCustom(title: "Student Hub"),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    // Text
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.0,
                              bottom:
                                  8.0), // Đặt khoảng cách ở đây (8.0 là ví dụ, bạn có thể thay đổi giá trị này)
                          child: Text(
                            'Build your product with high-skilled student',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  20.0), // Đặt khoảng cách ở đây (8.0 là ví dụ, bạn có thể thay đổi giá trị này)
                          child: Text(
                            'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),

                    // Buttons
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom:
                              30.0), // Padding dưới cho Column (16.0 là ví dụ, bạn có thể thay đổi giá trị này)
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top:
                                    16.0), // Padding trên cho button 1 (16.0 là ví dụ, bạn có thể thay đổi giá trị này)
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Company'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                            ), // Padding trên cho button 2 (16.0 là ví dụ, bạn có thể thay đổi giá trị này)
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRouterName.profileS1);
                              },
                              child: const Text('Student'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // List
                    const Text(
                      'StudentHub is university market place to connect high-skilled student and company on a real-world project',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
