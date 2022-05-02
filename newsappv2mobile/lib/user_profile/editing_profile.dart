import 'dart:io'; //package permettant d'utiliser image.file

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsappv2mobile/Animations/delayed_animation.dart';
import 'package:newsappv2mobile/user_profile/appbar_widget.dart';
import 'package:newsappv2mobile/user_profile/profile_widget.dart';
import 'package:newsappv2mobile/user_profile/user.dart';
import 'user_pref.dart';
import 'textfwid.dart';
import 'package:file_picker/file_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Usered user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    if (pickedFile != null) {
      return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                  File(pickedFile!.path!),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.blue[100]),
                child: Center(child: Text(pickedFile!.name)),
              )),
              const SizedBox(
                height: 24,
              ),
              delayedAnimation(
                delay: 1000,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  child: Column(children: [
                    ElevatedButton(
                        onPressed: selectFile,
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.black,
                          padding: const EdgeInsets.all(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Selectionner",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              delayedAnimation(
                delay: 2000,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  child: Column(children: [
                    ElevatedButton(
                        onPressed: uploadFile,
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
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              delayedAnimation(
                delay: 2500,
                child: TextFieldWidget(
                  label: "à propos",
                  text: user.about,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
              ),
            ]),
      );
    } else {
      return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true,
              ),
              const SizedBox(
                height: 24,
              ),
              delayedAnimation(
                delay: 1000,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  child: Column(children: [
                    ElevatedButton(
                        onPressed: selectFile,
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.black,
                          padding: const EdgeInsets.all(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Selectionner",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              delayedAnimation(
                delay: 2000,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  child: Column(children: [
                    ElevatedButton(
                        onPressed: uploadFile,
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
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
                buildProgress(),
              const SizedBox(
                height: 24,
              ),
              delayedAnimation(
                delay: 2500,
                child: TextFieldWidget(
                  label: "à propos",
                  text: user.about,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
              ),
            ]),
      );

     
    }
  }

 Widget buildProgress() => StreamBuilder<TaskSnapshot>(

stream: uploadTask?.snapshotEvents,
builder: (context,snapshot){
  if (snapshot.hasData){
 final data = snapshot.data!;
 double progress = data.bytesTransferred / data.totalBytes;

 return SizedBox(
   height: 50,
   child: Stack(

     fit: StackFit.expand,
     children: [
       LinearProgressIndicator(
         value: progress,
         backgroundColor: Colors.grey,
         color: Colors.green,
       ),
       Center(
         child: Text("${(100* progress).roundToDouble()} %",
         style: const TextStyle(color: Colors.white),
         ),
       )
     ],
   ),
 );
  } else {
    return const SizedBox(height: 50);
  }
});


  //fonction pour selectionner le fichier
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  // fonction pour uploader le fichier
  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}'; //liens du dossier et nom du fichier upload
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instanceFor(bucket: "gs://newsappwassim-d200c.appspot.com"); //liens du sotrage
    setState(() {
          uploadTask = ref.ref(path).putFile(file);
    });


    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    // ignore: avoid_print
    print("liens de téléchargement : $urlDownload");

    setState(() {
      uploadTask = null;
    });
  }

  
}
