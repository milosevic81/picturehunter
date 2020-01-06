import 'dart:convert';

import '../Repo.dart';
import '../model/LevelState.dart';
import '../model/QuestionState.dart';

class StateManager {

  static Map<String, QuestionState> _questionStates = {};
  static Map<String, LevelState> _levelStates = {};

  static LevelState getLevelState(String levelId) =>
      _levelStates.putIfAbsent(levelId, () => _loadOrCreateLevelState(levelId));

  static QuestionState getQuestionState(String levelId, String questionId) =>
      _questionStates.putIfAbsent(
          questionId, () => _loadOrCreateQuestionState(levelId, questionId));

  /// Loads a question state from pref or creates a new one
  static QuestionState _loadOrCreateQuestionState(
      String levelId, String questionId) {
    if (Repo.prefs.containsKey(questionId)) {
      final jsonStr = Repo.prefs.getString(questionId);
      final Map parsed = json.decode(jsonStr);
      return QuestionState.fromJson(parsed);
    }
    return QuestionState(levelId, questionId);
  }

  /// Loads a level state from pref or creates a new one
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

  static void incrementQuestionsSolved(String levelId) {
    final state = getLevelState(levelId);
    state.incrementSolved();
    _storeLevelState(state);
  }

  static void incrementAttempts(String levelId, String questionId) {
    final state = getQuestionState(levelId, questionId);
    state.incrementAttempts();

    _storeQuestionState(state);
  }

  static void setSolution(String levelId, String questionId, String text) {
    final state = getQuestionState(levelId, questionId);
    state.setSolution(text);

    _storeQuestionState(state);
    incrementQuestionsSolved(levelId);
  }
}
