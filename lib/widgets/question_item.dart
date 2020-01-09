import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/models/question.dart';
import 'package:picturehunter/screens/question_screen.dart';

class QuestionItem extends StatelessWidget {
  final Question question;

  QuestionItem({@required this.question});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, QuestionScreen.routeName,
                  arguments: QuestionArgs(question.state.levelId, question.id));
            },
            child: Image.asset(question.thumb)),
        Visibility(
            visible: question.state.solved,
            child: Image.asset("assets/icons/icons8-checked-48.png")),
      ],
    );
  }
}
