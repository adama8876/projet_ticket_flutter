// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ticket_app_odk/pages/admin/add_user.dart';
import 'package:ticket_app_odk/pages/admin/dashobord_admin.dart';
import 'package:ticket_app_odk/pages/admin/rapport_admin.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashobordAdmin(), // Page d'accueil de l'admin
    AddUserPage(), // Page pour ajouter des utilisateurs
    RapportAdmin(), // Exemple de page pour voir la liste des utilisateurs
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF5E0707),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color(0xFF5E0707),
        items: [
          Icon(Icons.dashboard_customize, color: Colors.white),
          Icon(Icons.person_3_outlined, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _pages[_selectedIndex],
    );
  }
}





