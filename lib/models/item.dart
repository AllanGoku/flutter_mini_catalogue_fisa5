import 'package:flutter/material.dart';

class Item {
  final String title;
  final String description;
  final Icon icon;
  final String price;

  const Item({
    required this.title,
    required this.description,
    required this.icon,
    required this.price,
  });
}
