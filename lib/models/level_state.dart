import 'package:flutter/cupertino.dart';

import '../state/repo.dart';

class LevelState extends ChangeNotifier {
  final String levelId;
  int solved = 0;

  bool isLocked() {
    final level = Repo.level(levelId);
    final previousLevel = Repo.previousLevel(levelId);

    return previousLevel != null
        ? previousLevel.state.solved <=
            previousLevel.questions.length * level.requiresPct / 100
        : false;
  }

  int remainsToUnlock() {
    final level = Repo.level(levelId);
    final previousLevel = Repo.previousLevel(levelId);

    return previousLevel != null
        ? previousLevel.questions.length * level.requiresPct ~/ 100 -
            previousLevel.state.solved
        : 0;
  }

  LevelState(this.levelId);

  void incrementSolved() {
    solved += 1;
    notifyListeners();
  }

  LevelState.fromJson(Map parsed)
      : levelId = parsed["levelId"],
        solved = parsed["solved"];

  Map<String, dynamic> toJson() => {"levelId": levelId, "solved": solved};
}
