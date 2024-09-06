

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticket_app_odk/pages/formateur/formateur_Accueil.dart';
import 'package:ticket_app_odk/pages/formateur/formateur_discussion.dart';
import 'package:ticket_app_odk/pages/formateur/formateur_ticket.dart';


class FormateurPage extends StatefulWidget {
  const FormateurPage({super.key});

  @override
  _FormateurPageState createState() => _FormateurPageState();
}

class _FormateurPageState extends State<FormateurPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
   FormateurAccueil(),
   FormateurTicket(),
   FormateurDiscussion()
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
          Icon(Icons.home, color: Colors.white),
          Icon(FontAwesomeIcons.ticket, color: Colors.white),
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





