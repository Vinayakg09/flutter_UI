import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await firebase.Firebase.initializeApp(
        name: 'Prototype',
        options: const firebase.FirebaseOptions(
            apiKey: "AIzaSyD5bY7nTcrKZsM_GiCB2njkWefAm57zvMM",
            appId: "1:776584966897:ios:b923c43a7f399b0d65ef50",
            messagingSenderId: "",
            projectId: "prototype-185e3"));
  } else {
    await firebase.Firebase.initializeApp();
  }
  final SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString("email");
  runApp(MyApp(email));
}

MaterialApp MyApp(String? email) {
  return MaterialApp(
    title: 'Demo Flutter UI',
    theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.comfortable,
          useMaterial3: true,
          iconTheme: IconThemeData(color: Colors.cyanAccent)
        ),
    home: email == null?loginPage():Home(testValue: ""),
  );
}

// class MyApp extends StatelessWidget {
//   var emails;
//    MyApp({super.key, required this.emails});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Demo Flutter UI',
//       home: emails == null?loginPage():Home(testValue: ""),
//     );
//   }
// }
