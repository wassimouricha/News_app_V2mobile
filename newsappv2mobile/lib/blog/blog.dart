import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListBlog extends StatefulWidget {
  const ListBlog({Key? key}) : super(key: key);

  @override
  State<ListBlog> createState() => _ListBlogState();
}

class _ListBlogState extends State<ListBlog> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
        ),
        actions: [
          IconButton(
              onPressed: () {
                final name = controller.text;

                createUser(name: name);
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }

  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc();

    final user = Users(
      id: docUser.id,
      name: name,
      age: 27,
      birthday: DateTime(2022, 04, 22),
    );

    final json = user.toJson();

    await docUser.set(json);
  }
}

class Users {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  Users({
    this.id = "",
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {

"id" : id,
"name" : name,
"age" : age,
"birthday" : birthday,


  };
}
