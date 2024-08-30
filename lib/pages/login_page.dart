// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ticket_app_odk/pages/connection_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // L'image de fond
          Positioned.fill(
            child: Image.asset(
              'lib/images/welcome.png', // Chemin de votre image de fond
              fit: BoxFit.cover, // Ajuste l'image pour couvrir tout l'écran
            ),
          ),
          // Le reste du contenu
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Espace de 50 pixels en haut
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'lib/images/welcomechoco.png', // Remplacez par le chemin de votre image
                    width: 385,
                    height: 380,
                  ),
                ),
              ),
              // Espace entre l'image et le texte
              // SizedBox(height: 0),
              // // Le texte centré sous l'image
              // Center(
              Padding(padding: const EdgeInsets.only(top: 0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bienvenue dans \n',
                        style: TextStyle(
                          fontSize: 40,
                          height: 1.5,
                          color: Color(0xFF5E0707), // Couleur rouge foncé (Hex #5E0707)
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'l’app TicketP4 \n',
                        style: TextStyle(
                          fontSize: 32,
                          height: 1.5,
                          color: Colors.grey, // Couleur grise
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0), // Marge de 20 pixels en haut
                          child: Text(
                            'Besoin d\'assistance ? Transformez vos \n demandes en solutions en un temps record.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.grey, // Couleur grise
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Espacement flexible
              
              // Le bouton "Se connecter"
              Padding(
                padding: const EdgeInsets.only(top: 60), 
                child: SizedBox(
                  width: 249,
                  height: 48,
                  child: ElevatedButton(
                     onPressed: () {
                      // Within the `FirstRoute` widget:
                         Navigator.push(
                            context,
                              MaterialPageRoute(builder: (context) =>  ConnectionPage()),
                            );
                      // Devrait imprimer dans la console
                      // Action du bouton
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5E0707), // Couleur de fond #5E0707
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Coins arrondis
                      ),
                    ),
                    child: Text(
                      'Se connecter',
                      style: TextStyle(
                        color: Colors.white, // Couleur du texte en blanc
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
