import 'package:flutter/material.dart';
import 'package:student_hub/routers/route_name.dart';

class StundentProfileS1 extends StatefulWidget {
  const StundentProfileS1({super.key, required this.selectedValue});

  final String? selectedValue;

  @override
  State<StundentProfileS1> createState() => _StundentProfileS1State();
}

class _StundentProfileS1State extends State<StundentProfileS1> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  void _onDropdownChanged(String? newValue) {
    setState(() {
      _selectedValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StudentHub',
          style: TextStyle(color: Colors.white), // Chỉnh màu chữ thành trắng
        ),
        backgroundColor: Colors.blue,
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.people,
              color: Colors.white, // Chỉnh màu icon thành trắng
              size: 30, // Kích thước của icon
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Welcome message
            const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 12.0),
              child: Text(
                'Welcome to Student Hub',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Tell us about yourself
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
              child: Text(
                'Tell us about yourself and you will be on your way to connect with real-world projects.',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),

            const Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    'TechStack',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 1, bottom: 1),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedValue,
                      onChanged: _onDropdownChanged,
                      items: <String>[
                        'Fullstack Engineer',
                        'Frontend',
                        'Backend',
                        'BA'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: const SizedBox(),
                    ),
                  )),
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
                              const Text(
                                'Reactjs',
                                style: TextStyle(fontSize: 13),
                              ),
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
                                  padding: const EdgeInsets.all(6.0),
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
                                  padding: const EdgeInsets.all(6.0),
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

            // Languages
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Căn văn bản sang trái
                    children: [
                      const Text(
                        'Languages',
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
                    'English: Native or Bilingual',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Căn văn bản sang trái
                    children: [
                      const Text(
                        'Education',
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
                2, // Số lượng item muốn tạo
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Le Hong Phong High School',
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
                        '2008-2010',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
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
                    Navigator.pushNamed(context, AppRouterName.profileS2);
                  },
                  child: const Text('Next'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
