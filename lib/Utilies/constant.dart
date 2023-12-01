import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virzanpay/Utilies/color.dart';

const double toolBarHeight = 60;

Widget logotitle = Pulse(
  child: Align(
    child: Text(
      "MATKA",
      style: GoogleFonts.lato(
        fontSize: 35,
        color: Materialcolor.firstColor,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

//font size
const double authbuttonradius = 20;
const double welcomefontSize = 33;
const double labelfontSize = 14;

//color
const Color backgroundColor = Color(0xFFFC8181);

//local database

late SharedPreferences sharedPreferences;
