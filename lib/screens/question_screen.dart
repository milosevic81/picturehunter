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
          final guess =
              Checker.checkAnswer(question.solutions, textController.text);
          if (guess == GuessType.GUESSED) {
            levelsModel.setSolution(
                question, args.levelId, textController.text);
            Navigator.pop(context);
          } else if (guess == GuessType.SIMILAR) {
            // TODO: Vlado??? cemu sluzi ovo?
            levelsModel.incrementAttempts(question);
          } else {
            levelsModel.incrementAttempts(question);
          }

          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: GestureDetector(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: getPopupWidget(guess)
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
              );
            },
          );
        },
        tooltip: 'Провери одговор',
        child: Icon(Icons.text_fields),
      ),
    );
  }

  List<Widget> getPopupWidget(GuessType guess) {
    if (guess == GuessType.GUESSED) {
      return <Widget>[
        Image.asset("assets/icons/icons8-checked-96.png"),
        Text("Браво!")
      ];
    } else if (guess == GuessType.SIMILAR) {
      return <Widget>[
        // TODO: Vlado???
        Image.asset("assets/icons/icons8-similar-128.png"),
        Text("Близу си"),
        Text("Покушај поново")
      ];
    } else {
      return <Widget>[
        Image.asset("assets/icons/icons8-error-128.png"),
        Text("Није тачно :("),
        Text("Покушај поново")
      ];
    }
  }

  getInput(context, Question question) => question.state.solved
      ? Image.asset("assets/icons/icons8-checked-96.png")
      : Container(
    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: TextField(
            autofocus: true,
            style: TextStyle(fontSize: 24),
            controller: textController,
            decoration: InputDecoration(hintText: 'Унеси одговор'),
          ),
      );
}



class QuestionArgs {
  final levelId;
  final questionId;

  QuestionArgs(this.levelId, this.questionId);
}
