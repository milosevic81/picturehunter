class LevelState {
  final String levelId;
  int solved = 0;
  bool locked = false;
  int remainsToUnlock = 0;

  LevelState(this.levelId);

  LevelState.fromJson(Map parsed)
      : levelId = parsed["levelId"],
        solved = parsed["solved"];

  Map<String, dynamic> toJson() => {"levelId": levelId, "solved": solved};
}
