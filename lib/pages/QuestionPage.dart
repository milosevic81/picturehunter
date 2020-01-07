import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/model/QuestionData.dart';
import 'package:picturehunter/model/QuestionState.dart';
import 'package:picturehunter/state/StateManager.dart';

import '../Repo.dart';

class QuestionPage extends StatelessWidget {
  static const routeName = '/question';

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final QuestionArgs args = ModalRoute.of(context).settings.arguments;
    final QuestionData question = Repo.question(args.levelId, args.questionId);
    final QuestionState questionState =
        StateManager.getQuestionState(args.levelId, question.id);

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
                getInput(context, questionState),
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
                StateManager.setSolution(
                    args.levelId, args.questionId, textController.text);
                return AlertDialog(
                  content: Image.asset("assets/icons/icons8-checked-96.png"),
                );
              } else {
                StateManager.incrementAttempts(args.levelId, args.questionId);
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

  getInput(context, questionState) => questionState.solved
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
