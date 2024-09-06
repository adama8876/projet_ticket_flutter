import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import pour Firebase Auth

class FormateurTicketDetail extends StatefulWidget {
  final Map<String, dynamic> ticket;

  const FormateurTicketDetail({Key? key, required this.ticket}) : super(key: key);

  @override
  _FormateurTicketDetailState createState() => _FormateurTicketDetailState();
}

class _FormateurTicketDetailState extends State<FormateurTicketDetail> {
  final TextEditingController _reponseController = TextEditingController();

  Future<void> repondreTicket(String ticketId, String reponse) async {
    if (ticketId.isEmpty) {
      print('Erreur : ID du ticket non valide.');
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser; // Récupère l'utilisateur actuel (formateur)

    if (user == null) {
      print('Erreur : Aucun utilisateur connecté.');
      return;
    }

    String formateurId = user.uid; // ID du formateur connecté

    try {
      await firestore.collection('tickets').doc(ticketId).update({
        'status': 'terminé',
        'formateurId': formateurId, // Utilise l'ID du formateur connecté
        'reponse': reponse,
      });
    } catch (e) {
      print('Erreur lors de la mise à jour du ticket : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;
    final String ticketId = ticket['id'] ?? 'Unknown ID';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
         onPressed: () {
            Navigator.pop(context); // Retour en arrière
          },
        ),
        centerTitle: true,
        title: Text(
          'Détails du Ticket',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF5E0707),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Titre: ${ticket['title'] ?? 'No Title'}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, wordSpacing: 1 , fontStyle: FontStyle.italic, ),
                textAlign: TextAlign.justify ,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10.0),
                // color: Color(0xFF5E0707) ,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text('Status: ${ticket['status'] ?? 'No Status'}', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, wordSpacing:2))),
              SizedBox(height: 10),
              Text('Description: \n\n ${ticket['description'] ?? 'No Description'}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              if (ticket['status'] == 'en_attente' || ticket['status'] ==  'en_cours') ...[
                TextField(
                  controller: _reponseController,
                  decoration: InputDecoration(
                    hintText: 'Votre réponse...',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String reponse = _reponseController.text;
                    if (reponse.isNotEmpty) {
                      await repondreTicket(ticketId, reponse);
                      Navigator.pop(context); // Retour à la liste après réponse
                    }
                  },
                  child: Text('Répondre'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5E0707),
                  ),
                ),
              ],
              if (ticket['reponse'] != null)
                Text('Réponse:\n\n ${ticket['reponse']}', style: TextStyle(color: Colors.black, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
