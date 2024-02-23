import 'package:flutter/material.dart';
import 'package:villanudemineur/model/grille.dart' as model;

class GrilleScreen extends StatefulWidget {
  final int taille, nbMines;

  const GrilleScreen(this.taille, this.nbMines, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GrilleScreenState();
}

class _GrilleScreenState extends State<GrilleScreen> {
  late model.Grille _grille;

  @override
  void initState() {
    _grille = model.Grille(taille: widget.taille, nbMines: widget.nbMines);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Démineur - Game',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: const Color(0xFF090B22),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: CreationGrille(5),
      ),
    );
  }

  Widget CreationGrille(int taille) {
    List<Widget> lines = [];

    for (int line = 0; line < taille; line++) {
      List<Widget> columns = [];

      for (int column = 0; column < taille; column++) {
        columns.add(
          ElevatedButton(
            onPressed: () {
              // Add functionality here when the button is pressed
              // For example, you can call a method or navigate to another screen
            },
            child: Text("1"),
          ),
        );
      }

      lines.add(
        Row(
          children: columns,
        ),
      );
    }

    return Column(
      children: lines,
    );
  }
}
