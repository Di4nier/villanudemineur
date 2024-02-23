import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:villanudemineur/widgets/button.dart';
import 'package:villanudemineur/model/grille.dart';

class RanksScreen extends StatelessWidget {
  const RanksScreen({super.key});

  // Construction de l'UI du Widget Quiz
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Démineur - Ranks',
          style: TextStyle(
            color: Colors.white, // Change text color
            fontFamily: 'poppins', // Change font family
          ),
        ),
        backgroundColor: Color(0xFF090B22),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the back arrow
        ), // Remove app bar shadow
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF090B22),
              Color(0xFF090B22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Back to Screen 1'),
          ),
        ),
      ),
    );
  }
}
