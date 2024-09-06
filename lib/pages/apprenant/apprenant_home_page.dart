import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ticket_app_odk/composants/categorie_compo.dart';
import 'package:ticket_app_odk/composants/modal_ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticket_app_odk/pages/apprenant/tickets/ticket_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Map<String, dynamic>>> fetchTicketsWithDetails() async {
    final firestore = FirebaseFirestore.instance;
    final ticketsSnapshot = await firestore.collection('tickets').get();
    final List<Map<String, dynamic>> ticketsWithDetails = [];

    for (var ticketDoc in ticketsSnapshot.docs) {
      var ticketData = ticketDoc.data() as Map<String, dynamic>;
      String categoryName = 'Unknown';
      String userEmail = 'Unknown Email';

      if (ticketData['categoryId'] is String) {
        final categorySnapshot = await firestore.collection('categories').doc(ticketData['categoryId']).get();
        categoryName = (categorySnapshot.data() as Map<String, dynamic>?)?['nom'] ?? 'Unknown';
      } else if (ticketData['categoryId'] is DocumentReference) {
        final categorySnapshot = await (ticketData['categoryId'] as DocumentReference).get();
        categoryName = (categorySnapshot.data() as Map<String, dynamic>?)?['nom'] ?? 'Unknown';
      }

      if (ticketData['userId'] is String) {
        final userSnapshot = await firestore.collection('users').doc(ticketData['userId']).get();
        userEmail = (userSnapshot.data() as Map<String, dynamic>?)?['email'] ?? 'Unknown Email';
      }

      ticketData.addAll({'categoryName': categoryName, 'userEmail': userEmail});
      ticketsWithDetails.add(ticketData);
    }

    return ticketsWithDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (_) => TicketModal()),
        backgroundColor: Color(0xFF5E0707),
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un ticket...',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 20),
                suffixIcon: Transform.rotate(angle: -5, child: Icon(Icons.search, color: Color(0xFF5E0707), size: 26)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Color(0xFF5E0707), width: sqrt1_2)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Color(0xFF5E0707))),
              ),
            ),
          ),
          Center(child: Padding(padding: EdgeInsets.only(top: 20), child: Image.asset('lib/images/assistancia.png'))),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Théorique', 'Pratique', 'SpringBoot', 'Questionnaires', 'Programmation']
                  .map((text) => CategorieCompo(text: text, onPressed: () {})).toList(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchTicketsWithDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (snapshot.hasError) return Center(child: Text('Erreur : ${snapshot.error}'));
                if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('Aucun ticket disponible'));

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final ticket = snapshot.data![index];
                    final title = ticket['title'] ?? 'No Title';
                    final status = ticket['status'] ?? 'No Status';
                    final categoryName = ticket['categoryName'] ?? 'Unknown';
                    final userEmail = ticket['userEmail'] ?? 'Unknown Email';

                    return Card(
  elevation: 4,
  margin: EdgeInsets.all(16),
  child: InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketDetails(ticket: ticket),
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
                          : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
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
        ],
      ),
    ),
  ),
);

                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}