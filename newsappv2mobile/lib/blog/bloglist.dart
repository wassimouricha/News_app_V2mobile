import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/constant.dart';
import 'package:newsappv2mobile/home_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        //ici je code mon app bar qui me redirige vers l'accueil
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
                  "WNews v2",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            )),
        titleSpacing: 0,
      ),
      body: 
      StreamBuilder<List<Users>>(
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

  Widget buildUsers(Users users) => 
  
  
  Column(
    children: [
      const SizedBox(height: 15,),
      Stack(

        
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              //nos background
              Container(
                height: 136,
                decoration: BoxDecoration(
                  boxShadow: const [kDefaultShadow],
                  borderRadius: BorderRadius.circular(22),
                  color:  kBlackColor ,
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
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 160,
                  width: 200,
                  child: Image.asset(
                    "image/blogpost.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // nom de la prestation , date , client et prix
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  height: 136,
                  // l'image prend 200 en largeur , c'est pourquoi nous mettons la largeur total - 200
                  width: 200,
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
                          "Auteur : " + users.name,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Text(
                          "Description : " + getTruncatedContent(users.description,30) + "...",
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
                           users.titre,
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

 String getTruncatedContent(String text, int truncatedNumber) {
    return text.length > truncatedNumber
        ? text.substring(0, truncatedNumber) 
        : text;
  }