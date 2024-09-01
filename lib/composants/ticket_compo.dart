// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TicketCompo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'kejfbz zkdkz zjebdzd*4 ejfbz zkdkz zjebdzd*4ejfb zkdkz zjebdzd*4 ejfbz zkdkz zjebdzd*4ejfbz zkdkz zjebdzd*4 béviydvv c z edv zd edvd ejfbz zkdkz zjebdzd*4cbeehec ejc z zkdkz zjebdzd*4 béviydvv c z edv zd edvd ejfbz zkdkz zjebdzd*4cbeehec ejc ',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('en_attente',
                style: TextStyle(
                  color: const Color.fromARGB(255, 11, 77, 13),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 16
                ),),
                Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF5E0707),
                ),
                  child: Text('Pratique',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    backgroundColor: Color(0xFF5E0707),
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic
                  ),
                  ),
                ),
                Text('Adama Konaté',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
