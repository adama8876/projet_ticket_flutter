import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RapportAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Utilisateurs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucun utilisateur trouvé'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text('${user['firstName']} ${user['lastName']}'),
                subtitle: Text('Email: ${user['email']}\nRôle: ${user['role']}\nContact: ${user['contact']}'),
                isThreeLine: true,
              );
            },
          );
        },
      ),
    );
  }
}
