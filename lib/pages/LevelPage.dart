import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:picturehunter/model/LevelData.dart';
import 'package:picturehunter/state/StateManager.dart';

import '../Repo.dart';
import 'TaskPage.dart';

class LevelPage extends StatelessWidget {
  static const routeName = '/level';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izaberi nivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView(
          children: Repo.allLevels()
              .map((level) => buildLevelButton(context, level))
              .toList(),
        ),
      ),
    );
  }

  Widget buildLevelButton(context, LevelData level) {
    final state = StateManager.getLevelState(level.id);
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ButtonTheme(
        minWidth: 300,
        height: 70,
        child: RaisedButton(
          child: Row(
            children: <Widget>[
              Text(
                '${level.order}',
                style: TextStyle(color: Colors.white, fontSize: 32),
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
                        visible: state.isLocked(),
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
                              '${"odgovori na jos ${state.remainsToUnlock()} zadataka"}',
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
                '${state.solved} / ${level.questions.length}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          onPressed: () {
            if (state.isLocked()) {
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Icon(Icons.lock,size: 120, color: Colors.orange,),
                  );
                }
              );
            } else {
              Navigator.pushNamed(context, TaskPage.routeName,
                  arguments: TaskArgs(level.id));
            }
          },
        ),
      ),
    );
  }
}
