// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_odk/pages/add%20et%20auth/connection_page.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedRole;

  Future<void> _addUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final contact = _contactController.text.trim();
      final role = _selectedRole;

      if (role != null) {
        try {
          // Créez l'utilisateur dans Firebase Authentication
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Obtenez l'UID de l'utilisateur
          String uid = userCredential.user?.uid ?? '';

          // Ajoutez des informations supplémentaires à Firestore
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'email': email,
            'role': role,
            'firstName': firstName,
            'lastName': lastName,
            'contact': contact,
          });

          // Affichez un message de succès
          ScaffoldMessenger.of(context).showSnackBar(
           
            SnackBar(content: Text('Utilisateur ajouté avec succès')),
          );

          // Réinitialisez les champs du formulaire
          _emailController.clear();
          _passwordController.clear();
          _firstNameController.clear();
          _lastNameController.clear();
          _contactController.clear();
          setState(() {
            _selectedRole = null;
          });
        } catch (e) {
          print('Erreur : $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'ajout de l\'utilisateur')),
          );
        }
      }
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Après déconnexion, redirigez vers la page de connexion
 Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => ConnectionPage()));    } catch (e) {
      print('Erreur lors de la déconnexion : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Utilisateur'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: 'Prénom',
                    hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(157, 158, 158, 158),
                      ),
                    fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le prénom';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: 'nom ',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(157, 158, 158, 158),
                      ),
                    fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le nom';
                      }
                      return null;
                    },
                    
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _contactController,
                    decoration: InputDecoration(
                      hintText: 'Contact',
                      
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(157, 158, 158, 158),
                      ),
                    fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer le contact';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'email',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(157, 158, 158, 158),
                      ),
                    fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'mot de passe',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(157, 158, 158, 158),
                      ),
                    fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un mot de passe';
                      }
                      if (value.length < 6) {
                        return 'Le mot de passe doit contenir au moins 6 caractères';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),

                  DropdownButtonFormField<String>(
                    dropdownColor: Color.fromARGB(226, 94, 7, 7),
                    value: _selectedRole,
                    decoration: InputDecoration(
                      hintText: 'veuillez selectionner le rôle',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(157, 158, 158, 158),
                      ),
                    fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Color(0xFF5E0707),
                                width: 2.0,
                              ),
                            ),
                    ),
                    items: ['Apprenant', 'Formateur', 'Admin']
                        .map((role) => DropdownMenuItem<String>(
                              value: role.toLowerCase(),
                              child: Center(
                                child: Text(role,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                ),),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez sélectionner un rôle';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: double.infinity ,
                    color: Color(0xFF5E0707),
                    
                    child: ElevatedButton(
                      onPressed: _addUser,
                      child: Text('Ajouter',
                      style: TextStyle(
                        color:  Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      ),
                      
                      style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(Color(0xFF5E0707),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




// decoration: InputDecoration(
//                             hintText: 'Email',
//                             filled: true,
//                             fillColor: Colors.white.withOpacity(0.8),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(
//                                 color: Color(0xFF5E0707),
//                                 width: 2.0,
//                               ),
//                             ),
//                             prefixIcon: Icon(
//                               Icons.email,
//                               color: Colors.grey,
//                             ),
//                           ),