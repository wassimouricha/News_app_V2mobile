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
        title:   TextField(controller: controller,),
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
      final docUser =
          FirebaseFirestore.instance.collection("users").doc("my-id");

      final json = {
        "name": name,
        "age": 27,
        "publication" : DateTime(2022, 04, 22),
      };

      await docUser.set(json);
    }
}
