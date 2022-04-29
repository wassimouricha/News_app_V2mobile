import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/blog/bloglist.dart';
import 'package:intl/intl.dart'; //package pour faire fonctionner le dateFormat

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
  final controllerDate = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");
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
            "Postez votre article ici en remplissant les différents champs de text",
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
          DateTimeField(
            controller: controllerDate,
            decoration: InputDecoration( labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
              labelText: 'Date',),
              format: format,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              }),

          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () {
                final users = Users(
                    name: controllerName.text,
                    titre: controllerTitle.text,
                    description: controllerDescription.text,
                    date: DateTime.parse(controllerDate.text));

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
  final DateTime date;

  Users({
    this.id = "",
    required this.name,
    required this.titre,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "auteur": name,
        "titre": titre,
        "description": description,
        "date": date,
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      id: json["id"],
      name: json["auteur"],
      titre: json["titre"],
      description: json["description"],
      date: (json["date"] as Timestamp).toDate(),
      );
}
