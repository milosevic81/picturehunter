import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/models/level.dart';
import 'package:picturehunter/state/levels_model.dart';
import 'package:picturehunter/widgets/fancy_background.dart';
import 'package:picturehunter/widgets/question_list.dart';
import 'package:provider/provider.dart';

class QuestionListScreen extends StatelessWidget {
  static const routeName = '/task';

  @override
  Widget build(BuildContext context) {
    final QuestionListScreenArgs args =
        ModalRoute.of(context).settings.arguments;
    final levelsModel = Provider.of<LevelsModel>(context);
    final Level level = levelsModel.getLevel(args.levelId);

    return Scaffold(
        appBar: AppBar(
          title: Text("${level.name}"),
        ),
        body: Stack(children: <Widget>[
          FancyBackground(),
          Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: QuestionList(questions: level.questions))
        ]));
  }
}

class QuestionListScreenArgs {
  final levelId;

  QuestionListScreenArgs(this.levelId);
}
