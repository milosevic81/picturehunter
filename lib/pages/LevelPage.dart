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
        title: Text('Select level'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: Repo.allLevels()
            .map((level) => Center(
                  child: RaisedButton(
                    child: Text('Level: ${level["name"]}'),
                    onPressed: () {
                      Navigator.pushNamed(context, TaskPage.routeName,
                          arguments: TaskArgs(level["id"]));
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
