import 'dart:collection';

import 'package:flutter/cupertino.dart';

class LevelModel {

  final Map<String, LevelState> _levelStates = {};

  /// An unmodifiable view of the level states
  UnmodifiableMapView<String, LevelState> get levelStates => UnmodifiableMapView(_levelStates);

//  /// The current total price of all items (assuming all items cost $42).
//  int get totalPrice => _items.length * 42;
//
//  /// Adds [item] to cart. This is the only way to modify the cart from outside.
//  void add(Item item) {
//    _items.add(item);
//    // This call tells the widgets that are listening to this model to rebuild.
//    notifyListeners();
//  }
}

class LevelState extends ChangeNotifier {

  bool locked;
  int remaining;

  void unlock() {
    locked = false;
    notifyListeners();
  }
}

//rebuildclass Dog {
//  final int id;
//  final String name;
//  final int age;
//
//  Dog({this.id, this.name, this.age});
//
//  Map<String, dynamic> toMap() {
//    return {
//      'id': id,
//      'name': name,
//      'age': age,
//    };
//  }
//
//  // Implement toString to make it easier to see information about
//  // each dog when using the print statement.
//  @override
//  String toString() {
//    return 'Dog{id: $id, name: $name, age: $age}';
//  }
//}