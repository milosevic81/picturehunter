import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Widget buildLevelButton(context, level) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ButtonTheme(
        minWidth: 300,
        height: 70,
        child: RaisedButton(
          child: Row(
            children: <Widget>[
              Text(
                '${level["order"]}',
                style:
                TextStyle(color: Colors.white, fontSize: 32),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${level["name"]}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 24),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${"odgovori na jos 12 zadata da otkljucas"}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pushNamed(context, TaskPage.routeName,
                arguments: TaskArgs(level["id"]));
          },
        ),
      ),
    );
  }
}
