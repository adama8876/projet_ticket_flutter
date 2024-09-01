import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TicketModal extends StatefulWidget {
  @override
  _TicketModalState createState() => _TicketModalState();
}

class _TicketModalState extends State<TicketModal> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
// ID de la catégorie sélectionnée
  String _description = '';
  List<String> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    final categorySnapshot = await FirebaseFirestore.instance.collection('categories').get();
    setState(() {
      _categories = categorySnapshot.docs.map((doc) => doc.id).toList();
      _selectedCategory = _categories.isNotEmpty ? _categories[0] : null;
    });
  }

  void _createTicket() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('tickets').add({
        'title': _title,
        'description': _description,
        'categoryId': _selectedCategory,
        'userId': userId,
        'createAt': Timestamp.now(),
        'status': 'en_attente',
      });

      Navigator.of(context).pop(); // Fermer la modale après la création du ticket
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Créer un ticket'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Titre du ticket
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Titre du ticket',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un titre';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            SizedBox(height: 16),
            // Catégorie
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Catégorie',
              ),
              value: _selectedCategory,
              items: _categories.map((categoryId) {
                return DropdownMenuItem<String>(
                  value: categoryId,
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection('categories').doc(categoryId).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final categoryName = snapshot.data!['nom'];
                        return Text(categoryName);
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              onSaved: (value) {
                _selectedCategory = value!;
              },
            ),
            SizedBox(height: 16),
            // Description
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une description';
                }
                return null;
              },
              onSaved: (value) {
                _description = value!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _createTicket,
          child: Text('Créer'),
        ),
      ],
    );
  }
}
