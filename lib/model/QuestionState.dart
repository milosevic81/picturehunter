import 'package:picturehunter/state/StateManager.dart';

class QuestionState {
  final String questionId;
  final String levelId;
  int attempts = 0;
  bool solved = false;
  String solution = "";

  QuestionState(this.levelId, this.questionId);

  void incrementAttempts() {
    attempts += 1;
  }

  void setSolution(String text) {
    this.solved = true;
    this.solution = text;
  }

  QuestionState.fromJson(Map parsed)
      : questionId = parsed["questionId"],
        levelId = parsed["levelId"],
        attempts = parsed["attempts"],
        solved = parsed["solved"],
        solution = parsed["solution"];

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "levelId": levelId,
        "attempts": attempts,
        "solved": solved,
        "solution": solution,
      };
}
