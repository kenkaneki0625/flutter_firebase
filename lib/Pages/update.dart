import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/Pages/home.dart';
import '../Widgets/sidebar.dart';

class UpdatePage extends StatelessWidget {

  final String id;

  UpdatePage({
    Key? key,
    required this.id,
  }) : super(key: key);

   

  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update')),
        body: FutureBuilder<User?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return user == null
                  ? Center(child: Text('No User'))
                  : buildUser(user, context);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
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

  Future<User?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(id);

    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }

  Widget buildUser(User user, BuildContext context) => Column(
    children: <Widget>[
          TextField(
            controller: controllerName..text = user.name,
            decoration: decoration('Name'),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerAge..text = '${user.age}',
            decoration: decoration('Age'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerPhone..text = '${user.number}',
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
                //createUser(user);
                final docUser =
                    FirebaseFirestore.instance.collection('users').doc(id);
                docUser.update({
                  'name': user.name,
                  'age': user.age,
                  'number': user.number
                });
                
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
              },
              child: Text('Update'))
        ],
  );
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
  
  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      number: json['number']);
}
