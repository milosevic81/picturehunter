import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:picturehunter/model/LevelData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/QuestionData.dart';

class Repo {
  static List<LevelData> _levels;

  static SharedPreferences prefs;

  static Future<void> loadAsset() async {
    List levelsJson = await rootBundle
        .loadString('assets/levels.json')
        .then((jsonStr) => jsonDecode(jsonStr));

    _levels = levelsJson
        .map((x) => LevelData.fromJson(x))
        .where((x) => x.questions.length > 0)
        .toList();

    _levels.sort((x, y) => x.order.compareTo(y.order));

    prefs = await SharedPreferences.getInstance();
  }

  static List<LevelData> allLevels() => _levels;

  static LevelData level(String id) => _levels.firstWhere((x) => x.id == id);

  static QuestionData question(String levelId, String questionId) =>
      level(levelId).questions.firstWhere((x) => x.id == questionId);
}
