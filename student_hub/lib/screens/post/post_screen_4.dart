import 'package:flutter/material.dart';

class PostScreen4 extends StatefulWidget {
  const PostScreen4({super.key});

  @override
  State<PostScreen4> createState() => _PostScreen4State();
}

class _PostScreen4State extends State<PostScreen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "4/4-Project details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              const Text("Title of job",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const Divider(),
              const Text("Student are looking for"),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Icon(Icons.circle, size: 5),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        const Expanded(
                          child: Text(
                            'Clear expectations about your project or deliverables',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 14), // Đặt kích thước chữ là 14
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Icon(Icons.circle, size: 5),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        const Expanded(
                          child: Text(
                            'The skills required for your project',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 14), // Đặt kích thước chữ là 14
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Icon(Icons.circle, size: 5),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        const Expanded(
                          child: Text(
                            'Details about your project',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 14), // Đặt kích thước chữ là 14
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.alarm,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Project scope',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        ListTile(
                          title: Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Icon(Icons.circle, size: 5),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              const Expanded(
                                child: Text(
                                  '3 to 6 months',
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 14), // Đặt kích thước chữ là 14
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height < 600
              //       ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
              //       : 16,
              // ),
              Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Required students',
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        ListTile(
                          // contentPadding: EdgeInsets.all(0),
                          title: Row(
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Icon(Icons.circle, size: 5),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              const Expanded(
                                child: Text(
                                  '6 students',
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 14), // Đặt kích thước chữ là 14
                                ),
                              ),
                            ],
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
      bottomNavigationBar: BottomAppBar(
        height: 100,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // tới screen khác
                },
                child: const Text('Post a job'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectRequirement(
      IconData icon, String title, String detailRequirement) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 35,
        ),
        const SizedBox(
          width: 15,
        ),
        const Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomText(text: title),
              // CustomBulletedList(
              //   listItems: [detailRequirement],
              // ),
            ],
          ),
        ),
      ],
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
          onPressed: () {
            // tới profile);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
