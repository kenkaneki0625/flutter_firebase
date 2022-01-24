import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
