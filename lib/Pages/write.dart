import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/sidebar.dart';

class WritePage extends StatefulWidget {
  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(title: Text('Add User')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: decoration('Name'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerAge,
            decoration: decoration('Age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerPhone,
            decoration: decoration('Number'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () {
                final user = User(
                  age: int.parse(controllerAge.text),
                  name: controllerName.text,
                  number: int.parse(controllerPhone.text),
                );
                createUser(user);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WritePage(),
                ));
              },
              child: Text('Create'))
        ],
      ),
    );
  }

  decoration(String name) => InputDecoration(hintText: name);

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  String id;
  final String name;
  final int age;
  final int number;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.number,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'number': number,
      };
}
