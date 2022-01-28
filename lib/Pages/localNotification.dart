import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/Services/notification.dart';
import '../Widgets/sidebar.dart';

class LocalNotification extends StatefulWidget {
  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
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
                    onClicked: () => {
                      NotificationApi.showNotifications(
                        title: 'Hey Shaon',
                        body: 'Hope everything is going well',
                        payload: 'shaon.b'
                      )
                    },
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
