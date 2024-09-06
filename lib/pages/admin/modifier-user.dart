import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModifierUtilisateurPage extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;

  ModifierUtilisateurPage({required this.userId, required this.userData});

  @override
  _ModifierUtilisateurPageState createState() => _ModifierUtilisateurPageState();
}

class _ModifierUtilisateurPageState extends State<ModifierUtilisateurPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController contactController;

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs avec les valeurs actuelles de l'utilisateur
    firstNameController = TextEditingController(text: widget.userData['firstName']);
    lastNameController = TextEditingController(text: widget.userData['lastName']);
    contactController = TextEditingController(text: widget.userData['contact'].toString());

  }

  @override
  void dispose() {
    // Libérer les ressources des contrôleurs
    firstNameController.dispose();
    lastNameController.dispose();
    contactController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    try {
      // Mise à jour des informations de l'utilisateur dans Firestore
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'contact': contactController.text,
      });

      // Affichage d'un message de confirmation
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Les informations de l\'utilisateur ont été mises à jour')),
        );

        // Retourner à l'écran précédent après la mise à jour
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Gérer les erreurs éventuelles
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la mise à jour : $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios,
        color: Colors.white,), // Remplacez par l'icône de votre choix
        onPressed: () {
            Navigator.of(context).pop(); // Action de retour
          },),


        title: Text('Modifier Utilisateur infos ',
        style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white
        ),),
        backgroundColor: Color(0xFF5E0707),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'Prénom',
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
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Nom',
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
                    ),
                    SizedBox(height: 30,),
                    
                  TextFormField(
                    controller: contactController,
                    decoration: InputDecoration(labelText: 'Contact',
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
                    ),
                  
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5E0707),
                    ),
                    child: Text('Enregistrer les modifications',
                    style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white,
                      
                    ),),
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
