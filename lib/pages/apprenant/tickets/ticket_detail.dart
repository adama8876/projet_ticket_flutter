import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TicketDetails extends StatelessWidget {
  final Map<String, dynamic> ticket;

  const TicketDetails({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Les détails du ticket',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF5E0707),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Titre: ${ticket['title'] ?? 'No Title'}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5E0707),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Status: ${ticket['status'] ?? 'No Status'}',
              style: TextStyle(fontSize: 18, color: Color(0xFF5E0707)),
            ),
            SizedBox(height: 10),
            Text(
              'Créé le: ${ticket['createAt'] != null ? (ticket['createAt'] as Timestamp).toDate().toString() : 'Unknown Date'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${ticket['description'] ?? 'No Description'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            if (ticket['reponse'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Réponse: ${ticket['reponse'] ?? 'Pas de réponse'}',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  SizedBox(height: 10),
                  if (ticket['formateurId'] != null)
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(ticket['formateurId'])
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Chargement du formateur...');
                        }
                        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                          return Text('Formateur inconnu');
                        }
                        var formateurData = snapshot.data!.data() as Map<String, dynamic>?;
                        var formateurNom = formateurData?['firstName'] ?? 'Nom inconnu';
                        var formateurPrenom = formateurData?['lastName'] ?? 'Prénom inconnu';
                        return Text('Répondu par: $formateurNom $formateurPrenom');
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
