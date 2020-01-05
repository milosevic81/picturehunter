class QuestionModel {
  static Map<String, QuestionState> _questionStates = {};

  static QuestionState getState(questionId) =>
      _questionStates.putIfAbsent(questionId, () => QuestionState());
}

class QuestionState {
  int attempts = 0;
  bool solved = false;
  String solution = "";

  QuestionState();

  void incrementAttempts() {
    attempts += 1;
  }

  void setSolution(String text) {
    this.solved = true;
    this.solution = text;
  }
}
