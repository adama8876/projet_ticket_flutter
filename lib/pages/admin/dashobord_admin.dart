// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashobordAdmin extends StatelessWidget {
  const DashobordAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF5E0707),
        title: Text(
          'Dashboard Admin12',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:  SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
               child: Row(
                children: [
                Icon(FontAwesomeIcons.ticket,
                size: 80,
                  color: Color(0xFF5E0707),
                ),
                ],
              ),
              width: 280,
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color.fromARGB(129, 94, 7, 7),
                
                width: 2)
              ),
              margin: const EdgeInsets.only(top: 30, left: 20,),
              height: 120,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
                Container(
                  // width: 150,
                  width: 150,
                  // color: const Color.fromARGB(255, 244, 54, 54),
                  margin: EdgeInsets.only(left: 15),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '12533456',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                          
                        ),
                        TextSpan(
                          
                          text: '\nUtilisateurs',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                )
               
                
                ],
              ),
              width: 280,
              foregroundDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // color: Colors.red,
                borderRadius: BorderRadius.circular(25),
                
                
              ),
              margin: const EdgeInsets.only(top: 30, left: 20),
              height: 120,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.red,
                
              ),
            ),
            
          ],
        ),
      )
      
    );
  }
}