import 'package:flutter/material.dart';
import '../Widgets/sidebar.dart';

class FirebaseNotification extends StatefulWidget {
  @override
  State<FirebaseNotification> createState() => _FirebaseNotificationState();
}

class _FirebaseNotificationState extends State<FirebaseNotification> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(title: Text('Add User')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Container(
            padding: padding,
            child: Column(
              children: [
                const SizedBox(height: 24),
                buildMenuItem(
                  text: 'Simple Notification',
                  icon: Icons.notifications,
                  onClicked: () => {},
                ),
                const SizedBox(height: 10),
                buildMenuItem(
                  text: 'Scheduled Notification',
                  icon: Icons.notifications_active,
                  onClicked: () => {},
                ),
                const SizedBox(height: 10),
                buildMenuItem(
                  text: 'Remove',
                  icon: Icons.delete,
                  onClicked: () => {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
