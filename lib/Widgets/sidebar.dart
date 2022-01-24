import 'package:flutter/material.dart';
import '../Pages/home.dart';
import '../Pages/write.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Read',
                    icon: Icons.home,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 10),
                  buildMenuItem(
                    text: 'Write',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
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

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WritePage(),
        ));
        break;
    }
  }
}