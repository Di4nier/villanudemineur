import 'dart:math';
import 'package:villanudemineur/model/case.dart';
import 'package:villanudemineur/model/coup.dart';

/// [Grille] de démineur
class Grille {
  /// Dimension de la grille carrée : [taille]x[taille]
  final int taille;

  /// Nombre de mines présentes dans la grille
  final int nbMines;

  /// Attribut privé (_), liste composée [taille] listes de chacune [taille] cases
  final List<List<Case>> _grille = [];

  /// Construit une [Grille] comportant [taille] lignes, [taille] colonnes et [nbMines] mines
  Grille({required this.taille, required this.nbMines}) {
    int nbCasesACreer = nbCases; // Le nombre de cases qu'il reste à créer
    int nbMinesAPoser = nbMines; // Le nombre de mines qu'il reste à poser
    Random generateur = Random(); // Générateur de nombres aléatoires
    // Pour chaque ligne de la grille
    for (int lig = 0; lig < taille; lig++) {
      // On va ajouter à la grille une nouvelle Ligne (liste de 'cases')
      List<Case> uneLigne = []; //
      for (int col = 0; col < taille; col++) {
        // S'il reste nBMinesAPoser dans nbCasesACreer, la probabilité de miner est nbMinesAPoser/nbCasesACreer
        // Donc on tire un nombre aléatoire a dans [1..nbCasesACreer] et on pose une mine si a <= nbMinesAposer
        bool isMinee = generateur.nextInt(nbCasesACreer) < nbMinesAPoser;
        if (isMinee) nbMinesAPoser--; // une mine de moins à poser
        uneLigne.add(Case(isMinee)); // On ajoute une nouvelle case à la ligne
        nbCasesACreer--; // Une case de moins à créer
      }
      // On ajoute la nouvelle ligne à la grille
      _grille.add(uneLigne);
    }
    // Les cases étant créées et les mines posées, on calcule pour chaque case le 'nombre de mines autour'
    calculeNbMinesAutour();
  }

  /// Getter qui retourne le nombre de cases
  int get nbCases => taille * taille;

  /// Retourne la [Case] de la [Grille] située à [coord]
  Case getCase(Coordonnees coord) {
    return _grille[coord.ligne][coord.colonne];
  }

  /// Retourne la liste des [Coordonnees] des voisines de la case située à [coord]
  List<Coordonnees> getVoisines(Coordonnees coord) {
    List<Coordonnees> listeVoisines = [];

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int ligne = coord.ligne + i;
        int colonne = coord.colonne + j;

        if (ligne >= 0 && ligne < taille && colonne >= 0 && colonne < taille) {
          listeVoisines.add(((ligne: ligne, colonne: colonne)));
        }
      }
    }

    return listeVoisines;
  }

  /// Assigne à chaque [Case] le nombre de mines présentes dans ses voisines
  void calculeNbMinesAutour() {
    for (int lig = 0; lig < taille; lig++) {
      for (int col = 0; col < taille; col++) {
        // On récupère les mines voisines

        Case c = getCase((ligne: lig, colonne: col));
        List<Coordonnees> voisines = getVoisines((ligne: lig, colonne: col));

        int nbMines = 0;
        for (Coordonnees coord in voisines) {
          Case cs = getCase(coord);

          if (cs.minee) nbMines++;
        }

        c.nbMinesAutour = nbMines;
      }
    }
  }

  /// - Découvre récursivement toutes les cases voisines d'une case située à [coord]
  /// - La case située à [coord] doit être découverte
  void decouvrirVoisines(Coordonnees coord) {
    for (final voisine in getVoisines(coord)) {
      Case caseVoisine = getCase(voisine);
      if (caseVoisine.etat == Etat.couverte && !caseVoisine.minee) {
        caseVoisine.decouvrir();
        if (caseVoisine.nbMinesAutour == 0) {
          decouvrirVoisines(voisine);
        }
      }
    }
  }

  /// Met à jour la Grille en fonction du [coup] joué
  void mettreAJour(Coup coup) {
    Case startCase = getCase(coup.coordonnees);

    if (coup.action == Action.decouvrir) {
      startCase.etat = Etat.decouverte;
      decouvrirVoisines(coup.coordonnees);
    } else if (coup.action == Action.marquer) {
      startCase.inverserMarque();
    }
  }

  /// Renvoie vrai si [Grille] ne comporte que des cases soit minées soit découvertes (mais pas les 2)
  bool isGagnee() {
    for (int i = 0; i < taille; i++) {
      for (int j = 0; j < taille; j++) {
        if (!(_grille[i][j].minee || _grille[i][j].etat == Etat.decouverte)) {
          return false;
        }
      }
    }
    return true;
  }

  /// Renvoie vrai si [Grille] comporte au moins une case minée et découverte
  bool isPerdue() {
    for (int i = 0; i < taille; i++) {
      for (int j = 0; j < taille; j++) {
        if (_grille[i][j].minee && _grille[i][j].etat == Etat.decouverte) {
          return true;
        }
      }
    }
    return false;
  }

  /// Renvoie vrai si la partie est finie, gagnée ou perdue
  bool isFinie() {
    return isGagnee() || isPerdue();
  }
}
