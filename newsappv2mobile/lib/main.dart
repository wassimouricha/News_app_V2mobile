import 'package:flutter/material.dart';
// import 'package:newsappv2mobile/home_screen.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsappv2mobile/splash_screen.dart';




Future main() async {

   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    
    options: const FirebaseOptions(
      apiKey: "AIzaSyCOMPb2RbsTegqR4zKfSfgGB28iYv_0dRo", // Your apiKey
      appId: "1:517870258699:android:6ba0fbddbc4b8497e8950e", // Your appId
      messagingSenderId: "517870258699", // Your messagingSenderId
      projectId: "newsappwassim-d200c", // Your projectId
       ) 
     
  );
 
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wassim News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        

        primarySwatch: Colors.blue,
        dividerColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}
