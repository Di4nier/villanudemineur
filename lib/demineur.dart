import 'package:flutter/material.dart';
import 'package:villanudemineur/model/grille.dart';
import 'package:villanudemineur/screens/AccueilScreen.dart';
import 'package:villanudemineur/screens/GrilleScreen.dart';
import 'package:villanudemineur/screens/score.dart';

// Widget principal qui gère l'état de toute l'application
// et affiche soit StartScreen, soit QuestionsScreen, soit ResultsScreen
class Demineur extends StatefulWidget {
  // Contructeur
  const Demineur({super.key});
  // Instanciation de l'état _QuizState associé au widget Quiz
  @override
  State<Demineur> createState() {
    return _DemineurState();
  }
}

// Les différents types de Screen à afficher
enum ScreenState { start, game, results }

// L'état associé au widget Quiz
class _DemineurState extends State<Demineur> {
  // Les questions du Quiz
  // final theQuestions=List<Grille>.from(questions);
  // La liste des réponses sélectionnés par le joueur
  final List<String> selectedAnswers = [];
  // Pour savoir quel widget afficher
  ScreenState screenState = ScreenState.start;
  // StopWatch
  final stopWatch = Stopwatch();

  // Méthode appelée depuis StartScreen pour "naviguer" vers QuestionsScreen
  void startGame() {
    setState(() {
      selectedAnswers.clear(); // on vide la liste des réponses
      screenState = ScreenState.game; // on va afficher QuestionScreen
    });
  }

  // Méthode appelée depuis QuestionsScreen pour enregistrer une nouvelle réponse
  // et "naviguer" vers ResultsScreen si toutes les réponses ont été données
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    // if (selectedAnswers.length == questions.length) {
    //   // Si toutes les réponses...
    //   setState(() {
    //     screenState = ScreenState.results; // on va afficher ResultsScreen
    //   });
    // }
  }

  // Méthode appelée depuis ResultsScreen pour "naviguer" vers StartScreen
  void reStartGame() {
    setState(() {
      screenState = ScreenState.start; // On va afficher StartScreen
    });
  }

  // Retourne le widget à afficher selon l'état (valeur de screenState)
  Widget chooseScreenWidget() {
    switch (screenState) {
      case ScreenState.start:
        {
          return AccueilScreen(startGame);
        }
      case ScreenState.game:
        {
          // return QuestionsScreen(
          //   theQuestions: theQuestions,
          //   onSelectAnswer: chooseAnswer,
          // );
          return AccueilScreen(startGame);
        }
      case ScreenState.results:
        {
          // return ResultsScreen(
          //   theQuestions: theQuestions,
          //   chosenAnswers: selectedAnswers,
          //   onRestart: reStartQuiz,
          // );
          return AccueilScreen(startGame);
        }
    }
  }

  // Construction de l'UI du Widget Quiz
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
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
          child: chooseScreenWidget(),
        ),
      ),
    );
  }
}
