import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:picturehunter/models/level.dart';
import 'package:picturehunter/models/level_state.dart';
import 'package:picturehunter/models/question.dart';
import 'package:picturehunter/models/question_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelsModel extends ChangeNotifier {
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
      level.state.locked = _isLevelLocked(level);
      level.state.remainsToUnlock = _remainsToUnlock(level);
      _storeLevelState(level.state);
      level.questions.forEach((question) {
        question.state = _loadOrCreateQuestionState(level.id, question.id);
        _storeQuestionState(question.state);
      });
    });
  }

  List<Level> allLevels() => _levels;

  Level getLevel(String id) => allLevels().firstWhere((x) => x.id == id);

  Question getQuestion(String levelId, String questionId) =>
      getLevel(levelId).questions.firstWhere((x) => x.id == questionId);

  void incrementAttempts(Question question) {
    question.state.attempts += 1;
    _storeQuestionState(question.state);
    notifyListeners();
  }

  void setSolution(Question question, String levelId, text) {
    final level = getLevel(levelId);

    question.state.solution = text;
    question.state.solved = true;
    _storeQuestionState(question.state);

    level.state.solved += 1;
    _storeLevelState(level.state);

    final next = _nextLevel(level);
    next.state.locked = _isLevelLocked(next);
    next.state.remainsToUnlock = _remainsToUnlock(next);
    _storeLevelState(next.state);
    notifyListeners();
  }

  static QuestionState _loadOrCreateQuestionState(
      String levelId, String questionId) {
    if (prefs.containsKey(questionId)) {
      final jsonStr = prefs.getString(questionId);
      final Map parsed = json.decode(jsonStr);
      return QuestionState.fromJson(parsed);
    }
    return QuestionState(levelId, questionId);
  }

  static LevelState _loadOrCreateLevelState(String levelId) {
    if (prefs.containsKey(levelId)) {
      final jsonStr = prefs.getString(levelId);
      final Map parsed = json.decode(jsonStr);
      return LevelState.fromJson(parsed);
    }
    return LevelState(levelId);
  }

  static void _storeQuestionState(QuestionState questionState) {
    prefs.setString(questionState.questionId, jsonEncode(questionState));
  }

  static void _storeLevelState(LevelState levelState) {
    prefs.setString(levelState.levelId, jsonEncode(levelState));
  }

  static bool _isLevelLocked(Level level) {
    final previousLevel = _previousLevel(level);
    return previousLevel != null
        ? previousLevel.state.solved <=
            previousLevel.questions.length * level.requiresPct / 100
        : false;
  }

  static int _remainsToUnlock(Level level) {
    final previousLevel = _previousLevel(level);
    return previousLevel != null
        ? previousLevel.questions.length * level.requiresPct ~/ 100 -
            previousLevel.state.solved
        : 0;
  }

  static Level _previousLevel(Level level) {
    final index = _levels.indexOf(level);
    if (index == 0) return null;
    return _levels[index - 1];
  }

  static Level _nextLevel(Level level) {
    final index = _levels.indexOf(level);
    if (index >= _levels.length - 1) return null;
    return _levels[index + 1];
  }
}
