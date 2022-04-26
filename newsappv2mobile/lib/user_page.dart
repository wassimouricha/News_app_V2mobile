import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsappv2mobile/login.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  get user => FirebaseAuth.instance.currentUser;
  

  @override
  Widget build(BuildContext context)=> Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text("une erreur s'est produite"));
              }
              else if (snapshot.hasData) {
                return   Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Profil : " + user.email,
              style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const CircleAvatar(
                    radius: 142,
                    backgroundImage: NetworkImage(
                       "user!.photoURL!"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10)),
                      Text(
                        "Adresse E-mail : " + user.email,
                        style: GoogleFonts.poppins(
                            fontSize: 17, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Nom : ",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.black),
                      ),

                      ElevatedButton(
                          onPressed: () => FirebaseAuth.instance
                              .signOut(), //la fonction signOut
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
                                "Se déconnecter",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )),
                      // style: ElevatedButton.styleFrom(
                      //   minimumSize: Size.fromHeight(50),
                      // ),
                      // icon: Icon(Icons.arrow_back,size: 32,),
                      // label: Text('deconnexion' , style: TextStyle(fontSize: 24),
                      // ),
                      // onPressed: () => FirebaseAuth.instance.signOut(),
                      // ),
                    ],
                  ),
                ],
              )),
        );
              } else {
                return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Profil :  Non connecté",
              style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const CircleAvatar(
                    radius: 142,
                    backgroundImage: NetworkImage(
                        ''),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10)),
                      Text(
                        "Adresse E-mail : Non connecté",
                        style: GoogleFonts.poppins(
                            fontSize: 17, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Nom : Non connecté",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.black),
                      ),

                      ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const loginaid())),
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
                                "Se Connecter",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )),
                      // style: ElevatedButton.styleFrom(
                      //   minimumSize: Size.fromHeight(50),
                      // ),
                      // icon: Icon(Icons.arrow_back,size: 32,),
                      // label: Text('deconnexion' , style: TextStyle(fontSize: 24),
                      // ),
                      // onPressed: () => FirebaseAuth.instance.signOut(),
                      // ),
                    ],
                  ),
                ],
              )),
        );
              }
            }),
      );
}
       
   
