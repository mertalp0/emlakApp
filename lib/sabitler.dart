import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sabitler {
  static const MaterialColor primarySwatch = Colors.indigo;
  static Color anaRenk = Colors.indigo;
  
  static Color selectedItemColor = Colors.white;
  static Color anaRenkshade50 = Colors.indigo.shade50;
  static Color yaziRengi1 = Colors.black;
  static Color yaziRengi2 = Colors.white;
  static Color iconRengi1 = Colors.indigo;
  static Color iconRengi2 = Colors.black;
  static TextStyle baslikFont = GoogleFonts.lilitaOne(fontSize: 40);
  static TextStyle baslikFont2 = GoogleFonts.permanentMarker(fontSize: 40);
 
  static TextStyle yaziFont1 = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.black
  );
  static TextStyle yaziFont2 = GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 16);
  static TextStyle cardTextStyle =
      GoogleFonts.kanit(color: Colors.black,fontSize: 18, fontWeight: FontWeight.w500);
}
