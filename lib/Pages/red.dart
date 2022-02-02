import 'package:flutter/material.dart';


class RedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update')),
      backgroundColor: Colors.red,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text("Red screen", style: TextStyle(fontSize: 20),)
            ),
          )
    );
  }
}
