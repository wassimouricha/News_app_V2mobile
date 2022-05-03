import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/constant.dart';
import 'package:newsappv2mobile/home_screen.dart';
import 'package:intl/intl.dart'; //package pour faire fonctionner le dateFormat

class ListBloged extends StatefulWidget {
  const ListBloged({Key? key}) : super(key: key);

  @override
  State<ListBloged> createState() => _ListBlogedState();
}

class _ListBlogedState extends State<ListBloged> {
  final controller = TextEditingController();
  final controllerName = TextEditingController();
  final controllerTitle = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerDate = TextEditingController();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  String action = 'update';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //ici je code mon appbar qui me redirige vers l'accueil
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen())),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 57, 130, 173),
                    ),
                  ),
                ),
                Text(
                  "NewsApp v2",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            )),
        titleSpacing: 0,
      ),
      body: StreamBuilder<List<Users>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: users.map(buildUsers).toList(),
              );
            } else if (snapshot.hasError) {
              // print(snapshot.error);
              return const Text(" une erreur est survenue");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildUsers(Users users) => Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    //nos background
                    Container(
                      height: 136,
                      decoration: BoxDecoration(
                        boxShadow: const [kDefaultShadow],
                        borderRadius: BorderRadius.circular(22),
                        color: kBlackColor,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                    ),
                    // nos images de prestations
                    Positioned(
                      top: 10,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        height: 130,
                        width: 150,
                        child: Image.asset(
                          "image/blogpost.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 150,
                      child: ElevatedButton(
                        child: const Icon(
                          Icons.update,
                          color: Colors.green,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          primary: Colors.white,
                          elevation: 0.0,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext ctx) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 20,
                                      left: 20,
                                      right: 20,
                                      // empeche le widget de cacher les  text fields
                                      bottom:
                                          MediaQuery.of(ctx).viewInsets.bottom +
                                              20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: controllerName,
                                        decoration: const InputDecoration(
                                            labelText: 'Auteur'),
                                      ),
                                      TextField(
                                        controller: controllerTitle,
                                        decoration: const InputDecoration(
                                            labelText: 'Titre'),
                                      ),
                                      TextField(
                                        controller: controllerDescription,
                                        decoration: const InputDecoration(
                                            labelText: 'Description'),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      DateTimeField(
                                          controller: controllerDate,
                                          decoration: InputDecoration(
                                            labelStyle: TextStyle(
                                              color: Colors.grey[400],
                                            ),
                                            labelText: 'Date',
                                          ),
                                          format: format,
                                          onShowPicker:
                                              (context, currentValue) async {
                                            final date = await showDatePicker(
                                                context: context,
                                                firstDate: DateTime(1900),
                                                initialDate: currentValue ??
                                                    DateTime.now(),
                                                lastDate: DateTime(2100));
                                            if (date != null) {
                                              final time = await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        currentValue ??
                                                            DateTime.now()),
                                              );
                                              return DateTimeField.combine(
                                                  date, time);
                                            } else {
                                              return currentValue;
                                            }
                                          }),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        child: const Text('Update'),
                                        onPressed: () async {
                                          final String? name =
                                              controllerName.text;

                                          final String? titre =
                                              controllerTitle.text;

                                          final String? description =
                                              controllerDescription.text;

                                          final DateTime? date = DateTime.parse(
                                              controllerDate.text);

                                          if (action == 'update') {
                                            // Update l'auteur
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(users.id)
                                                .update({
                                              "auteur": name,
                                              "titre": titre,
                                              "description": description,
                                              "date": date,
                                            });
                                          }

                                          // nettoie le  textfields
                                          controllerName.text = '';
                                          controllerTitle.text = '';
                                          controllerDescription.text = '';

                                          // cache le widget the bottom sheet
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                          // final String? name = controllerName.text;
                          // // final docUser = FirebaseFirestore.instance

                          // //     .collection("users")
                          // //     .doc(users.id);

                          // // //Update champs de text
                          // // docUser.update({
                          // //  "auteur" : "wassim" ,
                          // // });
                          // FirebaseFirestore.instance
                          //     .doc(documentSnapshot!.id)
                          //     .update({"name": name});
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 200,
                      child: ElevatedButton(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          primary: Colors.white,
                          elevation: 0.0,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          final docUser = FirebaseFirestore.instance
                              .collection("users")
                              .doc(users.id);

                          docUser.delete();
                        },
                      ),
                    ),
                    // nom de la prestation , date , client et prix
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        height: 136,
                        // l'image prend 150 en largeur , c'est pourquoi ici je met  la largeur 250
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                              ),
                              child: Text(
                                getTruncatedContent(users.titre, 15) + "...",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              child: Text(
                                "Description : " +
                                    getTruncatedContent(users.description, 20) +
                                    "...",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding,
                              ),
                              child: Text(
                                "Auteur : " +
                                    getTruncatedContent(users.name, 12) +
                                    "...",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            ),

                            //occupe l'espace disponible
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPadding * 1.5, //30 padding
                                vertical: kDefaultPadding / 4,
                              ),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 57, 130, 173),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              child: Text(
                                getTruncatedContent(
                                    users.date.toIso8601String(), 10),
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      );

  //lecture
  Stream<List<Users>> readUsers() => FirebaseFirestore.instance
          .collection("users")
          .snapshots()
          .map((snapshot) {
        // snapshot.docs.forEach((element) {
        //   print(element.data());
        // });
        return snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList();
      });

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

String getTruncatedContent(String text, int truncatedNumber) {
  return text.length > truncatedNumber
      ? text.substring(0, truncatedNumber)
      : text;
}
