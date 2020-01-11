import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/models/question.dart';
import 'package:picturehunter/state/levels_model.dart';
import 'package:picturehunter/util/checker.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatelessWidget {
  static const routeName = '/question';

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final QuestionArgs args = ModalRoute.of(context).settings.arguments;
    final levelsModel = Provider.of<LevelsModel>(context);
    final Question question =
        levelsModel.getQuestion(args.levelId, args.questionId);

    return Scaffold(
      appBar: AppBar(
        title: Text(question.title),
      ),
      body: SingleChildScrollView(
        child: Consumer<LevelsModel>(
          builder: (context, levelsModel, child) {
            final Question question = Provider.of<LevelsModel>(context)
                .getQuestion(args.levelId, args.questionId);
            return Column(
              children: <Widget>[
                Image.asset(question.image),
                getInput(context, question),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final correct =
              Checker.checkAnswer(question.solutions, textController.text);
          if (correct) {
            levelsModel.setSolution(
                question, args.levelId, textController.text);
            Navigator.pop(context);
          } else {
            levelsModel.incrementAttempts(question);
          }

          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: correct
                      ? <Widget>[
                          Image.asset("assets/icons/icons8-checked-96.png"),
                          Text("Bravo!")
                        ]
                      : <Widget>[
                          Image.asset("assets/icons/icons8-error-128.png"),
                          Text("Nije tacno :("),
                          Text("Pokusaj ponovo")
                        ],
                ),
              );
            },
          );
        },
        tooltip: 'Check answer',
        child: Icon(Icons.text_fields),
      ),
    );
  }

  getInput(context, Question question) => question.state.solved
      ? Image.asset("assets/icons/icons8-checked-96.png")
      : TextField(
          autofocus: true,
          controller: textController,
          decoration: InputDecoration(hintText: 'Unesi odgovor'),
        );
}

class QuestionArgs {
  final levelId;
  final questionId;

  QuestionArgs(this.levelId, this.questionId);
}
