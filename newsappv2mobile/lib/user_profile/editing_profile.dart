
import 'package:flutter/material.dart';
import 'package:newsappv2mobile/user_profile/appbar_widget.dart';
import 'package:newsappv2mobile/user_profile/profile_widget.dart';
import 'package:newsappv2mobile/user_profile/user.dart';
import 'user_pref.dart';
import 'textfwid.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Usered user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) =>  Scaffold(

    appBar: buildAppBar(context),
    body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      physics: const BouncingScrollPhysics(),
      children: [
          ProfileWidget(
            imagePath: user.imagePath,
            isEdit : true,
          
          
          ),

          const SizedBox(height: 24,),
          TextFieldWidget(
            label:"à propos",
            text: user.about,
            maxLines: 5,
            onChanged: (about){},
          ),

    ]),
  );
}
