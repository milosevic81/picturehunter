import 'dart:convert';

import 'package:flutter/services.dart';

class Repo {

  static List _levels;

  static Future<List> loadAsset() async {
    _levels = await rootBundle
        .loadString('assets/levels.json')
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static List allLevels() => _levels;

  static Map level(int id) => _levels.firstWhere((x) => x["id"] == id);

  static question(int levelId, int questionId) =>
      level(levelId)["questions"].firstWhere((x) => x["id"] == questionId);
}
