import 'package:flutter/cupertino.dart';
import 'package:picturehunter/state/state_management.dart';

import '../Repo.dart';

class LevelState extends ChangeNotifier {
  final String levelId;
  int solved = 0;

  bool isLocked() {
    final level = Repo.level(levelId);
    final allLevels = Repo.allLevels();
    final index = allLevels.indexOf(level);
    if (index == 0) return false;
    final prevLevel = allLevels[index - 1];
    final prevLevelState = StateManager.getLevelState(prevLevel.id);
    return prevLevelState.solved <=
        prevLevel.questions.length * level.requiresPct / 100;
  }

  int remainsToUnlock() {
    final level = Repo.level(levelId);
    final allLevels = Repo.allLevels();
    final index = allLevels.indexOf(level);
    if (index == 0) return 0;
    final prevLevel = allLevels[index - 1];
    final prevLevelState = StateManager.getLevelState(prevLevel.id);
    return (prevLevel.questions.length * level.requiresPct / 100).toInt() -
        prevLevelState.solved;
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
