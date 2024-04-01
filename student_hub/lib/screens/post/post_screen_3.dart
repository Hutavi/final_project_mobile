import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_hub/routers/route_name.dart';

class PostScreen3 extends StatefulWidget {
  const PostScreen3({super.key});

  @override
  State<PostScreen3> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Container(
        child: Padding(
          // padding: EdgeInsets.all(16),
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 20.0, bottom: 0.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('3/4    Next, provide project description',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  'Students are looking for:',
                ),
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
                const SizedBox(
                  height: 16.0,
                ),
                const TextField(
                  maxLines: 6,
                  decoration: InputDecoration(
                      hintText: 'Project Description',
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
                              bottom:Radius.circular(10.0)
                          )
                      )
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height < 600
                      ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                      : 16,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouterName.postScreen4);
                    },
                    style: ElevatedButton.styleFrom(
                      // Adjust minimum size based on screen size
                      minimumSize: MediaQuery.of(context).size.width < 300
                          ? const Size(200,
                              40) // Adjust width and height for smaller screens
                          : null,
                      // Adjust padding based on screen size (optional)
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width < 300
                            ? 10.0
                            : 16.0, // Adjust padding for smaller screens
                        vertical: 8.0,
                      ),
                    ),
                    child: const Text('Review your post'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
