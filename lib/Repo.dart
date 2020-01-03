import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Repo {

  static Future<List> loadAsset() async {
    var jsonData = rootBundle.loadString('levels_assets/levels.json').then((jsonStr) => jsonDecode(jsonStr));
    return jsonData;
  }

  static Future<List> _levels = loadAsset();

  static Future<List> allLevels() => _levels;

  static Future<Map> level(int id) async => (await _levels).firstWhere((x) => x["id"] == id);

  static question(int levelId, int questionId) async =>
      (await level(levelId))["questions"].firstWhere((x) => x["id"] == questionId);
}
