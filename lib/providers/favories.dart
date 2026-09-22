import 'package:flutter/material.dart';
import '../models/item.dart';

class Favories with ChangeNotifier {
  final List<Item> _items = [];

  List<Item> get items => _items;

  void add(Item item) {
    if (!_items.contains(item)) {
      _items.add(item);
      notifyListeners();
    }
  }

  void remove(Item item) {
    if (_items.contains(item)) {
      _items.remove(item);
      notifyListeners();
    }
  }

  int get count => _items.length;

  bool isFavorite(Item item) {
    return _items.contains(item);
  }
}
