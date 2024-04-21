import 'package:flutter/material.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: ListView(
          padding: const EdgeInsets.all(10.0),
          children: const [
            NotificationCard(
              icon: Icons.notifications,
              text: 'You have a new message',
              time: '10:00 AM',
            ),
            SizedBox(height: 8.0),
            NotificationCard(
              icon: Icons.event_available,
              text: 'Your event starts soon',
              time: '12:00 PM',
              showButton: true,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;
  final bool showButton;

  const NotificationCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.time,
    this.showButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
            if (showButton) ...[
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: const Text('Join'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: NotificationPage(),
  ));
}
