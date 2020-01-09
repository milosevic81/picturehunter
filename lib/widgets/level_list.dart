import 'package:flutter/cupertino.dart';
import 'package:picturehunter/models/level.dart';

import 'level_item.dart';

class LevelList extends StatelessWidget {
  final List<Level> levels;

  LevelList({@required this.levels});

  @override
  Widget build(BuildContext context) {
    return ListView(children: getChildrenLevels());
  }

  List<Widget> getChildrenLevels() {
    return levels.map((level) => LevelItem(level: level)).toList();
  }
}
