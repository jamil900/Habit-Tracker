import 'package:flutter/material.dart';

List<String> months = [
  "",
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

enum Themes { device, light, dark }

enum DayType { clear, check, fail, skip }

class HaboColors {
  static const Color primary = Color(0xFFA459D1);
  static const Color red = Color(0xFFF266AB);
  static const Color skip = Color(0xFF2CD3E1);
  static const Color orange = Color(0xFFFF9800);
}
