import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final countProvider = StateProvider<int>((ref) => 0);

class PostScreen1 extends ConsumerStatefulWidget {
  const PostScreen1({Key? key}) : super(key: key);

  @override
  ConsumerState<PostScreen1> createState() => _PostScreen1State();
}

class _PostScreen1State extends ConsumerState<PostScreen1> {
  final titleController = TextEditingController();
  bool _titlePost = false;
  
  @override
  Widget build(BuildContext context) {
    if (ref.watch(postProjectProvider).title != null) {
      titleController.text = ref.watch(postProjectProvider).title!;
    }
    
    return ProviderScope(
        child: Scaffold(
      appBar: const _AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 36.0, bottom: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "1/4-Let's start with a strong title",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 14 * 2,
              ),
              const Text(
                "This helps your post stand out to the right students. It's the first thing they will see, so make it impressive",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600 ? 14 : 14 * 4,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "Write a title for your post",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                            bottom: Radius.circular(10.0)))),
                onChanged: (value) {
                  ref.read(postProjectProvider.notifier).setProjectTitle(value);
                  setState(() {
                    _titlePost = value.isNotEmpty;
                  });
                },
              ),
              const SizedBox(
                height: 14 * 4,
              ),
              const Text(
                "Example titles",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          "• Build responsive WorldPress site with booking/paying functionality",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const ListTile(
                        title: Text(
                          "• Facebook ad specialist need for product launch",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14 * 4,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRouterName.postScreen2);
                          },
                          child: Text("Next Scope"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: _titlePost ? null : kWhiteColor,
                            backgroundColor: kBlue400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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
