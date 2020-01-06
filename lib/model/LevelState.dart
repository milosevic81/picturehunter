import 'package:picturehunter/state/StateManager.dart';

import '../Repo.dart';

class LevelState {

  final String levelId;
  int solved = 0;

  bool isLocked() {
    final level = Repo.level(levelId);
    if (level.order == 1) return false;
    final prevLevel = Repo.allLevels()[level.order - 2];
    final prevLevelState = StateManager.getLevelState(prevLevel.id);
    return prevLevelState.solved <= prevLevel.questions.length * level.requiresPct / 100;
  }

  int remainsToUnlock() {
    final level = Repo.level(levelId);
    if (level.order == 1) return 0;
    final prevLevel = Repo.allLevels()[level.order - 2];
    final prevLevelState = StateManager.getLevelState(prevLevel.id);
    return (prevLevel.questions.length * level.requiresPct / 100).toInt() - prevLevelState.solved;
  }

  LevelState(this.levelId);

  void incrementSolved() {
    solved += 1;
  }

  LevelState.fromJson(Map parsed) :
        levelId = parsed["levelId"],
        solved = parsed["solved"];

  Map<String, dynamic> toJson() => {
    "levelId": levelId,
    "solved": solved
  };
}