import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_odk/pages/add%20et%20auth/connection_page.dart';
import 'package:ticket_app_odk/pages/add%20et%20auth/login_page.dart';
import 'package:ticket_app_odk/pages/admin/admin_page.dart';
import 'package:ticket_app_odk/pages/apprenant/apprenant_home_page.dart';
import 'package:ticket_app_odk/pages/apprenant/apprenant_pages.dart';
import 'package:ticket_app_odk/pages/formateur/formateur_Accueil.dart';
import 'package:ticket_app_odk/pages/formateur/formateur_page.dart';
// import 'package:ticket_app_odk/pages/admin/admin_page.dart';
// import 'package:ticket_app_odk/pages/login_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

  //     initialRoute: '/',
  // routes: {
  //   '/': (context) => ConnectionPage(),
  //   '/pageApprenant': (context) => PageApprenant(),
  //   '/pageFormateur': (context) => PageFormateur(),
  //   '/pageAdmin': (context) => PageAdmin(),
  //   }



      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginPage(),
      home:  LoginPage(),
    );
  }
}


  
  

