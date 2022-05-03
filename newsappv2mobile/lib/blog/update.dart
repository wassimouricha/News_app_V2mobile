import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/blog/bloglist.dart';

class ListBlog extends StatefulWidget {
  const ListBlog({Key? key}) : super(key: key);

  @override
  State<ListBlog> createState() => _ListBlogState();
}

class _ListBlogState extends State<ListBlog> {
  final controller = TextEditingController();
  final controllerName = TextEditingController();
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: TextField(
      //     controller: controller,
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           final name = controller.text;

      //           createUser(name: name);
      //         },
      //         icon: const Icon(Icons.add))
      //   ],
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            "Modifiez votre article ici en ramplaçant les différents champs de text",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: controllerName,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              labelText: 'Auteur',
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: controllerTitle,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              labelText: 'Titre',
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: controllerDescription,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              labelText: 'Description',
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () {
                final users = Users(
                    name: controllerName.text,
                    titre: controllerTitle.text,
                    description: controllerDescription.text);

                createUser(users);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ListBloged()));
              }, //la fonction permettant d'envoyer le contenu dans mes champs de texte
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                primary: Colors.black,
                padding: const EdgeInsets.all(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Text(
                    "Envoyer",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget buildUsers(Users users) => ListTile(
        leading: CircleAvatar(child: Text(users.name)),
        title: Text(users.titre),
        subtitle: Text(users.description),
      );

  //lecture
  Stream<List<Users>> readUsers() => FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

//création
  Future createUser(Users users) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc();

    users.id = docUser.id;

    final json = users.toJson();

    await docUser.set(json);
  }
}

class Users {
  String id;
  final String name;
  final String titre;
  final String description;

  Users({
    this.id = "",
    required this.name,
    required this.titre,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "auteur": name,
        "titre": titre,
        "description": description,
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      id: json["id"],
      name: json["auteur"],
      titre: json["titre"],
      description: json["description"]);
}
