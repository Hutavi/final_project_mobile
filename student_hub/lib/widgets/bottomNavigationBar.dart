import 'package:flutter/material.dart'; 

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_document),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messenger',
        ),BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
      ],
    );
  }
}