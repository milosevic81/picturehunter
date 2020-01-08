import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/level.dart';
import '../models/level_state.dart';
import '../models/question.dart';
import '../models/question_state.dart';

class Repo {
  static List<Level> _levels;

  static SharedPreferences prefs;

  static Future<void> loadAsset() async {
    prefs = await SharedPreferences.getInstance();

    // Load assets json file to List
    List levelsJson = await rootBundle
        .loadString('assets/levels.json')
        .then((jsonStr) => jsonDecode(jsonStr));

    // Convert dynamic to List<Level>
    _levels = levelsJson
        .map((x) => Level.fromJson(x))
        .where((x) => x.questions.length > 0)
        .toList();

    // Sort levels by order
    _levels.sort((x, y) => x.order.compareTo(y.order));

    // Attach level state and question state
    _levels.forEach((level) {
      level.state = _loadOrCreateLevelState(level.id);
      level.questions.forEach((question) {
        question.state = _loadOrCreateQuestionState(level.id, question.id);
      });
    });
  }

  static List<Level> allLevels() => _levels;

  static Level level(String id) =>
    allLevels().firstWhere((x) => x.id == id);

  static Question question(String levelId, String questionId) =>
    level(levelId).questions.firstWhere((x) => x.id == questionId);

  static void incrementAttempts(Question question) {
    question.state.incrementAttempts();
    _storeQuestionState(question.state);
  }

  static void setSolution(Question question, String levelId, text) {
    question.state.setSolution(text);
    _storeQuestionState(question.state);
    _incrementQuestionsSolved(levelId);
  }

  static QuestionState _loadOrCreateQuestionState(
      String levelId, String questionId) {
    if (Repo.prefs.containsKey(questionId)) {
      final jsonStr = Repo.prefs.getString(questionId);
      final Map parsed = json.decode(jsonStr);
      return QuestionState.fromJson(parsed);
    }
    return QuestionState(levelId, questionId);
  }

  static LevelState _loadOrCreateLevelState(String levelId) {
    if (Repo.prefs.containsKey(levelId)) {
      final jsonStr = Repo.prefs.getString(levelId);
      final Map parsed = json.decode(jsonStr);
      return LevelState.fromJson(parsed);
    }
    return LevelState(levelId);
  }

  static void _storeQuestionState(QuestionState questionState) {
    Repo.prefs.setString(questionState.questionId, jsonEncode(questionState));
  }

  static void _storeLevelState(LevelState levelState) {
    Repo.prefs.setString(levelState.levelId, jsonEncode(levelState));
  }

  static Level previousLevel(String levelId) {
    final current = level(levelId);
    final index = allLevels().indexOf(current);
    if (index == 0) return null;
    return allLevels()[index - 1];
  }

  static void _incrementQuestionsSolved(String levelId) {
    final state = level(levelId).state;
    state.incrementSolved();
    _storeLevelState(state);
  }
}
