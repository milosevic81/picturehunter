import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/state/levels_model.dart';
import 'package:picturehunter/widgets/fancy_background.dart';
import 'package:picturehunter/widgets/level_list.dart';
import 'package:provider/provider.dart';

class LevelListScreen extends StatelessWidget {
  static const routeName = '/level';

  @override
  Widget build(BuildContext context) {
    final levelsModel = Provider.of<LevelsModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Изабери ниво'),
      ),
      body: Stack(children: <Widget>[
        FancyBackground(),
        LevelList(levels: levelsModel.allLevels())
      ]),
    );
  }
}
