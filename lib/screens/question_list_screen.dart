import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/models/level.dart';
import 'package:picturehunter/models/question.dart';
import 'package:picturehunter/screens/question_screen.dart';
import 'package:picturehunter/state/repo.dart';

class QuestionListScreen extends StatelessWidget {
  static const routeName = '/task';

  @override
  Widget build(BuildContext context) {
    final TaskArgs args = ModalRoute.of(context).settings.arguments;
    final Level level = Repo.level(args.levelId);

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

  Widget buildQuestionButton(
      BuildContext context, Level level, Question question) {

    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, QuestionScreen.routeName,
                      arguments: QuestionArgs(level.id, question.id));
                },
                padding: EdgeInsets.all(0.0),
                child: Image.asset(question.thumb)),
            Visibility(
                visible: question.state.solved,
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
