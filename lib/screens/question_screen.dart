import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/models/level.dart';
import 'package:picturehunter/models/question.dart';
import 'package:picturehunter/state/levels_model.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatelessWidget {
  static const routeName = '/question';

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final QuestionArgs args = ModalRoute.of(context).settings.arguments;
    final levelsModel = Provider.of<LevelsModel>(context);
    final Level level = levelsModel.getLevel(args.levelId);
    final Question question =
        levelsModel.getQuestion(args.levelId, args.questionId);

    return Scaffold(
      appBar: AppBar(
        title: Text(question.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: RaisedButton(
            child: Column(
              children: <Widget>[
                Image.asset(question.image),
                getInput(context, question),
              ],
            ),
            onPressed: () {
              // Navigate to second route when tapped.
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              var correct =
                  checkAnswer(question.solutions, textController.text);
              if (correct) {
                levelsModel.setSolution(
                    question, args.levelId, textController.text);
                return AlertDialog(
                  content: Image.asset("assets/icons/icons8-checked-96.png"),
                );
              } else {
                levelsModel.incrementAttempts(question);
                return AlertDialog(
                  content: Image.asset("assets/icons/icons8-error-128.png"),
                );
              }
            },
          );
        },
        tooltip: 'Check answer',
        child: Icon(Icons.text_fields),
      ),
    );
  }

  checkAnswer(List solutions, String text) {
    var simple = text.toLowerCase().trim();
    return solutions.contains(simple);
  }

  getInput(context, Question question) => question.state.solved
      ? Image.asset("assets/icons/icons8-checked-96.png")
      : TextField(
          controller: textController,
        );
}

class QuestionArgs {
  final levelId;
  final questionId;

  QuestionArgs(this.levelId, this.questionId);
}
