
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    'icon': const FaIcon(
      FontAwesomeIcons.film,
      size: 25,
      color: Colors.white,
    ),
    'color': Colors.purple,
    'name': 'Movie',
    'totalAmount': '-\₹300',
    'date': "Today"
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.shoppingBag,
        size: 25, color: Colors.white),
    'color': Colors.blue,
    'name': 'Shoping',
    'totalAmount': '-\₹200',
    'date': "Today"
  },
  {
    'icon':
        const FaIcon(FontAwesomeIcons.burger, size: 25, color: Colors.white),
    'color': Colors.yellow[700],
    'name': 'Food',
    'totalAmount': '-\₹100',
    'date': "Today"
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.plane, size: 25, color: Colors.white),
    'color': Colors.green,
    'name': 'Travel',
    'totalAmount': '-\₹200',
    'date': "Today"
  },
  {
    'icon': const FaIcon(FontAwesomeIcons.shoppingBag,
        size: 25, color: Colors.white),
    'color': Colors.blue,
    'name': 'Shoping',
    'totalAmount': '-\₹200',
    'date': "Today"
  },
];


