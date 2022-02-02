import 'package:flutter/material.dart';


class GreenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update')),
      backgroundColor: Colors.green,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Text("Green screen", style: TextStyle(fontSize: 20),)
            ),
          )
    );
  }
}
