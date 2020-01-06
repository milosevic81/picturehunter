import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/model/LevelData.dart';
import 'package:picturehunter/model/QuestionData.dart';
import 'package:picturehunter/state/StateManager.dart';
import 'package:picturehunter/pages/QuestionPage.dart';

import '../Repo.dart';

class TaskPage extends StatelessWidget {
  static const routeName = '/task';

  @override
  Widget build(BuildContext context) {
    final TaskArgs args = ModalRoute.of(context).settings.arguments;
    final LevelData level = Repo.level(args.levelId);

    return Scaffold(
      appBar: AppBar(
        title: Text(level.name),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          children: (level.questions)
              .map((question) => buildQuestionButton(context, level, question))
              .toList(),
        ),
      ),
    );
  }

  Widget buildQuestionButton(BuildContext context, LevelData level, QuestionData question) {
    var questionState = StateManager.getQuestionState(level.id, question.id);
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, QuestionPage.routeName,
                      arguments: QuestionArgs(level.id, question.id));
                },
                padding: EdgeInsets.all(0.0),
                child: Image.asset(question.thumb)),
            Visibility(
                visible: questionState.solved,
                child: Image.asset("assets/icons/icons8-checked-48.png")),
          ],
        ),
      ),
    );
  }
}

class TaskArgs {
  final levelId;

  TaskArgs(this.levelId);
}
