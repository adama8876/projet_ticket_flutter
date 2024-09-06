import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'formateur_ticket_detail.dart';

class FormateurAccueil extends StatefulWidget {
  const FormateurAccueil({Key? key}) : super(key: key);

  @override
  _FormateurAccueilState createState() => _FormateurAccueilState();
}

class _FormateurAccueilState extends State<FormateurAccueil> {
  String? statusFilter;

  // Mettre à jour le statut du ticket et réserver au formateur actuel
  Future<void> updateTicketStatus(String ticketId, String newStatus, String formateurId) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('tickets').doc(ticketId).update({
      'status': newStatus,
      'formateurId': formateurId, // Associe le ticket au formateur actuel
    });
  }

  Future<List<Map<String, dynamic>>> fetchTicketsWithDetails() async {
    final firestore = FirebaseFirestore.instance;
    final ticketsRef = firestore.collection('tickets');

    Query query = ticketsRef;
    if (statusFilter != null) {
      query = query.where('status', isEqualTo: statusFilter);
    }

    final ticketsSnapshot = await query.get();
    final List<Map<String, dynamic>> ticketsWithDetails = [];

    for (var ticketDoc in ticketsSnapshot.docs) {
      var ticketData = ticketDoc.data() as Map<String, dynamic>;
      String categoryName = 'Unknown';
      String userEmail = 'Unknown Email';
      String formateurName = 'Unknown Formateur';
      String formateurFirstName = 'Unknown Formateur First Name';

      // Get category name
      if (ticketData['categoryId'] is String) {
        final categorySnapshot = await firestore.collection('categories').doc(ticketData['categoryId']).get();
        categoryName = (categorySnapshot.data() as Map<String, dynamic>?)?['nom'] ?? 'Unknown';
      } else if (ticketData['categoryId'] is DocumentReference) {
        final categorySnapshot = await (ticketData['categoryId'] as DocumentReference).get();
        categoryName = (categorySnapshot.data() as Map<String, dynamic>?)?['nom'] ?? 'Unknown';
      }

      // Get user email
      if (ticketData['userId'] is String) {
        final userSnapshot = await firestore.collection('users').doc(ticketData['userId']).get();
        userEmail = (userSnapshot.data() as Map<String, dynamic>?)?['email'] ?? 'Unknown Email';
      }

      // Get formateur name
      if (ticketData['formateurId'] is String) {
        final formateurSnapshot = await firestore.collection('users').doc(ticketData['formateurId']).get();
        formateurName = (formateurSnapshot.data() as Map<String, dynamic>?)?['lastName'] ?? 'Unknown Formateur';
        formateurFirstName = (formateurSnapshot.data() as Map<String, dynamic>?)?['firstName'] ?? 'Unknown Formateur First Name';
      }

      ticketData.addAll({
        'categoryName': categoryName,
        'userEmail': userEmail,
        'formateurName': formateurName, // Add formateur name
        'id': ticketDoc.id, // Add document ID
        'formateurFirstName': formateurFirstName, // Add formateur first name
      });
      ticketsWithDetails.add(ticketData);
    }

    return ticketsWithDetails;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser; // Utilisateur connecté (formateur)

    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil Formateur', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF5E0707),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                statusFilter = value;
              });
            },
            itemBuilder: (context) {
              return ['en_attente', 'en_cours', 'terminé']
                  .map((status) => PopupMenuItem<String>(
                        value: status,
                        child: Text(status),
                      ))
                  .toList();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTicketsWithDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun ticket disponible'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final ticket = snapshot.data![index];
              final title = ticket['title'] ?? 'No Title';
              final status = ticket['status'] ?? 'No Status';
              final categoryName = ticket['categoryName'] ?? 'Unknown';
              final userEmail = ticket['userEmail'] ?? 'Unknown Email';
              final formateurName = ticket['formateurName'] ?? 'Unknown Formateur';
              final formateurFirstName = ticket['formateurFirstName'] ?? 'Unknown Formateur First Name';
              final ticketFormateurId = ticket['formateurId'];

              return Card(
                elevation: 4,
                margin: EdgeInsets.all(16),
                child: InkWell(
                  onTap: () async {
  // Vérifie si le ticket est déjà réservé par un autre formateur
  if (ticketFormateurId != null && ticketFormateurId != currentUser?.uid) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ce ticket est déjà réservé par un autre formateur.'),
      ),
    );
    return; // Sortir si le ticket est déjà réservé
  }

  // Si le ticket n'est pas "terminé", on change le statut en "en_cours"
  if (ticket['status'] != 'terminé') {
    await updateTicketStatus(ticket['id'], 'en_cours', currentUser!.uid);
    setState(() {}); // Rafraîchir la liste des tickets après la mise à jour
  }

  // Naviguer vers les détails du ticket, peu importe le statut
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FormateurTicketDetail(
        ticket: ticket,
      ),
    ),
  );
},

                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userEmail,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          title,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              status,
                              style: TextStyle(
                                color: status == 'en_attente'
                                    ? Color.fromARGB(255, 11, 77, 13)
                                    : status == 'terminé'
                                        ? Colors.red
                                        : const Color.fromARGB(255, 146, 133, 18),
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF5E0707),
                              ),
                              child: Text(
                                categoryName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        if (formateurName != 'Unknown Formateur') // Show formateur's name if available
                          Text(
                            'Répondu par: \n$formateurFirstName $formateurName',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
