import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/sidebar.dart';
import '../Pages/singleUser.dart';
import '../Pages/update.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(title: Text('Read User')),
        body: StreamBuilder<List<User>>(
          stream: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(child: Text('${user.age}')),
        title: Text(user.name),
        subtitle: Text('${user.number}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                size: 20.0,
                color: Colors.brown[900],
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UpdatePage(id: user.id),
          ));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                size: 20.0,
                color: Colors.brown[900],
              ),
              onPressed: () {
                final docUser =
                    FirebaseFirestore.instance.collection('users').doc(user.id);
                docUser.delete();
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SingleUserPage(id: user.id),
          ));
        },
      );

  Stream<List<User>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
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
