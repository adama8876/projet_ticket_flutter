// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategorieCompo extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CategorieCompo({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xFF5E0707),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
