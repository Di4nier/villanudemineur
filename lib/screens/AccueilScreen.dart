import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:villanudemineur/screens/RanksScreen.dart';
import 'package:villanudemineur/screens/GrilleScreen.dart';

class AccueilScreen extends StatelessWidget {
  // La fonction du Widget Quiz à appeler pour naviguer vers QuestionScreen
  final void Function() startQuiz;

  // Constructeur
  const AccueilScreen(this.startQuiz, {super.key});

  // Construction de l'UI du Widget StartScreen
  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo_demineur.jpeg',
            width: 300,
          ),
          const SizedBox(height: 30),
          Text(
            'VillanuDémineur',
            style: GoogleFonts.poppins(
              color: const Color(0xFFFFFFFF),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 40),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.child_care_rounded),
            label: const Text('Facile : 5x5 | 3 mines 💣'),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const GrilleScreen(5, 5)),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.man_rounded),
            label: const Text('Moyen : 7x7 | 5 mines 💣'),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.local_fire_department_rounded),
            label: const Text('Difficile : 10x10 | 10 mines 💣'),
          ),
          const SizedBox(height: 15),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const RanksScreen()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.stadium),
            label: const Text('Classement'),
          ),
        ],
      ),
    );
  }
}
