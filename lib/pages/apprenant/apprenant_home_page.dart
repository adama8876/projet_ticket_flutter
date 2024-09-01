// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ticket_app_odk/composants/categorie_compo.dart';
import 'package:ticket_app_odk/composants/ticket_compo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Icon(Icons.message, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
          Icon(Icons.dashboard, color: Colors.white),
        ],
      ),
      appBar: AppBar(
        title: Text(
          'TicketP4',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF5E0707),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 35, right: 30, left: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un ticket...',
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                contentPadding: EdgeInsets.only(left: 20),
                suffixIcon: Transform.rotate(
                  angle: -5,
                  child: Icon(
                    color: Color(0xFF5E0707),
                    size: 26,
                    Icons.search,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFF5E0707), width: sqrt1_2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFF5E0707)),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                'lib/images/assistancia.png', // Remplacez par le chemin de votre image
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Categories',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategorieCompo(
                  text: 'Théorique',
                  onPressed: () {},
                ),
                CategorieCompo(
                  text: 'Pratique',
                  onPressed: () {},
                ),
                CategorieCompo(
                  text: 'SpringBoot',
                  onPressed: () {},
                ),
                CategorieCompo(
                  text: 'Questionnaires',
                  onPressed: () {},
                ),
                CategorieCompo(
                  text: 'Programmation',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Ajoute un Expanded ici pour que la liste des TicketCompo prenne tout l'espace restant
          Expanded(
            child: ListView(
              children: [
                TicketCompo(),
                TicketCompo(),
                TicketCompo(),
                TicketCompo(),
                TicketCompo(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
