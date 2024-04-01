import 'package:flutter/material.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class StundentProfileS2 extends StatefulWidget {
  const StundentProfileS2({super.key});

  @override
  State<StundentProfileS2> createState() => _StundentProfileS2State();
}

class _StundentProfileS2State extends State<StundentProfileS2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Student Hub"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Welcome message
            const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 12.0),
              child: Text(
                'Experiences',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: Text(
                'Tell us about yourself and you will be on your way to connect with real-world projects.',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Căn văn bản sang trái
                    children: [
                      const Text(
                        'Projects',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              children: List.generate(
                1, // Số lượng item muốn tạo
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Căn văn bản sang trái
                        children: [
                          const Text(
                            'Intelligent Taxi Dispatching system',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black),
                                ),
                                padding: const EdgeInsets.all(2.0),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black),
                                ),
                                padding: const EdgeInsets.all(2.0),
                                child: const Icon(
                                  Icons.delete,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                          height:
                              2.0), // Thêm một khoảng cách giữa hàng và văn bản
                      const Text(
                        '9/2020 - 12/2020, 4 months',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            // Skillset
            const Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    'Skillset',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Màu nền trắng
                  border: Border.all(color: Colors.black), // Viền đen
                  borderRadius: BorderRadius.circular(8.0), // Độ cong của góc
                ),
                padding: const EdgeInsets.all(
                    8.0), // Khoảng cách giữa biên của Container và nội dung bên trong
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Reactjs',
                                  style: TextStyle(fontSize: 13)),
                              const SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () {
                                  // Xử lý sự kiện khi icon close được bấm
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Icon(
                                    Icons.close,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Nodejs',
                                  style: TextStyle(fontSize: 13)),
                              const SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () {
                                  // Xử lý sự kiện khi icon close được bấm
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Icon(
                                    Icons.close,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Divider(
                color: Colors.black, // Màu sắc của đường kẻ
                thickness: 1, // Độ dày của đường kẻ
              ),
            ),

            // Languages
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Intelligent Taxi Dispatching system',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: const Icon(
                              Icons.add,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 2.0), // Thêm một khoảng cách giữa hàng và văn bản
                  const Text(
                    '9/2020 - 12/2020, 4 months',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
              child: Text(
                'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),

            // Next button
            Container(
              padding: const EdgeInsets.only(
                  top: 16.0,
                  right: 16.0), // Đặt padding cho Container để căn chỉnh nút
              alignment:
                  Alignment.bottomRight, // Căn chỉnh nút ở dưới cùng bên phải
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterName.profileS3);
                  },
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
