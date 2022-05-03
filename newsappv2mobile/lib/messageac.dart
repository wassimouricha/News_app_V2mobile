import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const Center(
           child: Text(
            "Bonjour et bienvenue sur NewsApp !",
            style:  TextStyle(fontSize: 20),
        ),
         ),
        Text("Informez vous en cliquant sur les articles dans la liste",
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color.fromARGB(255, 57, 130, 173),
            ))
      ],
    );
  }
}
