// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ticket_app_odk/pages/apprenant/apprenant_home_page.dart';
import 'package:ticket_app_odk/pages/apprenant/apprenat_message.dart';
import 'package:ticket_app_odk/pages/apprenant/apprenat_settings.dart';
import 'package:ticket_app_odk/pages/apprenant/ticket_categories.dart';


class ApprenantPages extends StatefulWidget {
  const ApprenantPages({super.key});

  @override
  _ApprenantPageState createState() => _ApprenantPageState();
}

class _ApprenantPageState extends State<ApprenantPages> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    TicketCategories(),
    ApprenatMessage(), 
    ApprenatSettings(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TicketP4', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF5E0707),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF5E0707),
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color(0xFF5E0707),
    items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.airplane_ticket_outlined, color: Colors.white),
          Icon(Icons.message, color: Colors.white),
          Icon(Icons.settings, color: Colors.white)
        ],        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   color: Color(0xFF5E0707),
      //   backgroundColor: Colors.white,
      //   buttonBackgroundColor: Color(0xFF5E0707),
      //   items: [
      //     Icon(Icons.dashboard_customize, color: Colors.white),
      //     Icon(Icons.person_3_outlined, color: Colors.white),
      //     Icon(Icons.person, color: Colors.white),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
      body: _pages[_selectedIndex],
    );
  }
}





