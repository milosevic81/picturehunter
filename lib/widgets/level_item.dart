import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/models/level.dart';
import 'package:picturehunter/screens/question_list_screen.dart';
import 'package:picturehunter/util/plural_helper.dart';

class LevelItem extends StatelessWidget {
  final Level level;

  LevelItem({@required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ButtonTheme(
        height: 70,
        child: RaisedButton(
          child: Row(
            children: <Widget>[
              Text(
                '${level.order}',
                style: TextStyle(color: Colors.white, fontSize: 42),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${level.name}',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.start,
                      ),
                      Visibility(
                        visible: level.state.locked,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            Text(
                              getSolveMoreString(level.state.remainsToUnlock),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '${level.state.solved} / ${level.questions.length}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          onPressed: () {
            if (level.state.locked) {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                        child: AlertDialog(
                          content: Icon(
                            Icons.lock,
                            size: 120,
                            color: Colors.orange,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        });
                  });
            } else {
              Navigator.pushNamed(context, QuestionListScreen.routeName,
                  arguments: QuestionListScreenArgs(level.id));
            }
          },
        ),
      ),
    );
  }

  String getSolveMoreString(remainsToUnlock) {
    switch (Plurals.getPluralForm(remainsToUnlock)) {
      case 0: { return 'Реши још $remainsToUnlock задатак'; }
      case 1: { return 'Реши још $remainsToUnlock задатка'; }
      case 2: { return 'Реши још $remainsToUnlock задатака'; }
      default: { throw new FormatException(); }
    }
  }
}
