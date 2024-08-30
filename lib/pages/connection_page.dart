// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_odk/pages/home_page.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  String email = "", password = "";

  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  seConnecter() async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  } on FirebaseAuthException catch (e) {
    String message = 'Une erreur est survenue. Veuillez réessayer.';  // Message par défaut

    // Print le code d'erreur pour le débogage
    print('FirebaseAuthException code: ${e.code}');

    if (e.code == 'user-not-found') {
      message = 'Aucun utilisateur trouvé avec cet email.';
    } else if (e.code == 'wrong-password') {
      message = 'Mauvais mot de passe saisi.';
    } else if (e.code == 'invalid-email') {
      message = 'L\'email saisi est invalide.';
    } else if (e.code == 'user-disabled') {
      message = 'Ce compte a été désactivé.';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xFF5E0707),
      content: Text(
        message,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ));
  } catch (e) {
    // Print l'erreur pour le débogage
    print('Autre erreur: $e');

    // Gérer d'autres types d'erreurs
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Color(0xFF5E0707),
      content: Text(
        'Une erreur inattendue est survenue. Veuillez réessayer plus tard.',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ));
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/images/welcome.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 38,
                    color: Color(0xFF5E0707),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Content de vous \n retrouver parmi nous !',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 140),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          maxLength: 50,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Veuillez renseigner votre email.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: passwordcontroller,
                          maxLength: 20,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Veuillez saisir le mot de passe.';
                            }
                            if (text.length < 6) {
                              return 'Le mdp doit contenir au moins 6 caractères.';
                            }
                          //   final hasDigits = RegExp(r'\d').hasMatch(text);
                          //   final hasUpperCase =
                          //       RegExp(r'[A-Z]').hasMatch(text);
                          //   if (!hasDigits || !hasUpperCase) {
                          //     return 'Le mot de passe doit contenir au moins une lettre majuscule et un chiffre.';
                          //   }
                          //   return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Mot de passe',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Action pour mot de passe oublié
                            },
                            child: Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(
                                color: const Color.fromARGB(162, 0, 0, 0),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = emailcontroller.text;
                                password = passwordcontroller.text;
                              });
                              seConnecter();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5E0707),
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
