import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SingleUserPage extends StatelessWidget {
  final String id;

  const SingleUserPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Single User')),
        body: FutureBuilder<User?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return user == null
                  ? Center(child: Text('No User'))
                  : buildUser(user);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(child: Text('${user.age}')),
        title: Text(user.name),
        subtitle: Text('${user.number}'),
        
      );

  Future<User?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(id);

    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
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

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      number: json['number']);
}
